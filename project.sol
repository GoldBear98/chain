pragma solidity >=0.4.22 <0.7.0;

contract project
{
    struct Receipt 
    {
        uint amount; 
        uint number;
	    address c; //come
	    address t; //to
    }
    address public bank;
    mapping (uint => Receipt) public receipt;
    mapping (address => uint) public balance;
    constructor()
    {
        bank=msg.sender;
    }
    //Function One
    function PurchaseGoodsIssueReceivables(address receive, uint _amount, uint _number)
    {
        balance[msg.sender] -= _amount;
        balance[receive] += _amount;
        receipt[_number].amount = _amount;
        receipt[_number].number = _number;
        receipt[_number].c = msg.sender;
        receipt[_number].t = receive;
    }
    //Function Two
    function TransferReceivables(uint x, uint y)
    {
        if(receipt[x].c != msg.sender)
        {
            return;
        }
        if(receipt[y].c == receipt[x].t)
        {
            receipt[x].amount -= receipt[y].amount;
            receipt[y].c = receipt[x].c;
        }
    }
    //Function Three
    function UseReceivablesToFinanceBank(uint x)
    {
        if(receipt[x].amount <= 0 || receipt[x].c != msg.sender)
        {
            return;
        }
        balance[msg.sender] += receipt[x].amount;
        receipt[x].c=bank;
    }
    //Function Four
    function PaymentSettlementOfAccountsReceivables(uint x)
    {
        if(receipt[x].amount <= 0 || receipt[x].c != msg.sender || receipt[x].amount > balance[receipt[x].t])
        {
            return;
        }
        balance[msg.sender] += receipt[x].amount;
        balance[receipt[x].t] -= receipt[x].amount;
        receipt[x].amount = 0;
    }
}
