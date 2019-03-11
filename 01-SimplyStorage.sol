pragma solidity >=0.5.0 <0.6.0;

contract SimpleStorage {
    uint256 storedData;

    function set(uint x) public {
        storedData = x;
    }

    function get() public view returns (uint) {
        return storedData;
    }
}