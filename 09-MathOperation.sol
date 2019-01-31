pragma solidity ^0.5.0;

contract SimpleOperation {
    uint256 public get;

    function aggiungi(uint x) public {
        get = get + x;
    }

    function sottrai(uint x) public {
        get = get - x;
    }

    function moltiplica(uint x) public {
        get = get * x;
    }

    function dividi(uint x) public {
        get = get / x;
    }
    
}