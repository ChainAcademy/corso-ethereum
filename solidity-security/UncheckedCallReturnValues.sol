contract Lotto {
    bool public payedOut = false;
    address public winner;
    uint public winAmount;
    
    // ... extra functionality here
    
    function sendToWinner() public {
        require(!payedOut);
        winner.send(winAmount);
        payedOut = true;
    }
    function withdrawLeftOver() public {
        require(payedOut);
        msg.sender.send(this.balance);
    }
}

// The vulnerability exists on line 11, where a send is used without checking the response. In this trivial example, a winner whose transaction fails (either by running out of gas or by being a contract that intentionally throws in the fallback function) allows payedOut to be set to true regardless of whether ether was sent or not. In this case, anyone can withdraw the winner’s winnings via the withdrawLeftOver function.

// Preventative Techniques
// Whenever possible, use the transfer function rather than send, as transfer will revert if the external transaction reverts. If send is required, always check the return value.
