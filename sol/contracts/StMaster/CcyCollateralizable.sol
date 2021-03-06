// SPDX-License-Identifier: AGPL-3.0-only - (c) AirCarbon Pte Ltd - see /LICENSE.md for Terms
// Author: https://github.com/7-of-9
// Certik (AD): locked compiler version
pragma solidity 0.8.5;

import "./StLedger.sol";

import "../Interfaces/StructLib.sol";
import "../Libs/CcyLib.sol";

 /**
  * @title Collateralizable Currencies
  * @author Dominic Morris (7-of-9)
  * @notice Collateralizable is configured for fiat and other collateralizable currencies
  * @dev contains all operations related to fiat and other currency type collateral management
  * <pre>   - inherits StLedger security token ledger contract</pre>
  * <pre>   - inherits Owned ownership smart contract</pre>
  * <pre>   - uses StructLib interface library</pre>
  * <pre>   - uses CcyLib runtime library</pre>
  */
abstract contract Collateralizable is
    StLedger {

//#if process.env.CONTRACT_TYPE !== 'CASHFLOW_BASE'
    /**
    * @dev add supporting currency types
    * @param name name of the currency
    * @param unit unit of the currency
    * @param decimals level of precision of the currency
    */
    function addCcyType(string memory name, string memory unit, uint16 decimals)
    public onlyOwner() onlyWhenReadWrite() {
        CcyLib.addCcyType(ld, ctd, name, unit, decimals);
    }

    /**
    * @dev returns the current supporting currencies
    * @return ccyTypes
    * @param ccyTypes array of supporting currency types struct
    */
    function getCcyTypes() external view returns (StructLib.GetCcyTypesReturn memory ccyTypes) {
        return CcyLib.getCcyTypes(ctd);
    }

    /**
    * @dev fund or withdraw currency type collaterised tokens from a ledger owner address
    * @param direction 0: FUND<br/>1: WITHDRAW
    * @param ccyTypeId currency type identifier
    * @param amount amount to be funded or withdrawn
    * @param ledgerOwner account address to be funded or withdrawn from
    * @param desc supporting evidence like bank wire reference or comments
    */
    function fundOrWithdraw(
        StructLib.FundWithdrawType direction,
        uint256 ccyTypeId,
        int256  amount,
        address ledgerOwner,
        string  calldata desc)
    public onlyOwner() onlyWhenReadWrite() {
        CcyLib.fundOrWithdraw(ld, ctd, direction, ccyTypeId, amount, ledgerOwner, desc);
    }

    // 24k
    // function getTotalCcyFunded(uint256 ccyTypeId)
    // external view returns (uint256) {
    //     return ld._ccyType_totalFunded[ccyTypeId];
    // }
    // function getTotalCcyWithdrawn(uint256 ccyTypeId)
    // external view returns (uint256) {
    //     return ld._ccyType_totalWithdrawn[ccyTypeId];
    // }
//#endif
}
