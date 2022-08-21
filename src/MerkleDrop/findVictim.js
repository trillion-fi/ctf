let tree = require('./tree.json');
const { ethers } = require("ethers");

let total = parseInt(tree.tokenTotal, 16)/1e18;

let addrs = Object.keys(tree.claims);

function pack(index,user,amount) {
  console.log(`bytes32 node = keccak256(abi.encodePacked(uint256(${index}), address(${user}), uint96(${amount})));emit log_bytes32(node);`);
}

let nodes =  ["0xa9e8f0fbf0d2911d746500a7786606d3fc80abb68a05f77fb730ded04a951c2d", "0xbeba51d0cb0bc6339edf1832ce33515c92b2bfdbf243e531188470ca084b3b2d", "0x2f8edd415bf009db0356d04585845763b314d74f9800b601e3d0923eab629a6f", "0x2bb44cee53daf66acb6f397831fc2d678c84b5b09ca7b1fff7afda9bb75ef05e", "0xeab835a5226ecd7bb468ab6f2a12db05290e3bc52a5009f85df966d12909d159", "0x25e8db86fed4ac88814814f013f23c2356f1e0960ecd26fddd1614de5fa066af", "0x8652a5d44578e32b80888eba7b90d776d65f946d28c2a92a174c28061eb19470", "0x019c868fa8ed0a5d4d0c902c5bd7b18a53b75b0575e8b8bea70041af9310949f", "0xdb13455978d0488dcb105492f8ea54142f9d500a89bf049bcf00b7fe4c5bdcca", "0x4cb280a759741642be3f25ac989578797e1d1295d348755bc71d12890f4e1a06", "0xbadd8fe5b50451d4c1157443afb33e60369d0949d65fc61d06fca35576f68caa", "0x0701f8f739a2fec08a0e04cc1c3e66fa558dba855236882c5a624d0cea9a4e0b", "0x53af2e862fa1f6e8b669f83b25bfd6d2c3fb52df0ca2d76c03374bffca658b2d", "0x4e7ffaaa80516282b025bb78de5e2ff37bf537c79efbef7d3a76212520edfa1e", "0x99ac0dc09380e26dabe05f039a3d36fbc562b612f40ada5d1707be5246663800", "0x6bb0194ee897ebcf7a41ccebee579ab0fe0e191d9e5e9b5815ea2bf8de4c8495", "0xb142a5c6b86dd9fdd364b8aef591f47c181dcfbd41cde017eee96c7b8a686e2e", "0xa18d9178bab44c66a0ec909913a9168fb57675f96be4dc78e5bd5c3d62bdf585", "0x7c6732545262910be97f294b94dfe4a16612869a1e167184895d72b316f10717", "0xd48451c19959e2d9bd4e620fbe88aa5f6f7ea72a00000f40f0c122ae08d2207b", "0xad664d58ccd7f0f2c817ae6a1620d88e4602131e17207efdd89f6cf98b903628", "0x565be7f9f28d9025dba7935e9251d55c9cb6bc8198366d4b99aa072229e015f9", "0x15320e37bd46719b860b97998a11ffb42ff26db76ead7e0c43c22e17806502df", "0xfb6d302655b6f6a8f6f1aca20a3edb8c6c8c4640daab78796f3e1c0cd0ec8606", "0xf552c4b0909600d226d5f42161c58f7a5722027298f8c204247323336262be88", "0x72c98c344d8b36b7c169dc9d3ea7e43f6927b605aa869fe5fd76dc606edd283b", "0xd0387293a05c1b496ebb8671e1490cf3032c5d22617f616e99189f6dfc698507", "0x385fe12b0ed97da4970945f46d476ade4f8ec725b58b3440304714681d39cfe8", "0x72000c14174c21b921370d96ba77e711b2e28242f94c8468cf83c30e675da3fb", "0x59b5a9cd883510d6863a0715c88a98b079c036a4fb5039a0105ed4b21f3658c5", "0x7b43e82a88f0da5db71bc1c82f1515b9b17ff69e88ec3f101a50cfd98d7f60ce", "0x7ed7078322373dc76f5fd327fe18d63e1fd9811c162527711a2523a79595d383", "0xdae406929d3fb1a4f6b11c05a71ca6a8c86ad99c770abcbf5eb98a5fa0447734", "0x7ff95132a090b7338eb1e2937425f14f7e112cca82de611f0eab14b5310848ec", "0x0f7a6dbdb4f6108c52ea0b0083cba2bc48eb7c0732b2909ba4e06f5c43d95d52", "0x00827f08f3d161ff8988e9489ef341a194b5d3a36307e79881af5b8cc03ae154", "0xc54d1feb79a340c603744a595a63cc1e121980ff876c288eaeb67a7c58cb1d12", "0xd43194becc149ad7bf6db88a0ae8a6622e369b3367ba2cc97ba1ea28c407c442", "0x9c3fd7a427a178d8c3b3884bb706cc850287c4288d2e065be739b0e908e93fef", "0x635d83d54c68be93dbb2d55213899ce15315a8052c5fa76b01d2cafc63b1ec16", "0x28b36a3afabfcfd4a6bc37d9275ebc12768dead832b45fe0f798666b3504b761", "0x0354af4f2c661dc1e918482f626b66f110408fb709894c9c488a001eb0742399", "0x164465e87b253a734a56bc34e3f4b5f24c5f3ee5cade2a6ca2f8f48535309c95", "0x763326fbee252000fc15343ef2cc074ab3414dbc8e35312781451927dce56f80", "0x098a4ebeaea5dcab6543f613d606a459b71211773fdd3f71a91be667c78cb445", "0x5a53412f6ed9a29d5c57527fa3d9c32d774387a3994db9f61849cdcb189a2a4c", "0x4e5133c9221f862a0116601af29c036030d7a2d6656057ce9a3790751d9380dd", "0xa2f005afe53c681aec101c5107b1bc6619e1ebaea3d55fc38dabac341c958619", "0x115e62dc3725c12935896f44553d0835473aa466efc65b46dc70749bb69655bc", "0xd2b8ed2291e92e504017d646568210a107890c34d22aed283cb1a77d1ff66b9d", "0x7c8901ce6a2988d1b59e96b346a1da117f0360266f2357a2b35e42de68d67b62", "0xd6948c2c22e5c79cf7aa1dcce8e6927388d7c650445159b9e272f84c95a032e6", "0x095fc5ae9321eabfede2c4fac05af6ae866f315c08b4f60a3d1b5c166de660ed", "0x25342959be7576258fb48037698afbc01f7e1d0c391d5039ca70adec577b5a62", "0xa0043ed2863bf56a6190c105922498904db3844dad729b3f5d9c6944a5dd987c", "0xe10102068cab128ad732ed1a8f53922f78f0acdca6aa82a072e02a77d343be00", "0xe13771d2a0c4dea1be80f66f0a2c74f429151e8146d642c4306be93190bc89c5", "0x7216025ef8f0d72ddac0c434ac52525b6946623534ec3cbe5ea1317c27ad7a9a", "0xa37b8b0377c63d3582581c28a09c10284a03a6c4185dfa5c29e20dbce1a1427a", "0x65b5391533e6646ac62af8e8d4b2ecb10ccc163fd91ad2309e25299ef0527e6d", "0xc75df667b1e0673d6434808d3e4466c39f61a00b113663a58cfdbfc7ccef29e3", "0x42545b56127a9fe8daea5c3cf4036a47cf91f4596b49a70be6e5f807c592a561", "0x9907e0ad71155513cb3a0fa6fb714b1bbdd5b85005a6cae4f32d68d843bec8b8", "0x30976e6e39aeda0af50595309cfe319061ee99610d640a3ff2d490653963d22a"];
let proofs = [];
let amounts = [];

function processUser(user) {
  let claim = tree.claims[user];
  let index = claim.index;
  let amount = claim.amount;
  let proof = claim.proof[0];
//  pack(index,user,amount);
  proofs.push(proof);
  amounts.push(Math.floor(parseInt(amount,16)/1e18));
}

for(let i=0;i<addrs.length;i++) {
  processUser(addrs[i]);
}

console.log(`total: ${total}`);
for(let i=0;i<addrs.length;i++) {
  let a = nodes[i];
  let b = proofs[i];
  let target;
  let fakeIndex;
  if (a<b) {
    fakeIndex = a;
    target = b;
  } else {
    fakeIndex = b;
    target = a;
  }
  let addr = target.slice(0,42);
  let amount = "0x"+target.slice(42,66);
  let fakeAmount = parseInt(amount,16)/1e18;
  if (fakeAmount>total) continue;
  console.log(`index:${i}, fakeAmount: ${amount}=${fakeAmount}, fakeAddr: ${ethers.utils.getAddress(addr)}, fakeIndex: ${fakeIndex}`);
}

for(let i=0;i<addrs.length;i++) {
  console.log(`index: ${i}, amount: ${amounts[i]}`)
}