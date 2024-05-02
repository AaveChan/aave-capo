// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import {IPriceCapAdapterStable, IChainlinkAggregator} from '../src/interfaces/IPriceCapAdapterStable.sol';
import {PriceCapAdapterStable} from '../src/contracts/PriceCapAdapterStable.sol';

library CapAdaptersStablesCodeEthereum {
  bytes public constant USDT_ADAPTER_CODE =
    abi.encodePacked(
      type(PriceCapAdapterStable).creationCode,
      abi.encode(
        IPriceCapAdapterStable.CapAdapterStableParams({
          aclManager: AaveV3Ethereum.ACL_MANAGER,
          assetToUsdAggregator: IChainlinkAggregator(AaveV3EthereumAssets.USDT_ORACLE),
          adapterDescription: 'Capped USDT/USD',
          priceCap: int256(1.04 * 1e8)
        })
      )
    );
}
