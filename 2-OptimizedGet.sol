pragma solidity >=0.4.0 <0.6.0;

contract SimpleStorage {
    uint256 public get;

    function set(uint x) public {
        get = x;
    }
}