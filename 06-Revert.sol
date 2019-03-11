pragma solidity ^0.5.0;

contract SimpleStorage {
    uint256 public get;

    function set(uint x) public {
        if ( x >= 10 ) revert("x should be less than 10");
        get = x;
    }
}