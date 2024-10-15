// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

interface IERC20 {
   function transfer(address _receiver, uint256 _amountOfToken) external;

    function transferFrom(address _owner, address _buyer, uint256 _amountOfToken) external;

    function balanceOf(address _address) external view returns (uint256);




}