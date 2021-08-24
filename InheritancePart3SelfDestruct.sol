pragma solidity 0.7.5;

import "./InheritancePart2Ownable.sol";

contract Destroyable is Ownable {
    function selfDestruct() public onlyOwner payable {
    emit selfDestruction(msg.sender);
    selfdestruct(msg.sender);
    
    //test if emit will still run after selfdestruct invoked (it doesn't)
    emit selfDestructionv2(msg.sender);
    //Hypothesis: anything after selfdestruct doesn't run as the smart contract is effectively destroyed
    //But the showBalance still work as stated in https://betterprogramming.pub/solidity-what-happens-with-selfdestruct-f337fcaa58a7
}
}