// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import '@openzeppelin/contracts/token/ERC1155/ERC1155.sol';
import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol';

contract BattleGods is ERC1155, ERC1155Supply, Ownable {
    string public baseURI;
    uint256 public totalSupply;

    uint256 public constant RAVANA = 0;
    uint256 public constant KUMBAKARNA = 1;
    uint256 public constant HANUMAN = 2;
    uint256 public constant LAKSHMANA = 3;
    uint256 public constant RAMA = 4;
    uint256 public constant MAX_ATTACK_DEFEND_STRENGTH = 10;

    enum BattleStatus {PENDING, STARTED, ENDED}

    struct GameToken {
        string name;
        uint256 id;
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
        string name;
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

    modifier isPlayer(address Paddress) {
        require(playerInfo[Paddress] != 0, "Player not registered");
        _;
    }

    modifier isPlayerToken(address Taddress) {
        require(playerTokenInfo[Taddress] != 0, "Player token not created");
        _;
    }

    modifier IsBattle(string memory _name) {
        require(battleInfo[_name] != 0, "Battle not found");
        _;
    }

    event BattleCreated(string name, address player1, address player2);
    event NewPlayer(address playerAddress, string name);
    event NewGameToken(string name, uint256 id, uint256 attackStrength, uint256 defendStrength);
    event BattleEnded(string battleName, address indexed winner, address indexed loser);
    event BattleMove(string indexed battleName, bool indexed isFirstMove);
    event RoundEnd(address[2] damagedPlayers);

    constructor(string memory _metadataURI) ERC1155(_metadataURI) {
        baseURI = _metadataURI; // Set baseURI
    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function initialize() private {
        gameTokens.push(GameToken("", 0, 0, 0));
        players.push(Player(address(0), "", 0, false));
        battles.push(Battle(BattleStatus.PENDING, bytes32(0), "", [address(0), address(0)], [0, 0], address(0)));
    }

    function getPlayerInfo(address _address) public view isPlayer(_address) returns (Player memory) {
        return players[playerInfo[_address]];
    }

    function getAllPlayers() public view returns (Player[] memory) {
        return players;
    }

    function getPlayerTokenInfo(address _address) public view isPlayerToken(_address) returns (GameToken memory) {
        return gameTokens[playerTokenInfo[_address]];
    }

    function getBattleInfo(string memory _name) public view IsBattle(_name) returns (Battle memory) {
        return battles[battleInfo[_name]];
    }

    function getAllBattles() public view returns (Battle[] memory) {
        return battles;
    }

    function updateBattle(string memory _name, Battle memory _battle) public IsBattle(_name) {
        battles[battleInfo[_name]] = _battle;
    }

    function registerPlayer(string memory _name, string memory _gameTokenName) external {
        require(playerInfo[msg.sender] == 0, "Player already registered");

        uint256 _id = players.length;

        players.push(Player(msg.sender, _name, 100, true));

        playerInfo[msg.sender] = _id;
          createRandomGameToken(_gameTokenName);

        emit NewPlayer(msg.sender, _name);
    }

    function _createRandomNum(uint256 _max, address _sender) internal view returns (uint256 randomValue) {
        uint256 randomNum = uint256(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, _sender)));

        randomValue = randomNum % _max;
        if (randomValue == 0) {
            randomValue = _max / 2;
        }

        return randomValue;
    }

    function _createGameToken(string memory _name) internal returns (GameToken memory) {
        uint256 _id = gameTokens.length;
        uint256 _attackStrength = _createRandomNum(MAX_ATTACK_DEFEND_STRENGTH, msg.sender);
        uint256 _defendStrength = _createRandomNum(MAX_ATTACK_DEFEND_STRENGTH, msg.sender);

        gameTokens.push(GameToken(_name, _id, _attackStrength, _defendStrength));

        playerTokenInfo[msg.sender] = _id;

        emit NewGameToken(_name, _id, _attackStrength, _defendStrength);

        return gameTokens[_id];
    }

    function createRandomGameToken(string memory _name) public isPlayer(msg.sender) {
        require(getPlayerInfo(msg.sender).isAlive, "Player is not alive");
        _createGameToken(_name);
    }
     
    
    function CreateBattle(string memory _name) public isPlayer(msg.sender) {
        
    }



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

