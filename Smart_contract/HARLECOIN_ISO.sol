// Harlecoin ICO

// Version of compiler
pragma solidity ^0.6.6;

contract Harlecoin_ico{
    //Introducing the maximum number of Harlecoin available for sale
    uint public max_Harlecoin = 1000000;
    
    //Introducing the Rupees to Harlecoin conversion rate
    
    uint public rupees_to_Harlecoin = 1000; // 1 Harlecoin =~ 13.33 Rupees
    
    //Introducing the Total number of harlecoin that have been bought by the Investors
    uint public total_harlecoin_bought = 0;
    
    //mapping from the Investors to the harlecoin and Rupees
    mapping( address => uint) equity_Harlecoin;
    mapping( address => uint) equity_Rupees;
    
    modifier can_buy_Harlecoin(uint Rupees_invested){
        require(Rupees_invested * rupees_to_Harlecoin + total_harlecoin_bought < max_Harlecoin);
        _; // meaning that the function can only be applied if the above statement is true
    }
    
    //Getting the equity in harlecoin of an Investor
    function equity_in_Harlecoin(address investor) external view returns (uint) {
          return equity_Harlecoin[investor];
    } 
    
    //Getting the equity in rupees of an Investor
    function equity_in_Rupees(address investor) external view returns (uint) {
          return equity_Rupees[investor];
    } 
    
    //Buying the harlecoin
    function buy_Harlecoin(address investor, uint Rupees_invested) external
    can_buy_Harlecoin(Rupees_invested) {
        uint harlecoin_bought = Rupees_invested * rupees_to_Harlecoin;
        equity_Harlecoin[investor] += harlecoin_bought;
        
        equity_Rupees[investor] = equity_Harlecoin[investor] / 1000;
        
        total_harlecoin_bought += harlecoin_bought;
    }
    
    // Selling Harlecoin
    function sell_Harlecoin(address investor, uint Harlecoin_sold) external{
        equity_Harlecoin[investor] -= Harlecoin_sold;
        
        equity_Rupees[investor] = equity_Harlecoin[investor] / 1000;
        
        total_harlecoin_bought -= Harlecoin_sold; 
    }
}