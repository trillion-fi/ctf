// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.7.6;

import "forge-std/Script.sol";
import "forge-std/Test.sol";
import "../src/Vanity/contracts/Setup.sol";

contract VanityScript is Script {
    Setup setup;
    function setUp() public {
        setup = new Setup();
    }

    function run() public {
        bytes memory signature = hex"74bddd646a036561";
        setup.challenge().solve(0x0000000000000000000000000000000000000002,
            signature
        );
        console2.log("solved?", setup.isSolved());
    }
}