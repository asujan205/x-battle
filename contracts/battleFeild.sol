// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import '@openzeppelin/contracts/token/ERC1155/ERC1155.sol';
import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol';


contract BattleFeild is ERC1155,ERC1155Supply,Ownable{

   string public baseURI;
   uint256 public totalSupply;

   uint256 public constant RAVANA = 0;

   uint256 public constant KUMBAKARNA = 1;

    uint256 public constant HANUMAN = 2;

   

    uint256 public constant LAKSHMANA = 3;

    uint256 public constant RAMA = 4;

     uint256 public constant MAX_ATTACK_DEFEND_STRENGTH = 10;

       enum BattleStatus{ PENDING, STARTED, ENDED }


struct GameToken {

    string name ;
    uint256 id ;
    uint256 attackStrength;
    uint256 defendStrength;
}


struct Player {
    address playerAddress;
    string name;
    uint256 playerHealth;
    bool isAlive;    
}

struct Battle {
    BattleStatus status;
    bytes32 battleHash;
    string name ;

    address[2] players;
    uint256[2] playerMove;
    address winner;
}


 mapping(address => uint256) public playerInfo; 
  mapping(address => uint256) public playerTokenInfo; 
  mapping(string => uint256) public battleInfo;

  Player[] public players; // Array of players
  GameToken[] public gameTokens; // Array of game tokens
  Battle[] public battles;

  modifier isPlayer (address Paddress) 
    {
        require(playerInfo[Paddress] != 0);
        _;
    }
modifier isPlayerToken (address Taddress){
    require(playerTokenInfo[Taddress] != 0);
    _;
}


function getPlayerInfo(address _address) public view  isPlayer(_address) returns (Player memory) {
    
        return players[playerInfo[_address]];
    }

    function getAllplayer() public view returns (Player[] memory) {
        return players;
    }


function getPlayerTokenInfo(address _address) public view  isPlayerToken(_address) returns (GameToken memory) {
    
        return gameTokens[playerTokenInfo[_address]];
    }

modifier IsBattle (string memory _name) 
    {
        require(battleInfo[_name] != 0);
        _;
    }
    










}