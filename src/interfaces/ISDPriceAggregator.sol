// SPDX-License-Identifier: GPLv3
pragma solidity ^0.8.19;

interface ISDPriceAggregator {
	function getSDPriceInETH() external view returns (uint256);
}
