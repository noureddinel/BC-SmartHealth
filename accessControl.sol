//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;


contract AccessControl{
    
    address private _owner;
    struct MyAuthUsers {
        bool registered;
        address[] users; 
        }
        
    modifier onlyOwner () {
        require(msg.sender == _owner);
        _;
    }
    
    constructor () {
        _owner = msg.sender;
    }
        
    mapping(address=> MyAuthUsers) public authUsers;
    mapping (address => uint256) public usersIndex;
    
    function authorizeNewUsers(address[] memory users_) public onlyOwner {
        if (!authUsers[msg.sender].registered) {
            authUsers[msg.sender].registered =true; 
        }
        for (uint256 i = 0; i < users_.length; i++) {
            authUsers[msg.sender].users.push(users_[i]);
            usersIndex[users_[i]] = i;
        }
    }
    
    function revokeUsers (address[] memory users_) public onlyOwner{
        for(uint256 i = 0; i < users_.length; i++) { 
            authUsers[msg.sender].users[usersIndex[users_[i]] ] =  authUsers[msg.sender].users[authUsers[msg.sender].users.length - 1]; 
            authUsers[msg.sender].users.pop();
        }
    }
    
    function getAuthorizedUsers(address patient_) public view returns(address [] memory ) {
        require(authUsers[patient_].registered ==true);
        return authUsers[patient_].users;
    }
        
    function isAuthorized(address patient_,address user_) public view returns(bool) { 
        require(authUsers[patient_].registered ==true);
        for(uint256 i = 0; i< authUsers[patient_].users.length; i++) {
            if(authUsers[patient_].users[i] == user_) {
                return true; 
            } 
        }
        return false;
    }
    
}
    
