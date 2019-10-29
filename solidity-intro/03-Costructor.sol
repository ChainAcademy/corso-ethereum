pragma solidity ^0.5.0;

contract SimpleStorage {
    uint256 public get;

    constructor(uint256 _get) public {
        get = _get;
    }

    function set(uint x) public {
        get = x;
    }
}