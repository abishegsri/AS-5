pragma solidity ^0.8.14;
import {Voting} from "../src/Voting.sol";
import {Test} from "forge-std/Test.sol";
contract TestVoting is Test
{
    Voting instance;
    function setUp() public
    {
        instance=new Voting();
    }
    function testVote() public
    {
        address randuser=vm.addr(2);
        vm.prank(randuser);
        instance.vote(1);
        assert(instance.addvoted(randuser)==true);
    }
    function testVotedouble() public
    {
        address randuser=vm.addr(2);
        vm.prank(randuser);
        instance.vote(1);
        vm.prank(randuser);
        instance.vote(1);
    }
    function testvotestage() public
    {
        address randuser=vm.addr(2);
        instance.completeVoting();
         vm.prank(randuser);
        instance.vote(1);
    }
    function testCompleteVoting() public{
        instance.completeVoting();
    }
    function testcompletestage() public
    {
        address randuser=vm.addr(3);
         vm.prank(randuser);
        instance.completeVoting();
    }
    function testWinner() public
    {
         address randuser=vm.addr(2);
        vm.prank(randuser);
        instance.vote(1);
        instance.completeVoting();
        assert(instance.delecareWinner()==1);
    }
     function testWinnerstage() public
    {
         address randuser=vm.addr(2);
        vm.prank(randuser);
        instance.vote(1);
        instance.delecareWinner();
    }
       function testWinnerown() public
    {
         address randuser=vm.addr(2);
        vm.prank(randuser);
        instance.vote(1);
        vm.prank(randuser);
        instance.delecareWinner();
    }
}