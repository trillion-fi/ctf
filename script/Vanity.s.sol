// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.7.6;

import "forge-std/Script.sol";
import "forge-std/Test.sol";
import "../src/Vanity/contracts/Setup.sol";

contract VanityScript is Script {
    Setup setup;
    function setUp() public {
        setup = Setup(0x02e6f6bb3AA1fffd285c95c05ea33D21E124E7dD);
    }

    function run() public {
        vm.startBroadcast();
        bytes memory signature = hex"74bddd646a036561";
        setup.challenge().solve(0x0000000000000000000000000000000000000002,
            signature
        );
    }
}