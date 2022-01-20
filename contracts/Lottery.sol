pragma solidity 0.6.12;

contract Lottery {
    address public manager;
    address[] = public players;
    // constructor - set the manager
    constructor () public {
        manager = msg.sender;
    }
    // Invest money by players - anyone in the world
    function invest() payable public {
        // i want to keep a track of who all invested
        players.push(msg.sender);
    }
    // get balance - current balance
    function getBalance() public view returns (uint) { 
        return address(this).balance;
    }
    // manager clicks a function, it should
        // select a player in random
        // send the total money in the contract to the player
}