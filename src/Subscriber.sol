// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./IStakedVault.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

/// @title Stakedemy Subscriber Contract
/// @author Edward Vergel - @EdwardsVO

contract Subscriber is Ownable {
    /// Struct that save transfer amounts when user redeems
    struct WithdrawOrder {
        uint toAcademy;
        uint toMember;
    }
    /// User balances inside the contract
    mapping(address => uint) public balance;
    /// Returns the Stakedemy Members
    mapping(address => bool) public member;
    /// Next withdraw per member
    mapping(address => uint) public nextWithdraw;
    /// Withdraw orders before be executed
    /// @dev Metapool requires two days before withdraw. To handle this we create the WithdrawOrder
    mapping(address => WithdrawOrder) public orders;

    /// @dev Vault version 0.1.0
    /// require: be whitelisted
    IStakedVault public vault;
    IERC20 public auroraToken;

    address public constant TREASURY_ACCOUNT =
        0xdcFefaE77b026ad1e1D4A783F1eB761924DB7Dc6;
    /// 1 Aurora per subscription
    uint public constant SUBSCRIPTION_PRICE = 1 * 10 ** 18;
    /// 3% FEE per withdraw
    uint public constant FEE = 3 * 10 ** 16; //3%
    /// Fixed subscription per member
    uint public constant TIME_SUBSCRIPTION_LOCK = 365 days;

    /// For deploying subscriber it's needed
    /// @param _vault Staked Aurora Vault V0.1.0
    /// @dev _vault =  0xb01d35D469703c6dc5B369A1fDfD7D6009cA397F
    /// @param _aur Aurora Token Address
    /// @dev _aur = 0x8BEc47865aDe3B172A928df8f990Bc7f2A3b9f79
    constructor(address _vault, address _aur) {
        vault = IStakedVault(_vault);
        auroraToken = IERC20(_aur);
    }

    /// Checks if the user it's subscribed
    modifier onlyMember() {
        isMember(msg.sender);
        _;
    }

    /// Subscription method to be part of Stakedemy.
    /// It handle the metapool liquid staking functions and return the shares amount obtained by the user
    /// @param _assets aurora tokens that will be deposited by the user
    /// Require: User enoguht funds
    /// @dev User must approve the Aurora tokens movement
    function subscribe(uint256 _assets) public returns (uint) {
        require(
            _maxAssets(msg.sender) >= SUBSCRIPTION_PRICE,
            "Not enought funds"
        );
        // Transfer tokens from user to the contract
        auroraToken.transferFrom(msg.sender, address(this), _assets);
        // Approve the Metapool aurora vault for moving funds
        auroraToken.approve(address(vault), _assets);
        // Stake the funds and get the shares
        uint shares = vault.deposit(_assets, address(this));
        // User it's now subscriber and can access the content
        member[msg.sender] = true;
        // Set next withdraw period
        nextWithdraw[msg.sender] = block.timestamp + TIME_SUBSCRIPTION_LOCK;
        // Save the user balance
        balance[msg.sender] += shares;
        return shares;
    }

    /// Redeem the assets once the time it's completed
    /// Require: User need to have funds for withdraw and time must be completed
    /// Require: Caller must be member
    /// @dev This function must be called once, then it is mandatory to wait two days before the final withdraw by metapool rules
    /// @dev after two days the withdraw() function must be called
    function redeem() public onlyMember {
        require(_canWithdraw(msg.sender), "Can't redeem");
        // Redeem metapool function
        uint assets = vault.redeem(
            balance[msg.sender],
            address(this),
            address(this)
        );
        // Set member balance to 0
        balance[msg.sender] = 0;
        // Removing member from subscriptions
        member[msg.sender] = false;
        // Get the academy rewards
        uint transferToAcademy = (assets * FEE);
        // Get the user rewards
        uint transferToMember = assets - (assets * FEE);
        // Create the the withdraw order
        orders[msg.sender] = WithdrawOrder(transferToAcademy, transferToMember);
    }

    /// Withdraw the assets once the delay time in metapool it's completed
    /// Require: Caller must be member
    /// @dev This function must be called once, then it is mandatory to wait two days before the final withdraw by metapool rules
    function withdraw() public onlyMember {
        // Get the order created by the redeem() function
        WithdrawOrder memory order = orders[msg.sender];
        // Send the funds from metapool contract
        vault.completeDelayUnstake(order.toAcademy, (address(this)));
        vault.completeDelayUnstake(order.toMember, msg.sender);
    }

    /// Withdraw the contract rewards
    /// Require: Caller must be owner
    function withdrawFunds() public onlyOwner {
        uint bal = auroraToken.balanceOf(address(this));
        auroraToken.transfer(TREASURY_ACCOUNT, bal);
    }

    /// Return if user it's member
    /// @param _account User account
    function isMember(address _account) public view returns (bool) {
        return member[_account];
    }

    /// Return the user available balance
    /// @param _member Member account
    function _maxAssets(address _member) internal view returns (uint) {
        return auroraToken.balanceOf(_member);
    }

    /// Return if user stake reach the holding period
    /// @param _member Member account
    function _canWithdraw(address _member) internal view returns (bool) {
        return nextWithdraw[_member] <= block.timestamp;
    }

    receive() external payable {}
}
