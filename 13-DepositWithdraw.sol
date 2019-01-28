pragma solidity ^0.5.0;

contract DepostiWithdraw {
    mapping(address => uint256) public balancesOf;
    
    function deposit() public payable {
        balancesOf[msg.sender] = msg.value;
    }
    
    function withdraw() public {
        uint256 amount = balancesOf[msg.sender];
        balancesOf[msg.sender] = 0;
        msg.sender.transfer(amount);
    }
}