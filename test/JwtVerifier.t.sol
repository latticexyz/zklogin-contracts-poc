// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "forge-std/Test.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {JwtGroth16Verifier} from "../src/JwtGroth16Verifier.sol";
import {JwtVerifier} from "../src/JwtVerifier.sol";
import {JwtProof} from "../src/interfaces/IVerifier.sol";

contract JwtVerifierTest is Test {
    JwtVerifier verifier;

    function test_verify() public {
        JwtVerifier verifierImpl = new JwtVerifier();
        JwtGroth16Verifier groth16Verifier = new JwtGroth16Verifier();
        ERC1967Proxy verifierProxy = new ERC1967Proxy(
            address(verifierImpl), abi.encodeCall(verifierImpl.initialize, (msg.sender, address(groth16Verifier)))
        );
        verifier = JwtVerifier(address(verifierProxy));

        JwtProof memory proof = JwtProof({
            kid: 0x00fa072f75784642615087c7182c101341e18f7a3a,
            iss: "https://accounts.google.com",
            azp: "188183665112-uafieilii1f4rklscv0b7gj6e42lao42.apps.googleusercontent.com",
            publicKeyHash: 0x220683fe09e09b5885d7242b89c852eaee1dd9282cc50b543a7083a60420fa30,
            timestamp: 1738615734,
            maskedCommand: "0x0c57ac4Be468894c2B312d996508f9e75e2bE1C3",
            emailNullifier: 0x198f0de5df372afadf860d9c9255951a1b43459c6aea1fb3b9ff7d2940378134,
            accountSalt: 0x2bce2697ba010cf99f315e3bc3feba794e97ab29a171f19d06d7c21dbbf0d47c,
            isCodeExist: false,
            domainName: "lattice.xyz",
            proof: hex"2825a55e235098f077af9a686eeea511350497973cadda8b88e6fc1224799ca62533c23638ed8598f58db6df9432d80881883ece613e3dd9e312a66efec0446016df7c46c8a57f4674dea0bdd41debf0197e7395a3966acf049f971447961f3707c3179720ad2d1bd24a6cac8771fd73c7c082856620d4a267c336fa2ff1f7f7063c59ee5628959db00b30dbd22b464bc360cc50cfebefd0121d4535d924dfa80a5a095bf997653327991388cc70d53c0e43696f3e2af94ef1a633e57182bdc500aa9a83b3bd277fd12d476b371def0a355af37c7bf9317d5c5fe39c74ee38e02d4ba2430523becce17df576d9ed322b3e46df337b510f981aecb6e4cddd7036"
        });

        assertTrue(verifier.verifyEmailProof(proof));
    }
}
