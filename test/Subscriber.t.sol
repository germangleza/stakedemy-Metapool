// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// import "../src/Subscriber.sol";
import "../src/IStakedVault.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "./utils/Utilities.sol";

/*
Addresses of the deployed contracts:
 - AuroraToken 💚: ----- 0x8BEc47865aDe3B172A928df8f990Bc7f2A3b9f79
 - AuroraPlus: --------- 0xccc2b1aD21666A5847A804a73a41F904C4a4A0Ec
 - StakingManager: ----- 0x0db2E0AF08757b1a50768a59C27D3EEE716809c0
 - Depositor 00: ------- 0xa1B107aF89c773e73F3cb796368953566e6D9Cd1
 - Depositor 01: ------- 0xF86100ce765cAE7E6C2aBD1e7555924677EFf7C7
 - StakedAuroraVault: -- 0xb01d35D469703c6dc5B369A1fDfD7D6009cA397F
 - LiquidityPool: ------ 0x2b22F6ae30DD752B5765dB5f2fE8eF5c5d2F154B
 - ERC4626Router: ------ 0x21DEe40eFebB1F68D58FC2e2b6a0d2D0c7e87403
 */

contract SubscriberTest is Test {
    uint internal auroraFork;
    // Subscriber internal subscriber;
    IStakedVault internal vault;
    IERC20 internal aur;
    Utilities internal utils;

    address[] internal users;
    address internal bob;
    address internal david;

    uint internal DECIMALS = 10 ** 18;

    function setUp() public {
        auroraFork = vm.createFork("https://mainnet.aurora.dev");
        vault = IStakedVault(address(0xb01d35D469703c6dc5B369A1fDfD7D6009cA397F));
        aur = IERC20(address(0x8BEc47865aDe3B172A928df8f990Bc7f2A3b9f79));

        // subscriber = new Subscriber();
        utils = new Utilities();
        users = utils.createUsers(5);

        bob = users[0];
        david = users[1];

        vm.startPrank(address(0x23085597C58A6dcAcF94161Cbf43F5f684BCb0a9)); //address with a lot of aurora 
        aur.transfer(address(bob), 500 * DECIMALS);
        vm.stopPrank();

        vm.startPrank(address(0xd6E4be59FF015aFeFce9b9a78b1cF61be1027cF1));
        vault.whitelistAccount(bob);
        vault.whitelistAccount(david);
        vm.stopPrank();
    }

    function testProtocolInteraction() public {
        vm.startPrank((bob));
        uint bal = aur.balanceOf(bob);
        assertEq(bal, 500 * DECIMALS);
        aur.approve(address(vault), bal);
        uint shares = vault.deposit(bal, bob);
        uint aurPrice = vault.getStAurPrice();
        uint initValue = (shares * aurPrice) / DECIMALS;
        assertEq(initValue, 1);
        vm.stopPrank();
        vm.warp(365 days);
        uint secondPrice = vault.getStAurPrice();
        uint secondValue = (shares * secondPrice) /DECIMALS;
        assertEq(secondValue, 1);
        vm.stopPrank();
       
    }
}
