// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

interface IStakedVault {
    function deposit(
        uint256 _assets,
        address _receiver
    ) external returns (uint256);

    function withdraw(
        uint256 _assets,
        address _receiver,
        address _owner
    ) external returns (uint256);

    function redeem(
        uint256 _shares,
        address _receiver,
        address _owner
    ) external returns (uint256);

    function completeDelayUnstake(uint256 _assets, address _receiver) external;
    function whitelistAccount(address _account) external;
    function convertToAssets(uint256 _shares) external view returns (uint256 _assets);
    function getStAurPrice() external view returns (uint256);
}
