pragma solidity 0.6.12;

contract Lottery {
    address public manager;
    address payable[] public players;
    // constructor - set the manager
    constructor () public {
        manager = msg.sender;
    }
    modifier onlyManager () {
        require(msg.sender == manager, "Only the manager can call this function")
        _;
    }
    event playerInvested(address player, uint amount);
    event winnderSelected(address winner, uint amount);
    // Invest money by players - anyone in the world
    function invest() payable public { // manager should not be able to invest more
        require(msg.sender != manager, 'Manager cannot invest');
        // the contract should require a minimum investment
        require(msg.value > 0.1 ether, 'You must invest more than .1 ether');
        // i want to keep a track of who all invested
        players.push(msg.sender);
        emit playerInvested(msg.sender, msg.value)
    }
    // get balance - current balance
    function getBalance() public view onlyManager returns (uint) { 
        // only the manager should be able to see the balance
        return address(this).balance;
    }
    // random function
    function random() private view returns(uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, players.length)));
    }
    // manager clicks a function, it should
    function selectWinner() public onlyManager {
        // only the manager should be able to call this function 
        // generate a random number - psuedorandom number (random is not actually possible on blockchains) https://github.com/CatsMeow492/not-so-smart-contracts/tree/master/bad_randomness
        // Use ORACLES to find a random number - use third party in production
        // first take some global variables, encode it, hash it, convert to unit
        uint r = random();
        // modulo it with number of players
        uint index = r % players.length;
        // map the remainder to a index in the array
        address payable winner = players[index];
        emit winnerSelected(winner, address(this).balance)
        // transfer all the money in the contract to the addresss in the array
        winner.transfer(address(this).balance);
        // notify the losers
        // finally empty the array and start over
        players = new address payable[](0);
}