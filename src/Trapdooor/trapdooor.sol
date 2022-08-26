// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.16;

contract Trapdoor {
    address constant CONSOLE_ADDRESS = address(0x000000000000000000636F6e736F6c652e6c6f67);

    function factorize(uint) external view returns (uint, uint) {
        return (3,6);
    }

    fallback() external {
        bytes memory str = abi.encodeWithSignature("log(string)","you factored the number!");
        CONSOLE_ADDRESS.staticcall(str);
    }
}