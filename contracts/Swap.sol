// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {IERC20} from "./Itoken.sol";



contract Swap  {
    IERC20 public usdcToken;
    IERC20 public eNairaToken;
    address public owner;

    uint256 public constant SWAP_RATE = 1680;

    event UsdcSold(address indexed from, uint256 usdc_value, uint256 enaira_value);
    event UsdcBought(address indexed from, uint256 enaira_value, uint256 usdc_value);

    constructor(address _usdc, address _naira) {
        usdcToken = IERC20(_usdc);
        eNairaToken = IERC20(_naira);
        owner = msg.sender;
    }

    function buyUsdc(uint256 _eNairaAmount) external returns (bool) {
        uint256 usdc_value = _eNairaAmount / SWAP_RATE;

        require(usdc_value > 0, "You need to sell an amount worth at least 1 USDC.");

        require(eNairaToken.balanceOf(msg.sender) >= _eNairaAmount, "Not enough eNaira available  on your acct");

        eNairaToken.transferFrom(msg.sender, address(this), _eNairaAmount);

        usdcToken.transfer(msg.sender, usdc_value);

        emit UsdcBought(msg.sender, _eNairaAmount, usdc_value);

        return true;
    }

     function sellUsdc(uint256 _amountToBeSold) external returns (bool) { 
        require(_amountToBeSold > 0,"You need to buy an amount worth at least 1 USDC.");

         require(usdcToken.balanceOf(msg.sender) >= _amountToBeSold, "Not enough USDC available on your acct");

         usdcToken.transferFrom(msg.sender, address(this), _amountToBeSold);

         eNairaToken.transfer(msg.sender, _amountToBeSold * SWAP_RATE);
         
         emit UsdcSold(msg.sender, _amountToBeSold, _amountToBeSold * SWAP_RATE);

         return true;
     }


    

    

}