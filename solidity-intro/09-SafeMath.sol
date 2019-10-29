pragma solidity ^0.5.0;

library SafeMath {
	function mul(uint256 a, uint256 b) internal pure returns (uint256 c) {
		if (a == 0) {
			return 0;
		}
		c = a * b;
		assert(c / a == b);
		return c;
	}

	function div(uint256 a, uint256 b) internal pure returns (uint256) {
		return a / b;
	}
	
	function sub(uint256 a, uint256 b) internal pure returns (uint256) {
		assert(b <= a);
		return a - b;
	}

	function add(uint256 a, uint256 b) internal pure returns (uint256 c) {
		c = a + b;
		assert(c >= a);
		return c;
	}
}

contract SecureOperation {
    using SafeMath for uint256;
    uint256 public get;

    function aggiungi(uint x) public {
        get = get.add(x);
    }

    function sottrai(uint x) public {
        get = get.sub(x);
    }

    function moltiplica(uint x) public {
        get = get.mul(x);
    }

    function dividi(uint x) public {
        get = get.div(x);
    }
    
}