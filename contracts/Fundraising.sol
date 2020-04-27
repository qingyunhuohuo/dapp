pragma solidity >=0.4.21 <0.7.0;

contract Fundraising {

    address payable public beneficiary;//募捐受益人
    uint public endTime;//结束时间
    uint public target;//目标金额
    uint public money;//当前已获金额
    uint public restMoney;//合约里的金额
    bool public isCancel;//是否取消募捐
    uint public ftype = 1;//定义筹款类型

    mapping(address => uint) public p_money;//捐赠金额
    address[] public participants;//捐赠者

    mapping(address => uint) public t_money;//当前捐赠金额
    address[] t_participants;//当前捐赠者

    event OneDonate(address participant, uint money);

    constructor(address payable _beneficiary, uint _target, uint _time) public {
        beneficiary = _beneficiary;
        target = _target;
        endTime = now + _time;
        money = 0;
        restMoney = 0;
        isCancel = false;
    }

    //捐款
    function donate() public payable {
        require(!isCancel);
        require(now <= endTime);
        require(money < target);
        uint realD = msg.value;
        //金额超出目标时退还一部分
        if (msg.value + money > target) {
            realD = target - money;
            msg.sender.transfer(msg.value - realD);
        }
        money += realD;
        restMoney += realD;
        if (p_money[msg.sender] == uint(0)){
            participants.push(msg.sender);
        }
        if (t_money[msg.sender] == uint(0)){
            t_participants.push(msg.sender);
        }
        p_money[msg.sender] += realD;
        t_money[msg.sender] += realD;
        emit OneDonate(msg.sender, realD);
    }

    //受益人取钱
    function withdraw() public {
        require(!isCancel);
        require(msg.sender == beneficiary);
        require(restMoney > 0);
        for(uint i = 0; i < t_participants.length; i++) {
            delete t_money[t_participants[i]];
        }
        delete t_participants;
        beneficiary.transfer(restMoney);
        restMoney = 0;
    }

    //放弃募捐
    function cancel() public {
        require(msg.sender == beneficiary);
        require(!isCancel);
        isCancel = true;
    }

    //捐赠者退款
    function drawback() public {
        require(isCancel);
        require(t_money[msg.sender] > 0);
        
        msg.sender.transfer(t_money[msg.sender]);
        restMoney = restMoney - t_money[msg.sender];
        t_money[msg.sender] = 0;
    }

    function getTarget() public view returns (uint) {
        return target;
    }

    function getMoney() public view returns (uint) {
        return money;
    }

    function getIsCancel() public view returns (bool) {
        return isCancel;
    }

    function getBeneficiary() public view returns (address) {
        return beneficiary;
    }

    function getRestTime() public view returns (uint) {
    	if (now < endTime) {
    		return (endTime - now);
    	}
        return 0;
    }

    function getParticipantNum() public view returns (uint) {
        return participants.length;
    }
}