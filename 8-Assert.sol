pragma solidity ^0.5.0;

contract SimpleStorage {
    uint256 public get;

    function set(uint x) public {
        assert(x < 10);
        get = x;
    }
}