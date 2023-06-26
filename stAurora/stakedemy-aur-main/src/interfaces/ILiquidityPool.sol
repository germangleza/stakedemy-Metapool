// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

interface ILiquidityPool {
    event AddLiquidity(address indexed _sender, address indexed _receiver, uint256 _auroraAmount, uint256 _lpTokenAmount);
    event ContractUpdateOperation(bool _isFullyOperational, address _sender);
    event StAurLiquidityProvidedByPool(address indexed _receiver, uint256 _stAurAmount, uint256 _auroraAmount);
    event SwapStAur(address indexed _user, uint256 _auroraAmount, uint256 _stAurAmount, uint256 _totalFee);
    event UpdateFeeBasisPoints(uint256 _new, address _sender);
    event UpdateLiqProvFeeBasisPoints(uint256 _new, address _sender);
    event UpdateMinDepositAmount(uint256 _new, address _sender);
    event WithdrawCollectedFees(address _receiver, uint256 _amount, address _sender);

    function isStAurBalanceAvailable(uint256 _amount) external view returns(bool);
    function previewSwapStAurForAurora(uint256 _amount) external view returns (uint256);
    function swapStAurForAurora(uint256 _stAurAmount, uint256 _minAuroraToReceive) external;
    function transferStAur(address _receiver, uint256 _amount, uint256 _assets) external;

    error InvalidBasisPoints();
    error InvalidZeroAddress();
    error InvalidZeroAmount();
    error LessThanMinDeposit();
    error NotEnoughBalance();
    error SlippageError();
    error Unauthorized();
}