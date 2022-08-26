// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.15;

import "forge-std/Script.sol";
import "../src/Random/contracts/Setup.sol";
import "../src/Random/contracts/Random.sol";

contract RandomScript is Script {
    Setup setup;
    function setUp() public {
        setup = new Setup();
    }

    function run() public {
        Random random = setup.random();
        random.solve(4);
        console2.log("solved?", setup.isSolved());
    }
}