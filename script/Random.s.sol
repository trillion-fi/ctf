// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.15;

import "forge-std/Script.sol";
import "../src/Random/contracts/Setup.sol";
import "../src/Random/contracts/Random.sol";

// forge script script/Random.s.sol --private-key 0x92ef072e8654bb96d45ea6496c29bc731549ad9fcfffedb4747929bd834e7049 --rpc-url http://34.66.135.107:8545/9d0a1afc-bf85-4985-895b-9b888b5def95 --broadcast
contract RandomScript is Script {
    function setUp() public {
        vm.createSelectFork("ctf");
    }
    function run() public {
        vm.startBroadcast();
        Setup setup = Setup(0x9A562DA7b13bD56773B5d9dfD24249f37C64b78b);
        Random random = setup.random();
        random.solve(4);
        console2.log(random.solved());
        console2.log(setup.isSolved());
    }
}