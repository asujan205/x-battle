// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import '@openzeppelin/contracts/token/ERC1155/ERC1155.sol';
import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol';


contract BattleFeild is ERC1155,ERC1155Supply,Ownable{

   string public baseURI;
   uint256 public totalSupply;

   uint256 public constant Ram =5;
   uint256 public constant shiva =6;
    uint256 public constant vishnu =7;
    uint256 public constant brahma =8;
    uint256 public constant hanuman =9;
    uint256 public constant ganesha =10;
    uint256 public constant ravan =0;
    uint256 public constant kumbhkaran =1;
    uint256 public constant duryoDhan =2;
    





}