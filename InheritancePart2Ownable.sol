pragma solidity 0.7.5;

contract Ownable{
     mapping(address => uint)balance;
    
    address owner;
    
    event depositCompleted(uint amount, address indexed depositedTo);
    event transferCompleted(address indexed sentBy, uint amount, address indexed receivedBy);
    event withdrawalCompleted(address indexed withdrawTo, uint amount);
    event selfDestruction(address indexed balancePostDestroyedSentTo);
    event selfDestructionv2(address indexed balancePostDestroyedSentTo);
    
    modifier onlyOwner{
        require(msg.sender == owner);
        _; // run the function
    }
    
    constructor() {
        owner = msg.sender;
    }
    
}