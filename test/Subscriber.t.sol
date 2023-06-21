// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/Subscriber.sol";
import "../src/interfaces/IStakingManager.sol";

/*
Addresses of the deployed contracts:
 - AuroraToken 💚: ----- 0x8BEc47865aDe3B172A928df8f990Bc7f2A3b9f79
 - AuroraPlus: --------- 0xccc2b1aD21666A5847A804a73a41F904C4a4A0Ec
 - StakingManager: ----- 0x0db2E0AF08757b1a50768a59C27D3EEE716809c0
 - Depositor 00: ------- 0xa1B107aF89c773e73F3cb796368953566e6D9Cd1
 - Depositor 01: ------- 0xF86100ce765cAE7E6C2aBD1e7555924677EFf7C7
 - StakedAuroraVault: -- 0x2262148E0d327Fa4bcC7882c0f2Bb2D4139Cd0E7
 - LiquidityPool: ------ 0x4162858459aE2B949Bc24d5383e33963A46CBB63
 - ERC4626Router: ------ 0x21DEe40eFebB1F68D58FC2e2b6a0d2D0c7e87403
 */

contract SubscriberTest is Test { 
    Subscriber internal subscriber;
    IStakingManager internal stakingManager;

}