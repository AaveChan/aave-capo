// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import '../BaseTest.sol';

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {tETHPriceCapAdapter} from '../../src/contracts/lst-adapters/tETHPriceCapAdapter.sol';
import {CapAdaptersCodeEthereum} from '../../scripts/DeployEthereum.s.sol';

contract tETHPriceCapAdapterTest is BaseTest {
  constructor()
    BaseTest(
      CapAdaptersCodeEthereum.tETHAdapterCode(),
      30,
      ForkParams({network: 'mainnet', blockNumber: 22447273}),
      'tETH_Ethereum'
    )
  {}

  function _createAdapter(
    IPriceCapAdapter.CapAdapterParams memory capAdapterParams
  ) internal override returns (IPriceCapAdapter) {
    return new tETHPriceCapAdapter(capAdapterParams);
  }
}
