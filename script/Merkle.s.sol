// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.16;

import "forge-std/Script.sol";
import "forge-std/Test.sol";
import "../src/MerkleDrop/contracts/Setup.sol";
import "../src/MerkleDrop/contracts/MerkleDistributor.sol";


contract MerkleScript is Script, Test {
    Setup setup;
    MerkleDistributor dist;

    function setUp() public {
        setup = Setup(0xeD308A7635C63552F4952a7FD61E42Ac9569D2F5);
        dist = MerkleDistributor(setup.merkleDistributor());
    }

    function printNodes() public {
        {bytes32 node = keccak256(abi.encodePacked(uint256(0), address(0x00E21E550021Af51258060A0E18148e36607C9df), uint96(0x09906894166afcc878)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(1), address(0x046887213a87DC19e843E6E3e47Fc3243A129ad0), uint96(0x41563bf77450fa5076)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(2), address(0x04E9df03e12F21bFB77a97e4306Ef4daeb4129c2), uint96(0x36df43795a7caf4540)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(3), address(0x05e1E52D41A616Df68810039AD972D6f1280cbae), uint96(0x195efe9af09f01e4b6)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(4), address(0x0b3041F7d5E847b06CbE83d096f65b3C19869B39), uint96(0x4dfdb4bae7d0d20cb6)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(5), address(0x20ECC9f3Dfa1E4CF967F6CCb96087603Cd0C0ea5), uint96(0x3b700f748237270c9f)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(6), address(0x21300678bcC7E47c9c7fa58eE4F51Ea46aB91140), uint96(0x24f61ca059bc24bfe0)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(7), address(0x21D11058D97A281ceeF9Bdd8A5d2F1Ca5472E630), uint96(0x35ddccf9e44848307f)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(8), address(0x249934e4C5b838F920883a9f3ceC255C0aB3f827), uint96(0xa0d154c64a300ddf85)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(9), address(0x24dD3381afaE5d29E8eAf398aa5e9A79E41e8B36), uint96(0x73294a1a5881b324fe)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(10), address(0x29a53d36964Db6fD54f1121d7D15e9ccD99aD632), uint96(0x195da98a14415c0697)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(11), address(0x2a0097816875A110E36cFD07228D6b1bB4c31d76), uint96(0x3b58f426caa31ae7d1)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(12), address(0x2cC891F5Ab151fD54358b2f793f7D80681FAb5AE), uint96(0x37a7e4700ede0a9511)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(13), address(0x3600C2789dbA3D3Eb5c36d11d07886c53d2A7eCF), uint96(0x3d0142d7d7218206f9)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(14), address(0x3869541f32b1c9b3Aff867B1a2448d64b5B8c13b), uint96(0xcda8b311ab8fa262c8)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(15), address(0x3ACcF55fcE78E5df0E33A0fB198bf885B0194828), uint96(0x283eff6bcf599ad067)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(16), address(0x3a0bF58A644Ff38F56C79476584394Cf04B2ef72), uint96(0x7cb9abf0e3262da923)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(17), address(0x417D6b3edBE9Ad2444241cc9863573dcDE8bf846), uint96(0x4196852d9dc64be33a)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(18), address(0x42dd0823B8e43082b122e92b39F972B939ED597a), uint96(0x1b97eb44d92febab98)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(19), address(0x4B3570C7A1ff2D20F344f4bD1dD499A1e3d5F4fb), uint96(0x7f1616a67585a28802)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(20), address(0x4FeD95B0d2E1F3bD31E3d7FE90A5Bf74Ae991C32), uint96(0x386ffb4b46b6e905c7)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(21), address(0x51E932b7556f95cf70F9d87968184205530b83A5), uint96(0x42ab44de8b807cbc4f)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(22), address(0x58F3fd7DD3EFBBF05f1cd40862ee562f5C1a4089), uint96(0x2d1a8654a3b98df3d1)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(23), address(0x5C2DE342003b038E81a9E5aa8286dCB7A30DCE94), uint96(0x0985fd6041e59eebbb)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(24), address(0x61300D372cfa25E34E5667B45199801FF3f4B3D9), uint96(0x38b5b63d5f211c5a71)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(25), address(0x6A4CEBddA50C4480f8772834720dCDCB01CaFb5D), uint96(0x5d1b4cb3431ecb4f1a)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(26), address(0x6D26E7739C90230349F4F6e8DAF8da8188e2c5cD), uint96(0x33d68b2ef4c9c4e1ee)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(27), address(0x6b3D0be96d4dD163dCADF6a6bc71EBb8dD42a9B2), uint96(0x55cb74d295a7078628)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(28), address(0x767911D2c042332F6b2007E86f1DdA2B674F6185), uint96(0x2fb5d437c8cd9dfc7f)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(29), address(0x793652bf3D5Dc52b92fc3131C27D9Ce82890422D), uint96(0x2609c108e379ee4aad)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(30), address(0x7B237D20D18f1872b006D924FA2Aa4f60104A296), uint96(0x304e03adc3e62a2d09)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(31), address(0x7cD932afCaF03fA09FdfCFF35A5a7D4b6b4F479e), uint96(0x41bc0955cae5406c53)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(32), address(0x7cbB03Eaccc122eF9e90eD99e5646Fc9B307bcd8), uint96(0x09906894166b087772)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(33), address(0x8250D918318e4b2B456882D26806bE4270F4b82B), uint96(0x38addb61463edc4bc6)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(34), address(0x860Faad971d0e48B96D69C21A32Ca288229449c4), uint96(0x13ea41317f589a9e0c)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(35), address(0x88127EF65888a2c4324747DC85aD20b355D3effb), uint96(0x32cb97226798201629)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(36), address(0x8Ce478613DE9E8ff5643D3CfE0a82a7C232453E6), uint96(0x828f60c1e44867745f)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(37), address(0x8a85e6D0d2d6b8cBCb27E724F14A97AeB7cC1f5e), uint96(0x5dacf28c4e17721edb)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(38), address(0x8ff0687af6f88C659d80D2e3D97B0860dbaB462e), uint96(0x391da2eb282a38e702)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(39), address(0x959DB5c6843304F9F6290f6c7199DD9364ec419D), uint96(0x33310207c285e55392)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(40), address(0x97D10d05275e263F46E9eA21c9aE62507eBB65e3), uint96(0x1969ca1f270d7cd9d1)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(41), address(0x9B34e16b3D298790D61c4F460b616c91740A4a1a), uint96(0x3678ab48c78fe81be3)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(42), address(0xA8cAb79bedA626E2c3c2530AC3e11fc259F237D6), uint96(0x2db4445d44fddb00d2)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(43), address(0xA8f416E298066cb578e4377BeFbdb9C08C6252A8), uint96(0x29e0cb8068d84a987b)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(44), address(0xB58Ad39c58Bdf1F4E62466409c44265A89623722), uint96(0x7347e43564a789c880)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(45), address(0xC379f96dcdF68A5FA3722456fB4614647D1c6bbD), uint96(0x8202b24cb5d34efa49)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(46), address(0xC7FA2a8D3b433C9BfCdd93941195e2C5495EaE51), uint96(0x566498ec48a13dd013)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(47), address(0xC7af0Df0B605e4072D85BECf5fb06acF40f88db9), uint96(0x2c15bae170d80220aa)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(48), address(0xCd19f5E3e4eb7507bB3557173c5aE5021407Aa25), uint96(0x5f0652b88c2c085aea)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(49), address(0xCdBf68C24f9dBA3735Fc79623BaAdbB0Ca152093), uint96(0x25b42c67c4ec6c225d)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(50), address(0xE3fB01b0A4e48CE757BfD801002caC627f6064c0), uint96(0x2c756cdfe2f4d763bc)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(51), address(0xE59820351B7F93ba9dFfA3483741b4266280fcA4), uint96(0x2c69e7f2c5c1fb4d09)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(52), address(0xED43214BB831Bb1543566A52B230919D7C74ae7C), uint96(0x153309c1e553fcfa4a)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(53), address(0xF5bfA5e1BdAF33df1D5b0e2674a241665c921444), uint96(0x322180f225fed4b65d)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(54), address(0xa09674De22A3dD515164FCB777dc223791fB91DE), uint96(0xac7b6f0812eb26f548)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(55), address(0xb71D03A0cD1c285c9C32B9992d7b94E37F5E5b5d), uint96(0x2c5e74f5070dac75d9)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(56), address(0xb9e1bAD69aebc28E8ba5A20701A35185Ff23A4fA), uint96(0x217f2bf08b80310c45)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(57), address(0xbE7Df9554c5746fa31Bb2CD7B9CA9b89ac733d7C), uint96(0x14d55d92753f57b739)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(58), address(0xcee18609823ac7c71951fe05206C9924722372A6), uint96(0x3dfa72c4c7dd942165)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(59), address(0xcf67D2C5D6387093E7DE9F0E28D91473E0088E6e), uint96(0x24b00cf419002103ad)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(60), address(0xe145dBbEFDD4EEf0ED39195f2Ec75FBB8e55609F), uint96(0x55123165db2ae9a1a2)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(61), address(0xe333ed021E58eF3a3219D43d304fc331e5E287bb), uint96(0x2f36bb4329b1d502e3)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(62), address(0xe629559bF328BdA47c528849A31e841A0afFF1c7), uint96(0x248a1b23ff3e32491b)));
            emit log_bytes32(node);}
        {bytes32 node = keccak256(abi.encodePacked(uint256(63), address(0xf7A69C5e5257dEB4e9F190014Fd458711eE4c8aa), uint96(0x68ccf73cd2b434f5bc)));
            emit log_bytes32(node);}
    }

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

    function run() public {
        // index:19, fakeAmount: 0x00000f40f0c122ae08d2207b=72033.43704913257, fakeAddr: 0xd48451c19959e2D9bD4E620fBE88aA5F6F7eA72A, fakeIndex: 0xd43194becc149ad7bf6db88a0ae8a6622e369b3367ba2cc97ba1ea28c407c442
        // index:37, fakeAmount: 0x00000f40f0c122ae08d2207b=72033.43704913257, fakeAddr: 0xd48451c19959e2D9bD4E620fBE88aA5F6F7eA72A, fakeIndex: 0xd43194becc149ad7bf6db88a0ae8a6622e369b3367ba2cc97ba1ea28c407c442
        // index:8, amount: 2966
        // using fake 19/37 with real 8
        vm.startBroadcast();
        // claim real 8
        {
            uint256 index = 8;
            uint96 amount = 0xa0d154c64a300ddf85;
            address account = 0x249934e4C5b838F920883a9f3ceC255C0aB3f827;
            bytes32[] memory proofs = new bytes32[](6);
            proofs[0] = 0xe10102068cab128ad732ed1a8f53922f78f0acdca6aa82a072e02a77d343be00;
            proofs[1] = 0xd779d1890bba630ee282997e511c09575fae6af79d88ae89a7a850a3eb2876b3;
            proofs[2] = 0x46b46a28fab615ab202ace89e215576e28ed0ee55f5f6b5e36d7ce9b0d1feda2;
            proofs[3] = 0xabde46c0e277501c050793f072f0759904f6b2b8e94023efb7fc9112f366374a;
            proofs[4] = 0x0e3089bffdef8d325761bd4711d7c59b18553f14d84116aecb9098bba3c0a20c;
            proofs[5] = 0x5271d2d8f9a3cc8d6fd02bfb11720e1c518a3bb08e7110d6bf7558764a8da1c5;
            dist.claim(index, account, amount, proofs);
        }

        // claim fake 19
        {
            uint256 index = 0xd43194becc149ad7bf6db88a0ae8a6622e369b3367ba2cc97ba1ea28c407c442;
            uint96 amount = uint96(0x00000f40f0c122ae08d2207b);
            address account = 0xd48451c19959e2D9bD4E620fBE88aA5F6F7eA72A;
            bytes32[] memory proofs = new bytes32[](5);
            proofs[0] = 0x8920c10a5317ecff2d0de2150d5d18f01cb53a377f4c29a9656785a22a680d1d;
            proofs[1] = 0xc999b0a9763c737361256ccc81801b6f759e725e115e4a10aa07e63d27033fde;
            proofs[2] = 0x842f0da95edb7b8dca299f71c33d4e4ecbb37c2301220f6e17eef76c5f386813;
            proofs[3] = 0x0e3089bffdef8d325761bd4711d7c59b18553f14d84116aecb9098bba3c0a20c;
            proofs[4] = 0x5271d2d8f9a3cc8d6fd02bfb11720e1c518a3bb08e7110d6bf7558764a8da1c5;
            dist.claim(index, account, amount, proofs);
        }

        console2.log(setup.isSolved());
    }
}