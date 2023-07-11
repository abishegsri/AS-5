pragma solidity ^0.8.14;
import {Voting} from "../src/Voting.sol";
import {Script} from "forge-std/Script.sol";
contract DeployVoting is Script
{
    Voting instance;
    function run() public returns(Voting)
    {
        vm.startBroadcast();
        instance=new Voting();
        vm.stopBroadcast();
        return instance;
    }
}