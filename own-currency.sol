/*
Powered by:

Kuznetsoff.Laboratory
http://kuznecov-lab.ru
info@kuznecov-lab.ru

ISVTeam
https://isvteam.com/
info@isvteam.com
@version 1.0.1
*/
pragma solidity ^0.4.11;
contract ERC20 {
    uint public ex;
    address public owner;
    uint public totalSupply;
    function balanceOf(address who) constant returns (uint);
    function transfer(address to, uint value);
    event Transfer(address indexed from, address indexed to, uint value);
}
contract YKN_07 is ERC20 {
    string public constant name = "Arm-Money Token (AMT)";
    string public constant symbol = "AMT";
    uint8 public constant decimals = 18;
    mapping (address => uint) balances;

    function YKN_07(uint _ex, uint initialCount) {
        balances[msg.sender] = initialCount;
        owner = msg.sender;
        ex = _ex;
        totalSupply = initialCount;
    }

    function buyTokens() payable external {
        if (msg.value == 0) revert();
        var numTokens = msg.value*ex; // Convert wei to Ethereum
        if(balances[owner] < numTokens) revert(); // Check if owner have tokens
        balances[msg.sender] += numTokens; // Update buyer balance
        balances[owner]  -= numTokens; // Update seller balance
        totalSupply = balances[owner]; // Update total tokens count
        Transfer(owner, msg.sender, numTokens); // Call Transfer event
    }

    function transfer(address _to, uint _value) {
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        Transfer(msg.sender, _to, _value);
    }

    function balanceOf(address _owner) constant returns (uint balance) {
        return balances[_owner];
    }

    function setExchangePrice(uint _ex)
    {
        if(msg.sender != owner) revert();
        ex = _ex;
    }

    function kill() {
        if(msg.sender == owner) selfdestruct(owner);
    }
}