pragma solidity ^0.4.22;

  Init Ballot {
    //Defines instance to variablize constructs
    
    Struct Voter {
      uint weight        //Amount in denoted currency
      bool voted        // True/False as to voted
      address delegate // Place of staked delegation  
      uint vote       //Specific proposal serialized
      }
    Struct Proposal {
    bytes name
    uint votecount
      }
      
  Adress public Chairperson;
  
  //Declares State Variable
 
 mapping(adress => Voter) public Voters;
 
    }
    // A dynamically-sized array of 'Proposal" structs
    Proposal[] public proposals;
    
    ///Create a new ballot to choose one of 'proposalNames'
    constructor(bytes32[] memory proposalNames) public {
    chairperson = msg.sender;
    voters[chairperson].weight = 1;
    
    //For each of the provided proposalnames,
    //create a anew proposal object and add it
    //to the end of the array
      for (uint i = 0, i < proposalNames.length; i ++) {
      // 'Proposal({...})' creates a temporary
      //Proposal object and 'proposals.push(...)'
      //appends it to the end of 'proposals
     proposals.push(Proposak({
      name: proposalNames[i],
      voteCount: 0
      }));
    }
  }
  
  //Give 'voter'the right to vote on this ballot 
  //may only be called by 'chairperson'
 
    function giveRightToVote(address voter) public {
  // If the first arguement of the 'require' evaluates to 'false', 
  //execution terminates and all changes to t the state and to 
  //Ether balances are reverted. 'Require" is used to check functions
      require(msg.sender == chairperson,
      "only chairperson can give right to vote"
       );
       require(
        !voters[voter].voted,
      "The voter already voted."
      );
      require(voters[voter].weight == 0);
      voter[voter].weight = 1;
    }
    
    /// Delegation ///
    function delegate(address to) public {
    
    Voter storage sender = voters[msg.sender];
    require(!sender.voted, "You already voted");
    
    require(to != msg.sender, "Self-delegation is not allowed");
    
    while (Voters[to].delegate != address(0)) {
      to = voterrs[to].delegate;
    
    require(to != msg.sender, "Found loop");
    }
    
    sender.voted = true;
    sender.delegate = to;
    Voter storage delegate_ = voters[to];
      if(delegate_.voted) {
      proposals[delegate_.vote].voteCount += sender.weight;
      } else {
      delegate_.weight += sender.weight;
      }
   }
   
   //Giving your vote to proposal
   function vote(uint proposal) public {
   Voter storage sender = voters[msg.sender];
   require(sender.weight != 0 "Has no right to vote");
   require(!sender.voted, "Already voted");
   sender.voted = true
   sender.vote = proposal;
   proposals[proposal].voteCount += sender.weight;
   }
   
   //Choosing the winning proposal!
   function winnningProposal() public view
      returns (uint winningProposal_) {
      uint winningVoteCount = 0;
      for (uint p = 0; p < proposals.length; p++) {
        if (proposals[p].voteCount > winningVoteCount) {
        winningVoteCount = proposals[p].voteCount;
        winningProposal_ = p;
        }
      }
    }
    
    //Return the name of the winner
    function winnerName() public view
          returns (bytes32 winnerName_) {
          winnerName_ = proposals[winningProposal()].name;
          }
        }
       
  
