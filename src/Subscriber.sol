// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./IStakedVault.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract Subscriber {
    struct WithdrawOrder {
        uint toAcademy;
        uint toMember;
    }
    mapping(address => uint) public balance;
    mapping(address => bool) public member;
    mapping(address => uint) public nextWithdraw;
    mapping(address => WithdrawOrder) public orders;

    address public constant TREASURY_ACCOUNT = 0xdcFefaE77b026ad1e1D4A783F1eB761924DB7Dc6;

    uint public TIME_SUBSCRIPTION_LOCK = 365 days;
    

    IStakedVault public vault;
    IERC20 public auroraToken;
    uint public minSubscription;

    uint public constant FEE = 3 * 10 ** 16; //3%


    constructor(address _vault, address _aur) {
        vault = IStakedVault(_vault);
        auroraToken = IERC20(_aur);
    }

    modifier onlyMember() {
        isMember(msg.sender);
        _;
    }

    function subscribe(uint256 _assets) public {
        require(_maxAssets(msg.sender) >= minSubscription, "Not enought funds");
        auroraToken.approve(address(vault), _assets);
        uint shares = vault.deposit(_assets, address(this));
        member[msg.sender] = true;
        nextWithdraw[msg.sender] = block.timestamp + 1 days;
        balance[msg.sender] = shares;
    }
    function redeem() public onlyMember{
        require(_canWithdraw(msg.sender), "Can't redeem");
        uint assets = vault.redeem(
            balance[msg.sender],
            address(this),
            address(this)
        );
        balance[msg.sender] = 0;
        member[msg.sender] = false;
        uint transferToAcademy = (assets * FEE);
        uint transferToMember = assets - (assets * FEE);
        orders[msg.sender] = WithdrawOrder(transferToAcademy, transferToMember);
    }

    function withdraw() public onlyMember {
        WithdrawOrder memory order = orders[msg.sender];
        vault.completeDelayUnstake(order.toAcademy, (TREASURY_ACCOUNT));
        vault.completeDelayUnstake(order.toMember, msg.sender);
    }

    function isMember(address _account) public view returns (bool) {
        return member[_account];
    }

     function _maxAssets(address _member) internal view returns (uint) {
        return auroraToken.balanceOf(_member);
    }

    function _canWithdraw(address _member) internal view returns (bool){
        return nextWithdraw[_member] <= block.timestamp;
    }


    receive() external payable {}
}
