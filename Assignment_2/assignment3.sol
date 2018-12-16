pragma solidity ^0.4.24;

contract simpleAuction {
    
    struct bider {
        address biderAddress;
        uint tokenBought;
    }

    
    mapping (address => bider) public biders; // 입찰자들의 정보
    
    mapping (uint => uint) public highest;  //최고 입찰가
    mapping (address => uint[6]) public myBid; //나의 입찰가
    
    uint public totalToken; // 토큰 총 개수
    uint public balanceTokens; // 남은 토큰 수
    uint public tokenPrice; // 토큰 가격 ex) 0.01 ether
    
    constructor(uint _totalToken, uint _tokenPrice) public // Tx 생성시 호출자
    {
        totalToken = _totalToken;
        balanceTokens = _totalToken;
        tokenPrice = _tokenPrice;
        
        myBid[msg.sender][0] = 42;
        myBid[msg.sender][1] = 43;
        myBid[msg.sender][2] = 44;
        myBid[msg.sender][3] = 45;
        myBid[msg.sender][4] = 46;
        myBid[msg.sender][5] = 47;
    }
    
    function buy() payable public returns (int) 
    {
        uint tokensToBuy = msg.value / tokenPrice;
        require(tokensToBuy <= balanceTokens);
        biders[msg.sender].biderAddress = msg.sender;
        biders[msg.sender].tokenBought += tokensToBuy;
        balanceTokens -= tokensToBuy;
    }
    
    function getHighestValue() view public returns (uint, uint, uint, uint, uint, uint)
    {
        return (highest[0],highest[1],highest[2],highest[3],highest[4],highest[5]);
    }

    function getMyValue(address addr) view public returns (uint, uint, uint, uint, uint, uint)
    {
        return (myBid[0],myBid[1],myBid[2],myBid[3],myBid[4],myBid[5]);
    }
    
    function Auction(uint candidateName, uint tokenCountForBid) public
    {
        require(tokenCountForBid <= biders[msg.sender].tokenBought);
        require(highest[candidateName] <= biders[msg.sender].tokenBought);
        
        highest[candidateName] = tokenCountForBid;
    }
    
    function getTotalToken() view public returns(uint)
    {
        return totalToken;
    }
    
    function getBalanceTokens() view public returns(uint)
    {
        return balanceTokens;
    }
    
    function getTokenPrice() view public returns(uint)
    {
        return tokenPrice;
    }
    
    function getTokenBought() view public returns(uint)
    {
        return biders[msg.sender].tokenBought;
    }
}