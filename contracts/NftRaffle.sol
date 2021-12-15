// // SPDX-License-Identifier: MIT
// pragma solidity ^0.5.16;

// import "./funding/funding.sol";
// import "./token/ERC721.sol";

// contract NftRaffle is funding, ERC721 {
    
//     address[] public participantAddress;  // 펀딩한 사람의 주소 
//     uint256 public startTime;             // 펀딩 시작
//     uint256 public endTime;               // 펀디 끝
//     uint256 public fundingAmount;         // 펀딩 금액
//     uint256 public fundingGoal;           // 목표 값
    
//     uint256 public investmentReceived;    // 펀딩 등록 
//     uint256 public investmentRefunded;    // 환불
    
//     bool public isFinalized;              // 펀딩 Status
//     bool public isRefundingAllowed;       // 환급 가능 상태 확인 ?

//     // 펀딩에 관련된 Data
//     constructor(uint256 _startTime, uint256 _endTime, 
//     	uint256 _fundingAmount, uint256 _fundingGoal) 
//     	payable public
//     {
//         require(_startTime >= now);
//         require(_endTime >= _startTime);
//         require(_fundingAmount != 0);
//         require(_fundingGoal != 0);
    	
//         startTime = _startTime;
//         endTime = _endTime;
//         fundingAmount = _fundingAmount;
//         fundingGoal = _fundingGoal;

//         isFinalized = false;
//     }
    
//     event LogInvestment(address indexed investor, uint256 value);
//     // event LogTokenAssignment(address indexed investor, uint256 numTokens);
//     event Refund(address investor, uint256 value);
    
//     function invest() public payable {
//         require(isValidInvestment(msg.value));
//         require(now < endTime);
 
//         investmentReceived += fundingAmount; 

//         participantAddress.push(msg.sender);
//     }

//     function isValidInvestment(uint256 _investment) internal view returns (bool) {
//         bool isInvestmenPrice = fundingAmount == _investment;   
//         bool nonZeroInvestment = _investment != 0;
//         bool withinCrowdsalePeriod = now >= startTime && now <= endTime; 
    		
//         return nonZeroInvestment && isInvestmenPrice && withinCrowdsalePeriod;
//     }
    
//     function finalize() onlyOwner public {
//         if (isFinalized) revert();
    
//         bool isCrowdsaleComplete = now > endTime; 
//         bool investmentObjectiveMet = investmentReceived >= fundingGoal;
            
//         if (isCrowdsaleComplete)
//         {     
//             if (investmentObjectiveMet)
//                 crowdsaleToken.release();
//                 // NFT 보내주는 FUNCTION 추가
//             else 
//                 isRefundingAllowed = true;
//                 // refund method 쓸수도 있음
//                 // mapping의 key를 전부 가져오고 전부 for 문을 사용하여 refund 진행
    
//             isFinalized = true;
//         }               
//     }
    
//     function refund() public {
//         if (!isRefundingAllowed) revert();
    
//         address investor = msg.sender;
//         uint256 investment = participantAddress[investor];
//         if (investment == 0) revert();
//         participantAddress[investor] = 0;
//         investmentRefunded += investment;
//         emit Refund(msg.sender, investment);
    
//         if (!investor.send(investment)) revert();
//     }

//     function refund(address _participant) internal {
//         if (!isRefundingAllowed) revert();
    
//         address investor = _participant;
//         uint256 investment = participantAddress[investor];
//         if (investment == 0) revert();
//         investmentAmountOf[investor] = 0;
//         investmentRefunded += investment;
//         emit Refund(_participant, investment);
    
//         if (!investor.send(investment)) revert();
//     }

//     function drawWinner() public {    //당첨자 추첨
//         require(now > endTime + 5 minutes);
//         require(winner == address(0));    //아직 당첨자 추첨이 진행되지 않은 것을 검증하기 위해 require()문으로 당첨자의 주소는 0으로 설정

//         bytes32 rand = keccak256(             // 
//             block.blockhash(block.number-1)    //최근 블록 해시를 해시하여 임의의 바이트 열 생성
//         );

//         // 1. for문 사용 
//         // 2. rend 값을 참가자 수로 나눈 나머지 값을 funding 변수 인덱스로 사용
        
//         winner= tickets[uint(rand) % tickets.length];

//     }        
// }