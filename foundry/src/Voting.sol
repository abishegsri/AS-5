contract Voting is Ownable
{
    enum Stage{vote,result}
    Stage public stage=Stage.vote;
    struct Candidate
    {
        string name;
    }
    mapping (bytes32=>string) hashtoname;
    function returnHash(string memory name) public returns (bytes32)
    {
        hashtoname[keccak256(bytes(name))]=name;
        return keccak256(bytes(name));
    }
    mapping (uint => uint) noofVotes;
    mapping(string => uint )nametoid;
    Candidate [] candidates;
    constructor()
    {
        //list of predefined candidates as mentioned in the problem statement
        candidates.push(Candidate("mark"));
        nametoid["mark"]=1;
        candidates.push(Candidate("john"));
        nametoid["john"]=2;
        candidates.push(Candidate("dev"));
        nametoid["dev"]=3;
        candidates.push(Candidate("sundar"));
        nametoid["sundar"]=4;
    }
    mapping (address => bool) public addvoted;
    function vote(bytes32 candi) public {
        require(stage==Stage.vote,"The Voting Process has been Completed");
        require(addvoted[msg.sender]==false,"Voter can vote only once");
        addvoted[msg.sender]=true;
        noofVotes[nametoid[hashtoname[candi]]]++;
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
