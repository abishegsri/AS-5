pragma solidity ^0.8.14;
import "@openzeppelin/contracts/access/Ownable.sol";
contract Voting is Ownable
{
    mapping (address=>bytes32) Voterscommit;
    mapping (string=>uint) votes;
        struct Candidate
    {
        string name;
    }
    Candidate [] candidates;
    constructor()
    {
        //list of predefined candidates as mentioned in the problem statement
        candidates.push(Candidate("mark"));
        candidates.push(Candidate("john"));
        candidates.push(Candidate("dev"));
        candidates.push(Candidate("sundar"));
    }
    enum Stage{commit,reveal}
    Stage stage=Stage.commit;
    mapping (address => bool)addvoted;
    function vote_commit(bytes32 cand) public 
    {
        require(stage==Stage.commit,"Voting is not completed");
        require(addvoted[msg.sender]==false,"Voter can vote only once");
        addvoted[msg.sender]=true;
        Voterscommit[msg.sender]=cand;
    }
    function revealVote(string memory name,string memory salt) public
    {
        require(stage==Stage.reveal);
        require(keccak256(abi.encodePacked(name,salt))==Voterscommit[msg.sender]);
        votes[name]++;
    }
    function delecareWinner() onlyOwner public view returns(string memory)
    {
        require(stage==Stage.reveal,"Voting has not completed");
        uint length=candidates.length;
        uint maxVotes;
        string memory result;
        for(uint i=0;i<length;i++)
        {
           if(votes[candidates[i].name]>maxVotes)
           {
               maxVotes=votes[candidates[i].name];
               result=candidates[i].name;
           }
        }
        return result;
    }
    function giveHash(string memory name,string memory salt) public pure returns(bytes32)
    {
        return keccak256(abi.encodePacked(name,salt));
    }
    function completeVoting() public onlyOwner
    {
        stage=Stage.reveal;
    }
}
