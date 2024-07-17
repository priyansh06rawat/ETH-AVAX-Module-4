// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    event TokensRedeemed(address indexed user, uint amount, string itemName);

    mapping(string => uint256) public itemPrices;

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function transferToken(address _toAddress, uint _amount) public {
        bool success = transfer(_toAddress, _amount);
        assert(success);  
    }

    // Function to set the price of an item
    function setItemPrice(string memory itemName, uint256 price) public onlyOwner {
        itemPrices[itemName] = price;
    }

    // Function to redeem an item
    function redeemItem(string memory itemName) public {
        uint256 price = itemPrices[itemName];
        require(price > 0, "Item does not exist");
        require(balanceOf(msg.sender) >= price, "Insufficient token balance to redeem");

        _burn(msg.sender, price);
        emit TokensRedeemed(msg.sender, price, itemName);
    }
}
