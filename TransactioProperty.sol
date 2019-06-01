pragma solidity ^0.5.0;

contract transactionProperties {

    function readTransactionVariables() public  returns(bytes32 currentBlockHash, address miner, uint256 difficulty, uint256 gasLimit, uint256 blockNumber, uint256 timestamp ) {
        blockNumber = block.number;
        currentBlockHash = blockhash(blockNumber);
        miner = block.coinbase;
        difficulty = block.difficulty;
        gasLimit = block.gaslimit;
        timestamp = block.timestamp;/*
        block.timestamp (uint): current block timestamp as seconds since unix epoch
        gasleft() returns (uint256): remaining gas
        msg.data (bytes): complete calldata
        msg.gas (uint): remaining gas - deprecated in version 0.4.21 and to be replaced by gasleft()
        msg.sender (address): sender of the message (current call)
        msg.sig (bytes4): first four bytes of the calldata (i.e. function identifier)
        msg.value (uint): number of wei sent with the message
        now (uint): current block timestamp (alias for block.timestamp)
        tx.gasprice (uint): gas price of the transaction
        tx.origin (address): sender of the transaction (full call chain)*/
    }
}