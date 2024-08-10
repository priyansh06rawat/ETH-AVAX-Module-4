// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenGamingToken is ERC20, Ownable {

    event TokensRedeemed(address indexed user, uint256 amount, string itemName);

    // Mapping to store item prices
    mapping(string => uint256) public itemPrices;

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        
        itemPrices["GTA"] = 100;                      
        itemPrices["PUBG"] = 70;
        itemPrices["Free Fire"] = 50;
        itemPrices["COC"] = 50;
        itemPrices["Zombie dash"] = 40;
        itemPrices["Shoot"] = 30;
    }

    
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    
    function transferToken(address to, uint256 amount) public {
        transfer(to, amount);
    }

   
    function setItemPrice(string memory itemName, uint256 price) public onlyOwner {
        itemPrices[itemName] = price;
    }

    // Function to redeem tokens for an item
    function redeemToken(string memory itemName) public {
        uint256 amount = itemPrices[itemName];
        require(amount > 0, "Item does not exist");
        require(balanceOf(msg.sender) >= amount, "Insufficient token balance to redeem");
        _burn(msg.sender, amount);
        
        
        emit TokensRedeemed(msg.sender, amount, itemName);
    }

    function checkTokenBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }
}
