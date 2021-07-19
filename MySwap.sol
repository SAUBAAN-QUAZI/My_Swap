pragma solidity 0.8.4;

import "./Saubaan_2.sol";
 
contract  MySwap  {
    string public name = "MySwap Ultimate Exchange";
    Saubaan_2 public token;
    uint public rate = 100;
    
    constructor (Saubaan_2 _token) public {
        token = _token;
    }

    event TokenPurchased(
        address  account,
        address token,
        uint amount,
        uint rate
         
    ); 
    
     event TokenSold(
        address  account,
        address token,
        uint amount,
        uint rate
         
    ); 
  
 function buyTokens(uint _amount) public  payable  {
     // Calculate the number of tokens to buy
     uint tokenAmount = msg.value*rate;

     // Require that myswap has enough tokens
    require(token.balanceOf(address(this)) >= tokenAmount);
    // Transfer tokens to the user
     token.transfer(msg.sender, tokenAmount );

    // Emit an event
     emit TokenPurchased(msg.sender, address(token), tokenAmount, rate);

 }
 function sellTokens(uint _amount) public payable {
     //User cant sell more tokens than they have
     require(token.balanceOf(msg.sender) >= _amount);
     //Calculate the amount of Ether to redeem
   uint etherAmount = _amount / rate;
   // Require MySwap has enough ether
   require(address(this).balance >= etherAmount);
     //perform sale
     token.transferFrom(msg.sender, address(this), _amount);
   payable(msg.sender).transfer(etherAmount);
   
   //Emit an event
   emit TokenSold(msg.sender, address(token), _amount, rate);

 }
    
}