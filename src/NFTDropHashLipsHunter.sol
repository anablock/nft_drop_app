// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract HashLipsHunter {
  
  // Specify owner of the drop
  address public owner;
  
  // Define a NFT drop object
  struct Drop {
    string imageUri;
    string name;
    string description;
    string social_1;
    string social_2;
    string websiteUri;
    string price;
    uint256 supply;
    uint256 presale;
    uint256 sale;
    uint8 chain;
    bool approved;
  }
  
  // Create a list to hold all of the objects
  Drop[] public drops;
  // mapping of an owner and an id relationship 
  // (to keep track which users own which drops)
  mapping (uint256 => address) public users;
  
  // Define an owner using a constructor function
  // Constructor function runs only once, when the contract is deployed
  constructor() {
    owner = msg.sender; // the sender/deployer of this contract will be the owner
  }
  
  // modifier is add on code that can execute only under certain conditions
  modifier onlyOwner {
    require(msg.sender == owner, "You are not the owner.");
    _; // if the above condition is true, then only render the code that is in the whole function.
  }
  
  // Get the NFT drop objects list
  function getDrops() public view returns (Drop[] memory) {
    return drops;
  }
  // Add to the NFT drop objects list
  function addDrop( Drop memory _drop ) public {
    _drop.approved = false;
    drops.push(_drop);
    uint256 id = drops.length - 1;
    users[id] = msg.sender;
  }
  
  // Update from the NFT drop objects list
  function updateDrop( uint256 _index, Drop memory _drop ) public {
    require(msg.sender == users[_index], "You are not an owner of this drop");
    _drop.approved = false;
    drops[_index] = _drop;
  }
  // Remove from the NFT drop objects list
  // Approve an NFT drop object to enable displaying
  function approveDrop(uint256 _index) public onlyOwner  {
    Drop storage drop = drops[_index];
    drop.approved = true;
  }
  // Clear out all NFT drop objects from list
}