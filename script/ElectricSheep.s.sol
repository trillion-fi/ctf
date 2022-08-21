pragma solidity 0.8.16;

import "forge-std/Script.sol";
import "forge-std/Test.sol";
import "../src/ElectricSheep/contracts/Setup.sol";

interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

contract ElectricSheepScript is Script, Test {
    Setup setup;
    IERC20 dreamer;

    function setUp() public {
        setup = new Setup();
        dreamer = IERC20(address(setup.DREAMERS()));
        vm.createSelectFork("eth");
    }

    function run() public {

    }
}