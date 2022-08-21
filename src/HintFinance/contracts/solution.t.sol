pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import "./Solution.sol";

contract ContractTest is Test {
    Solution sol;

    function setUp() public {
        sol = (new Solution){value : 3000 ether}();
    }

    function testExploit() public {
        sol.Exploit();
    }
}
