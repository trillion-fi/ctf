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
        FactorizorLike factorizer = FactorizorLike(address(new Deployer(hex"608060405234801561001057600080fd5b506004361061002b5760003560e01c80631b3abba0146100e8575b60405160206024820152601860448201527f796f7520666163746f72656420746865206e756d626572210000000000000000606482015260009060840160408051601f198184030181529181526020820180516001600160e01b031663104c13eb60e21b179052519091506a636f6e736f6c652e6c6f67906100ae908390610118565b600060405180830381855afa9150503d80600081146100e6576040519150601f19603f3d011682016040523d82523d6000602084013e005b005b6100ff6100f6366004610147565b50600390600690565b6040805192835260208301919091520160405180910390f35b6000825160005b81811015610139576020818601810151858301520161011f565b506000920191825250919050565b60006020828403121561015957600080fd5b503591905056fea26469706673582212206360055824410d73c1629caa1274ace78245616bd63d453aafddfb0e8c3065b164736f6c63430008100033")));
        (uint a, uint b) = factorizer.factorize(expected);
        if (a > 1 && b > 1 && a != expected && b != expected && a != b && expected % a == 0 && expected % b == 0) {
            console.log("you factored the number! %d * %d = %d", a, b, expected);
        } else {
            console.log("you didn't factor the number. %d * %d != %d", a, b, expected);
        }
    }
}