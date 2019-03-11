pragma solidity ^0.5.0;

contract Ownable {
	address public owner;

	event OwnershipTransferred(address indexed oldOwner, address indexed newOwner);

	constructor() public {
		owner = msg.sender;
	}

	modifier onlyOwner() {
		require(msg.sender == owner, "msg.sender == owner");
		_;
	}

	function transferOwnership(address _newOwner) public onlyOwner {
		require(address(0) != _newOwner, "address(0) != _newOwner");
		owner = _newOwner;
	}

}

contract SimpleStorage is Ownable {
    uint256 public storedData;

    function set(uint x) public onlyOwner {
        storedData = x;
    }
}