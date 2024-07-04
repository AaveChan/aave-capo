// SPDX-License-Identifier: GPLv3
pragma solidity ^0.8.19;

import {IChainlinkAggregator} from 'cl-synchronicity-price-adapter/interfaces/IChainlinkAggregator.sol';
import {ISDPriceAggregator} from '../../src/interfaces/ISDPriceAggregator.sol';
import {SDOracle} from '../../src/contracts/SDOracle.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import 'forge-std/Test.sol';
import {CapAdaptersCodeEthereum} from '../../scripts/DeployEthereum.s.sol';

contract SDOracleTest is Test {
	function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20000000);
	}

	function test_all() public {
		SDOracle oracle = SDOracle(GovV3Helpers.deployDeterministic(CapAdaptersCodeEthereum.SDOracleCode()));
		int256 price = oracle.latestAnswer();
		ISDPriceAggregator sd = ISDPriceAggregator(CapAdaptersCodeEthereum.SD_ETH_ORACLE);
		IChainlinkAggregator cl = IChainlinkAggregator(CapAdaptersCodeEthereum.ETH_USD_ORACLE);
		int256 expectedPrice = int256(sd.getSDPriceInETH()) * cl.latestAnswer();

		console.log('Price feed', oracle.description());
		console.log('at address', address(oracle));
		console.log('Price', uint256(price));
		console.log('Expected', uint256(expectedPrice));
		console.log('with', oracle.decimals(), 'decimals');
		assertEq(price, expectedPrice);
	}
}
