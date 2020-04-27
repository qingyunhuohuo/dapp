pragma solidity >=0.4.21 <0.7.0;

contract Blacklist {
	address public owner;//黑名单创建者
	mapping(address => uint) public good;
	mapping(address => uint) public bad;
	address[] public badusers;//黑名单账户

	event OneGoodUserAdd(address adder, address user);
	event OneGoodUserDel(address adder, address user);
	event OneBadUserAdd(address adder, address user);
	event OneBadUserDel(address adder, address user);

	constructor(address _owner) public{
		owner = _owner;
		good[_owner] = 1;
	}

	function addGoodUser(address oneuser) public{
		require(msg.sender == owner);
		require(good[oneuser] == 0);
		good[oneuser] = 1;
		emit OneGoodUserAdd(msg.sender, oneuser);
	}

	function deleteGoodUser(address oneuser) public{
		require(msg.sender == owner);
		require(good[oneuser] > 0);
		good[oneuser] = 0;
		emit OneGoodUserDel(msg.sender, oneuser);
	}

	function addBadUser(address oneuser) public{
		require(good[msg.sender] > 0);
		require(bad[oneuser] == 0);
		bad[oneuser] = 1;
		badusers.push(oneuser);
		emit OneBadUserAdd(msg.sender, oneuser);
	}

	function deleteBadUser(address oneuser) public{
		require(good[msg.sender] > 0);
		require(bad[oneuser] > 0);
		bad[oneuser] = 0;
		for (uint i = 0; i < badusers.length - 1; i++){
			if(badusers[i] == oneuser){
				badusers[i] = badusers[badusers.length - 1];
			}
		}
		delete badusers[badusers.length - 1];
		badusers.length--;
		emit OneBadUserDel(msg.sender, oneuser);
	}

	function getBadUsers() public view returns (address[] memory) {
		return badusers;
	}
}