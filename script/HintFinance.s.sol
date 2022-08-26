pragma solidity 0.8.15;

import "forge-std/Script.sol";
import "../src/HintFinance/contracts/Setup.sol";
import "../src/HintFinance/contracts/solution.sol";

contract HintFinanceScript is Script {
    Setup setup;
    Solution solution;

    function setUp() public {
        vm.createSelectFork("eth");
        vm.deal(address(this), 3030 ether);
        setup = (new Setup){value : 30 ether}();
        solution = (new Solution){value : 3000 ether}(address(setup));
    }

    function run() public {
        solution.Exploit();
        console2.log("solved?", setup.isSolved());
    }
}