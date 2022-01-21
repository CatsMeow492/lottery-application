pragma solidity 0.6.12;

contract Lottery {
    address public manager;
    address payable[] public players;
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
    // random function
    function random() public view returns(uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, players.length)));
    }
    // manager clicks a function, it should
    function selectWinner() public {
        // generate a random number - psuedorandom number (random is not actually possible on blockchains) https://github.com/CatsMeow492/not-so-smart-contracts/tree/master/bad_randomness
        // Use ORACLES to find a random number - use third party in production
        // first take some global variables, encode it, hash it, convert to unit
        uint r = random();
        // modulo it with number of players
        uint index = r % players.length;
        // map the remainder to a index in the array
        address payable winner = players[index];
        // transfer all the money in the contract to the addresss in the array
        winner.transfer(address(this).balance);
        // notify the losers
        // finally empty the array and start over
    }
        // select a player in random
        // send the total money in the contract to the player
}