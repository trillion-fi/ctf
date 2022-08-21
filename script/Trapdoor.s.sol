// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.16;

library console {
    address constant CONSOLE_ADDRESS = address(0x000000000000000000636F6e736F6c652e6c6f67);

    function _sendLogPayload(bytes memory payload) private view {
        uint256 payloadLength = payload.length;
        address consoleAddress = CONSOLE_ADDRESS;
        assembly {
            let payloadStart := add(payload, 32)
            let r := staticcall(gas(), consoleAddress, payloadStart, payloadLength, 0, 0)
        }
    }

    function log(string memory p0, uint256 p1, uint256 p2, uint256 p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint,uint,uint)", p0, p1, p2, p3));
    }
}

interface FactorizorLike {
    function factorize(uint) external pure returns (uint, uint);
}

contract Deployer {
    constructor(bytes memory code) { assembly { return (add(code, 0x20), mload(code)) } }
}

contract Script {
    function run() external {
        uint expected = 15;

        FactorizorLike factorizer = FactorizorLike(address(new Deployer(hex"608060405234801561001057600080fd5b506004361061002b5760003560e01c80631b3abba014610030575b600080fd5b61004361003e366004610144565b61005c565b6040805192835260208301919091520160405180910390f35b60008060006040516024016100ae9060208082526023908201527f310d0a320d0a796f7520666163746f72656420746865206e756d626572211b5b60408201526233410d60e81b606082015260800190565b60408051601f198184030181529181526020820180516001600160e01b031663104c13eb60e21b179052519091506a636f6e736f6c652e6c6f67906100f490839061015d565b600060405180830381855afa9150503d806000811461012f576040519150601f19603f3d011682016040523d82523d6000602084013e610134565b606091505b5060039660069650945050505050565b60006020828403121561015657600080fd5b5035919050565b6000825160005b8181101561017e5760208186018101518583015201610164565b50600092019182525091905056fea2646970667358221220922867966616e9011afc67795343fb20087ff0d7230f1cc9ca45dd049810d9d464736f6c63430008100033")));
        (uint a, uint b) = factorizer.factorize(expected);

        if (a > 1 && b > 1 && a != expected && b != expected && a != b && expected % a == 0 && expected % b == 0) {
            console.log("you factored the number! %d * %d = %d", a, b, expected);
        } else {
            console.log("you didn't factor the number. %d * %d != %d", a, b, expected);
        }
    }
}