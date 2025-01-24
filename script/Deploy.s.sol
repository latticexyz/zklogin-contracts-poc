// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {JwtGroth16Verifier} from "@zk-email/jwt-tx-builder-contracts/src/utils/JwtGroth16Verifier.sol";
import {JwtVerifier} from "@zk-email/jwt-tx-builder-contracts/src/utils/JwtVerifier.sol";
import {JwtRegistry} from "@zk-email/jwt-tx-builder-contracts/src/utils/JwtRegistry.sol";
import {IEntryPoint, JwtAccountFactory} from "../src/JwtAccountFactory.sol";

contract DeployScript is Script {
    function setUp() public {}

    function run() public {
        IEntryPoint entryPoint = IEntryPoint(vm.envAddress("ENTRYPOINT"));
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);
        address initialOwner = deployer;

        vm.startBroadcast(deployerPrivateKey);
        JwtRegistry jwtRegistry = new JwtRegistry(deployer);
        console.log("JWT Registry deployed to:", address(jwtRegistry));

        JwtVerifier jwtVerifierImpl = new JwtVerifier();
        console.log("JWTVerifier implementation deployed at: %s", address(jwtVerifierImpl));
        JwtGroth16Verifier groth16Verifier = new JwtGroth16Verifier();

        ERC1967Proxy jwtVerifierProxy = new ERC1967Proxy(
            address(jwtVerifierImpl),
            abi.encodeCall(jwtVerifierImpl.initialize, (initialOwner, address(groth16Verifier)))
        );

        JwtVerifier jwtVerifier = JwtVerifier(address(jwtVerifierProxy));
        console.log("JWTVerifier proxy deployed to:", address(jwtVerifier));

        JwtAccountFactory factory = new JwtAccountFactory(entryPoint, jwtVerifier);
        console.log("JWTAccountFactory deployed to:", address(factory));

        vm.stopBroadcast();
    }
}
