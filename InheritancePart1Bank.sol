pragma solidity 0.7.5;

contract Bank{
    mapping(address => uint)balance;
    
    address owner;
    
    event depositCompleted(uint amount, address indexed depositedTo);
    event transferCompleted(address indexed sentBy, uint amount, address indexed receivedBy);
    event withdrawalCompleted(address indexed withdrawTo, uint amount);
    
    modifier onlyOwner{
        require(msg.sender == owner);
        _; // run the function
    }
    
    constructor() {
        owner = msg.sender;
    }
    
    function deposit() public payable{
        balance[msg.sender]+=msg.value;
        emit depositCompleted(msg.value, msg.sender);
        
    }
    
    function showBalance() public view returns (uint){
        return balance[msg.sender];
    }
    
    function transfer(uint _toTransfer, address _addressToTransfer) public {
        
        require(msg.sender != _addressToTransfer, "Sending Ether back to oneself is prohibited, please change receiving address");
        require(balance[msg.sender]>=_toTransfer, "Insufficient balance to perform transfer");
        
        
        uint beforeTransferSenderBalance = balance[msg.sender];
       
        balance[msg.sender]-=_toTransfer;
        balance[_addressToTransfer]+=_toTransfer;
        
        uint newSenderBalance = balance[msg.sender];
        
        assert(beforeTransferSenderBalance == newSenderBalance + _toTransfer);
        emit transferCompleted(msg.sender, _toTransfer, _addressToTransfer);
        
    }
    
    function withdraw(uint _toWithdraw) public {
        require(balance[msg.sender]>=_toWithdraw, "Insufficient balance to perform withdrawal");
        
        uint preWithdrawalBalance = balance[msg.sender];
        
        balance[msg.sender] -= _toWithdraw;
        msg.sender.transfer(_toWithdraw);
        
        uint postWithdrawalBalance = balance[msg.sender];
        
        assert(preWithdrawalBalance == postWithdrawalBalance + _toWithdraw);
        emit withdrawalCompleted(msg.sender, _toWithdraw);
    }
}