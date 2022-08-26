// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.16;

import "forge-std/Script.sol";
import "forge-std/Test.sol";
import "../src/SourceCode/contracts/Setup.sol";

contract SourceCodeScript is Script {
    Setup setup;

    function setUp() public {
        setup = new Setup();
    }


    // https://www.evm.codes/playground?unit=Wei&codeType=Mnemonic&code='v7w806011526000526070600e536023600ef3yDUP1~11z~00z~70~0ez8~23~0eyRETURN'~yvwzyMSTOREy%5Cnw%200xvPUSH1%01vwyz~_
    // PUSH17 0x806011526000526070600e536023600ef3
    // DUP1
    // PUSH1 0x11
    // MSTORE
    // PUSH1 0x00
    // MSTORE
    // PUSH1 0x70
    // PUSH1 0x0e
    // MSTORE8
    // PUSH1 0x23
    // PUSH1 0x0e
    // RETURN
    function run() public {
        setup.challenge().solve(hex"70806011526000526070600e536023600ef3806011526000526070600e536023600ef3");
        console2.log("solved?", setup.challenge().solved());
    }
}