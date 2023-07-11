pragma solidity ^0.8.14;
import "@openzeppelin/contracts/access/Ownable.sol";
contract Voting is Ownable
{
    enum Stage{vote,result}
    Stage public stage=Stage.vote;
    struct Candidate
    {
        string name;
    }
    mapping (uint => uint) noofVotes;
    Candidate [] candidates;
    constructor()
    {
        //list of predefined candidates as mentioned in the problem statement
        candidates.push(Candidate("mark"));
        candidates.push(Candidate("john"));
        candidates.push(Candidate("dev"));
        candidates.push(Candidate("sundar"));
    }
    mapping (address => bool) public addvoted;
    function vote(uint _candidateId) public {
        require(stage==Stage.vote,"The Voting Process has been Completed");
        require(addvoted[msg.sender]==false,"Voter can vote only once");
        addvoted[msg.sender]=true;
        noofVotes[_candidateId]++;
    }
    function getVoteCount(uint _candidateId) view internal  returns(uint) 
    {
        return noofVotes[_candidateId];
    }
    function completeVoting() public onlyOwner
    {
        stage=Stage.result;
    }
    function delecareWinner() onlyOwner public view returns(uint)
    {
        require(stage==Stage.result,"Voting has not completed");
        uint length=candidates.length;
        uint maxVotes;
        uint result;
        for(uint i=0;i<length;i++)
        {
            if(getVoteCount(i+1)>maxVotes)
            {
                maxVotes=getVoteCount(i+1);
                result=i+1;
            }
        }
        return result;
    }
}