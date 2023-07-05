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







}