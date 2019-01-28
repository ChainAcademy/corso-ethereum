pragma solidity ^0.5.0;

contract Variables {
    bytes32 public data;
    address public sender;
    uint256 public number;
    mapping(address => uint256) public balancesOf;

    constructor() public {
        sender = msg.sender;
        data = keccak256(abi.encodePacked("ciao"));
        number = uint256(12345678);
        balancesOf[sender] = number;
    }

}