// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import '@openzeppelin/contracts/token/ERC1155/ERC1155.sol';
import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol';


contract BattleGods is ERC1155,ERC1155Supply,Ownable{
   

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
    uint8[2] playerMove;
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


    function getBattleInfo(string memory _name) public view  IsBattle(_name) returns (Battle memory) {
    
        return battles[battleInfo[_name]];
    }


    function getAllBattle() public view returns (Battle[] memory) {
        return battles;
    }


    function UpdateBattle (string memory _name, Battle memory _battle) public IsBattle(_name) {
        battles[battleInfo[_name]] = _battle;

    }

    // trigger the events

    event BattleCreated(string name, address player1, address player2);
    event newPlayer(address playerAddress, string name);
    event newGameToken (string name, uint256 id, uint256 attackStrength, uint256 defendStrength);
    event BattleEnded(string battleName, address indexed winner, address indexed loser);
  event BattleMove(string indexed battleName, bool indexed isFirstMove);
  event RoundEnd(address[2] damagedPlayers);



     constructor(string memory _metadataURI) ERC1155(_metadataURI) {
    baseURI = _metadataURI; // Set baseURI
    // initialize();
  }

function setURI(string memory newuri) public onlyOwner{
    _setURI(newuri);
}

  function initialize() private {
    gameTokens.push(GameToken("", 0, 0, 0));
    players.push (Player(address(0), "",  0, false));
    battles.push(Battle(BattleStatus.PENDING, bytes32(0), "", [address(0), address(0)],[0,0], address(0)));
  }







 // The following functions are overrides required by Solidity.
  function _beforeTokenTransfer(
    address operator,
    address from,
    address to,
    uint256[] memory ids,
    uint256[] memory amounts,
    bytes memory data
  ) internal override(ERC1155, ERC1155Supply) {
    super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
  }




}