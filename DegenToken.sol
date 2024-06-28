// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    event TokensRedeemed(address indexed user, uint amount);

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

    function redeemToken(uint _amount) public {
        require(balanceOf(msg.sender) >= _amount, "Insufficient token balance to redeem");
        _burn(msg.sender, _amount);
        emit TokensRedeemed(msg.sender, _amount);
    } 
}
