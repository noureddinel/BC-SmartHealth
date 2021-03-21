pragma abicoder v2;

//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

contract SessionLogging {
    
    struct Session{
        bool exist;
        int seed;
        string enc_mu;
        }
    mapping(address=> Session) public allSessions;
    
    function updateSession(address user_, int seed_, string memory enc_mu_) public {
        if(!allSessions[user_].exist) {
            allSessions[user_].exist = true; 
        }
        allSessions[user_].enc_mu = enc_mu_;
        allSessions[user_].seed = seed_;
    }
    
    function getLastSession(address user_)public view returns(Session memory) {
        require(allSessions[user_].exist == true);
        return allSessions[user_];
    }
    
}
