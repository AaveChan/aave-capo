// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {IChainlinkAggregator} from 'cl-synchronicity-price-adapter/interfaces/IChainlinkAggregator.sol';
import {ISDPriceAggregator} from '../interfaces/ISDPriceAggregator.sol';

contract SDOracle {

	address immutable SD_ETH_ORACLE;
	address immutable ETH_USD_ORACLE;
	uint8 immutable DECIMALS;
	string public description;

	constructor(address _SDEthOracle, address _EthUsdOracle, string memory _description)
	{
		SD_ETH_ORACLE = _SDEthOracle;
		ETH_USD_ORACLE = _EthUsdOracle;
		DECIMALS = 18 + IChainlinkAggregator(ETH_USD_ORACLE).decimals();
		description = _description;
	}

	function decimals() external view returns (uint8)
	{
		return DECIMALS;
	}

  function latestAnswer() external view returns (int256)
  {
	  return int256(ISDPriceAggregator(SD_ETH_ORACLE).getSDPriceInETH()) * IChainlinkAggregator(ETH_USD_ORACLE).latestAnswer();
  }

  function latestTimestamp() external view returns (uint256)
  {
	  return IChainlinkAggregator(ETH_USD_ORACLE).latestTimestamp();
  }

  function latestRound() external view returns (uint256)
  {
	  revert('not implemented');
	  return 0;
  }

  function getAnswer(uint256 roundId) external view returns (int256)
  {
	  revert('not implemented');
	  return 0;
  }

  function getTimestamp(uint256 roundId) external view returns (uint256)
  {
	  revert('not implemented');
	  return 0;
  }
}
