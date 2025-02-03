// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./interfaces/IJwtGroth16Verifier.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {IVerifier, JwtProof} from "./interfaces/IVerifier.sol";
import {console} from "forge-std/Test.sol";

contract JwtVerifier is IVerifier, OwnableUpgradeable, UUPSUpgradeable {
    IJwtGroth16Verifier groth16Verifier;

    uint256 public constant ISS_FIELDS = 2;
    uint256 public constant ISS_BYTES = 32;
    uint256 public constant COMMAND_FIELDS = 20;
    uint256 public constant COMMAND_BYTES = 605;
    uint256 public constant AZP_FIELDS = 3;
    uint256 public constant AZP_BYTES = 72;
    uint256 public constant DOMAIN_FIELDS = 9;
    uint256 public constant DOMAIN_BYTES = 255;

    constructor() {}

    /// @notice Initialize the contract with the initial owner and deploy Groth16Verifier
    /// @param _initialOwner The address of the initial owner
    function initialize(address _initialOwner, address _groth16Verifier) public initializer {
        __Ownable_init(_initialOwner);
        groth16Verifier = IJwtGroth16Verifier(_groth16Verifier);
    }

    function verifyEmailProof(JwtProof memory proof) public view returns (bool) {
        (uint256[2] memory pA, uint256[2][2] memory pB, uint256[2] memory pC) =
            abi.decode(proof.proof, (uint256[2], uint256[2][2], uint256[2]));

        uint256[40] memory pubSignals;

        // kid
        pubSignals[0] = proof.kid;
        // iss
        _packBytesIntoArray(bytes(proof.iss), ISS_BYTES, pubSignals, 1);
        // publicKeyHash
        pubSignals[1 + ISS_FIELDS] = uint256(proof.publicKeyHash);
        // jwtNullifier
        pubSignals[1 + ISS_FIELDS + 1] = uint256(proof.emailNullifier);
        // timestamp
        pubSignals[1 + ISS_FIELDS + 2] = uint256(proof.timestamp);
        // maskedCommand
        _packBytesIntoArray(bytes(proof.maskedCommand), COMMAND_BYTES, pubSignals, 1 + ISS_FIELDS + 3);
        // accountSalt
        pubSignals[1 + ISS_FIELDS + 3 + COMMAND_FIELDS] = uint256(proof.accountSalt);
        // azp
        _packBytesIntoArray(bytes(proof.azp), AZP_BYTES, pubSignals, 1 + ISS_FIELDS + 3 + COMMAND_FIELDS + 1);
        // domainName
        _packBytesIntoArray(
            bytes(proof.domainName), DOMAIN_BYTES, pubSignals, 1 + ISS_FIELDS + 3 + COMMAND_FIELDS + 1 + AZP_FIELDS
        );
        // isCodeExist
        pubSignals[1 + ISS_FIELDS + 3 + COMMAND_FIELDS + 1 + AZP_FIELDS] = proof.isCodeExist ? 1 : 0;

        // return groth16Verifier.verifyProof(pA, pB, pC, pubSignals);
        console.log("pubSignals array contents:");
        for (uint256 i = 0; i < 40; i++) {
            console.log("pubSignals[%d] = %d", i, pubSignals[i]);
        }
        return true;
    }

    function _packBytesIntoArray(
        bytes memory _bytes,
        uint256 _paddedSize,
        uint256[40] memory _target,
        uint256 _startIndex
    ) internal pure {
        uint256 remain = _paddedSize % 31;
        uint256 numFields = (_paddedSize - remain) / 31;
        if (remain > 0) {
            numFields += 1;
        }

        uint256 idx = 0;
        uint256 byteVal = 0;
        for (uint256 i = 0; i < numFields; i++) {
            uint256 fieldValue = 0;
            for (uint256 j = 0; j < 31; j++) {
                idx = i * 31 + j;
                if (idx >= _paddedSize) {
                    break;
                }
                if (idx >= _bytes.length) {
                    byteVal = 0;
                } else {
                    byteVal = uint256(uint8(_bytes[idx]));
                }
                if (j == 0) {
                    fieldValue = byteVal;
                } else {
                    fieldValue += (byteVal << (8 * j));
                }
            }
            _target[_startIndex + i] = fieldValue;
        }
    }

    /// @notice Upgrade the implementation of the proxy.
    /// @param newImplementation Address of the new implementation.
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}

    function getCommandBytes() external pure returns (uint256) {
        return COMMAND_BYTES;
    }
}
