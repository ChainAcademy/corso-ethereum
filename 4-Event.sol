pragma solidity ^0.5.0;

contract SimpleStorage {
    uint256 public get;

    event Set(address from, uint256 amount);

    function set(uint x) public {
        get = x;
        emit Set(msg.sender, x);
    }
}