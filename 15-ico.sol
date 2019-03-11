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

contract Ownable {
	address public owner;
	address public newOwner;

	event OwnershipTransferred(address indexed oldOwner, address indexed newOwner);

	constructor() internal {
		owner = msg.sender;
		newOwner = address(0);
	}

	modifier onlyOwner() {
		require(msg.sender == owner, "msg.sender == owner");
		_;
	}

	function transferOwnership(address _newOwner) public onlyOwner {
		require(address(0) != _newOwner, "address(0) != _newOwner");
		newOwner = _newOwner;
	}

	function acceptOwnership() public {
		require(msg.sender == newOwner, "msg.sender == newOwner");
		emit OwnershipTransferred(owner, msg.sender);
		owner = msg.sender;
		newOwner = address(0);
	}
}

contract tokenInterface {
	function balanceOf(address _owner) public view returns (uint256 balance);
	function transfer(address _to, uint256 _value) public returns (bool);
	uint256 public totalSupply;
	uint256 public decimals;
}

contract ICO is Ownable {
    using SafeMath for uint256;
    
    address payable public wallet;
    tokenInterface public tokenContract;
    uint256 public tokenPrice;
    uint256 public etherMinimum;

    uint256 public soldTokens;   
    uint256 public etherRaised;
    
    function remainingTokens() public view returns(uint256) {
        return tokenContract.balanceOf(address(this));
    }
    
    function totalTokens() public view returns(uint) {
        return remainingTokens().add(soldTokens);
    }

    constructor(address payable _wallet, address _tokenAddress, uint256 _tokenPrice, uint256 _etherMinimum) public {
        tokenContract = tokenInterface(_tokenAddress);
        wallet = _wallet;
        require ( _tokenPrice != 0, "_tokenPrice != 0" );
        tokenPrice = _tokenPrice;
        etherMinimum = _etherMinimum;
    }
    
    function withdrawTokens(uint256 value) public onlyOwner returns (bool) {
        return tokenContract.transfer(msg.sender, value);
    }
	
    function changeMinimum(uint256 _newEtherMinimum) public onlyOwner {
        etherMinimum = _newEtherMinimum;
    }
    
	function () external payable {
	    require( msg.value >= etherMinimum, "msg.value >= etherMinimum"); 
        require( remainingTokens() > 0, "remainingTokens > 0" );
        
        uint256 oneToken = 10 ** uint256(tokenContract.decimals());
        uint256 tokenAmount = msg.value.mul( oneToken ).div( tokenPrice );
        
        uint256 change = 0;
        if ( remainingTokens() < tokenAmount ) {
            change = (tokenAmount - remainingTokens() ).mul(tokenPrice).div(oneToken);
            tokenAmount = remainingTokens();
        }
        uint256 money = msg.value.sub(change);
        
		soldTokens = soldTokens.add(tokenAmount);
		etherRaised = etherRaised.add(money);
		
		tokenContract.transfer(msg.sender, tokenAmount);
		
		wallet.transfer(money);
		if(change != 0) msg.sender.transfer(change);
	}
}