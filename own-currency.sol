/*
Powered by:Kuznetsoff.Laboratory
http://7905415.ru
andrey@kuznetsoff.com
ISVTeam
info@isvteam.com
For Arm-Money, INC
http://ArmMoneyINC.com
armmoneyru@gmail.com
@version 1.0.1
*/
pragma solidity ^0.4.11;
contract ERC20 {
    uint public totalSupply;
    function balanceOf(address who) constant returns (uint);
    function transfer(address to, uint value);
    event Transfer(address indexed from, address indexed to, uint value);
}
contract AMT is ERC20 {
    string public constant name = "Arm-Money Token (AMT)";
    string public constant symbol = "AMT";
    uint8 public constant decimals = 0;
    mapping (address => uint) balances;
    // Custom properties
    uint public ex;
    address public owner;
    // Modifiers
    modifier ownerOnly() {
        if (msg.sender != owner) {
            revert();
        }_;
    }
    // Constructor - will be call only on contract creation
    function AMT(uint _ex, uint initialCount) {
        balances[msg.sender] = initialCount;
        owner = msg.sender;
        totalSupply = initialCount;
        setExchangePrice(_ex);
    }

    // The main contract function
    function buyTokens() payable external {
        if (msg.value == 0) revert();
        var numTokens = msg.value/ex; // Calculate count of tokens
        if(numTokens == 0) revert();
        balances[msg.sender] += numTokens; // Update buyer balance
        balances[owner]  -= numTokens; // Update seller balance
        totalSupply = balances[owner]; // Update total tokens count
        Transfer(owner, msg.sender, numTokens); // Call Transfer event
    }

    // Transfer tokens between members using this contract functionality
    function transfer(address _to, uint _value) {
        if(balanceOf(msg.sender) < _value) revert(); // Check if sender have tokens
        // Update balances
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        Transfer(msg.sender, _to, _value);
    }

    // Get tokens count by address
    function balanceOf(address _owner) constant returns (uint balance) {
        return balances[_owner];
    }

    // Set sell price per one token
    function setExchangePrice (uint _ex) ownerOnly {
        ex = _ex;
    }

    // Destruct contract and send funds to contract owner
    function kill() ownerOnly {
        if(msg.sender == owner) selfdestruct(owner);
    }
}