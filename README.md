#  💹 Pinance
Pinance는 "Pi"와 "Finance"가 합쳐져 탄생한 금융기업을 위한 그룹웨어 시스템입니다. Pi는 수학 상수로서 무한하고 정확한 숫자를 상징하며, 이는 금융 데이터의 복잡성과 정밀성을 반영합니다.
Pinance는 이러한 두 요소를 결합하여 금융기업이 필요로 하는 모든 기능을 제공하는 통합 솔루션을 제안하고자 하는 프로젝트 입니다. 
***

## :sparkles: [ Summary ]
> 금융기업을 타겟으로한 효율적인 그룹웨어 서비스 <br>
> 출/퇴근, 비품 관리, 전자결재, 게시판, 일정 및 채팅까지 다양한 기능을 통해 업무를 간편하게 관리할 수 있습니다.

## :date: [ Develop Date ]
> <p>$\large{2024.04.15\ ~ \ 2024.06.07}$</p>
> 1주 차 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: 요구사항 제안 및 문서화 <br>
> 2주 차 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: 기능 분석 및 UI설계 <br>
> 3주 차 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: DB설계       <br>
> 4 ~ 7주 차 : 기능 구현                <br>
> 8주 차 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: 기능 테스트  <br>


## 🧑🏻‍💻 [ Contribute ]
> - <p>$\bf{\color{#5882FA} 한수민 : 전자결재}$</p>
> - 박민재 : 로그인, 마이페이지, 회원관리, 메뉴 설정, 알림
> - 이용훈 : 메인페이지, 조직도
> - 이상현 : 전자결재, 채팅
> - 손수현 : 전자게시판, 근태 관리
> - 황수림 : 일정 관리, 시설 관리, 비품 관리


## :four_leaf_clover: [ Stack ]
<div>
  <img src="https://img.shields.io/badge/HTML5-E34F26?logo=html5&logoColor=white" height="30px"> 			&nbsp;
  <img src="https://img.shields.io/badge/CSS3-1572B6?logo=css3&logoColor=white" height="30px"> 				&nbsp;
  <img src="https://img.shields.io/badge/JavaScript-F7DF1E?logo=javascript&logoColor=black" height="30px"> 		&nbsp;
  <img src="https://img.shields.io/badge/jQuery-0769AD?logo=jquery&logoColor=white" height="30px"> 			<br><br>
  <img src="https://img.shields.io/badge/Java11-007396?logo=OpenJDK&logoColor=white" height="30px"> 			&nbsp;
  <img src="https://img.shields.io/badge/Oracle-F80000?logo=oracle&logoColor=white" height="30px"> 			<br><br> 
  <img src="https://img.shields.io/badge/VScode-007ACC?logo=visualstudiocode&logoColor=white" height="30px">  &nbsp;
  <img src="https://img.shields.io/badge/spring-6DB33F?logo=spring&logoColor=white" height="30px"> 			&nbsp;
  <img src="https://img.shields.io/badge/github-181717?logo=github&logoColor=white" height="30px"> 			&nbsp;	<br><br> 
  <img src="https://img.shields.io/badge/bootstrap5-7952B3?logo=bootstrap&logoColor=black" height="30px"> 		&nbsp;
  <img src="https://img.shields.io/badge/maven-C71A36?logo=apachemaven&logoColor=black" height="30px"> 			&nbsp; <br><br>
</div>

***


## ⚙️ [ Functions ]

### 1. [ 전자결재 ]
> 저장되어있는 결재 양식을 가져와 결재 상신을 할 수 있습니다. <br>
> 결재 상신 후 결재가 진행되지 않았을 경우 수정 삭제가 가능합니다. <br>
> 결재 내용은 Naver Smart Editor를 사용하여 입력 할 수 있습니다. <br>
> 결재선은 JSTree를 통하여 조직도를 불러와 선택 할 수 있습니다. <br>

#### 1-1. 결재상신함
> 본인이 기안한 결재 목록을 조회 할 수 있습니다. <br>
> 미결재와 진행중으로 현재 결재상태를 구분하여 확인 할 수 있습니다. <br>
> 결재 상신 제목으로 검색이 가능합니다. <br>
> 기안버튼 클릭 시 기안 페이지로 이동합니다.<br>
> 기안된 목록 중 확인하고자 하는 문서를 선택할 경우 상세 조회 페이지로 이동합니다.<br>
> 결재 상세 조회에서는 본인이 작성한 결재 내용과 결재선을 불러오며 상신을 하였으나 아직 결재진행이 안된 '미결재'건만 수정하기 및 삭제하기 버튼이 보여지도록 jsp에서 처리해 두었습니다.<br>


#### 1-2 결재완료함
> 본인이 기안한 결재가 반려 또는 승인처리 완료된 문서들을 조회 할 수 있습니다.<br>
> 결재상신함과 같은 양식으로 클릭 시 상세 조회 페이지로 이동합니다.<br>

#### 1-3 임시저장함
> 본인이 기안서를 작성 중 임시저장을 할 수 있습니다.<br>
> 임시저장 시 결재선은 저장되지않게하여 결재를 상신할 때 다시 선택하도록 구현하였습니다. 이때, alert메세지로 결재선이 저장되지 않음을 알려줍니다. <br>
> 임시저장된 목록에서 상세조회로 들어갔을 경우 바로 수정하는것이하닌 수정버튼을 통해 문서 수정 후 기안할 수 있습니다.<br>

#### 1-4 자주쓰는 결재선
> 본인이 자주 사용하는 결재선을 저장해 둘 수 있는 기능입니다.<br>
> 결재선 추가 영역에서 JSTree를 사용하여 회사 인원을 확인 할 수 있는 조직도를 불러와 CheckTree를 사용하여 선택 및 정보를 저장 할 수 있습니다.<br>
> 제목과 함께 저장하여 가장 상단에서 저장된 목록을 조회, 삭제가 가능합니다.<br>

#### 1-5 전자결재 기안
> 양식 유형 Select 박스를 클릭 시 ajax를 사용하여 기존에 등록해 둔 결재 양식의 구분 목록이 option으로 조회됩니다.<br>
> 목록 option을 선택 시 다시한번 ajax를 사용하여 해당 목록에 저장되어있는 결재 양식 리스트를 option으로 조회합니다.<br>
> 본인이 기안 할 양식을 선택 할 경우 해당 양식의 정보, 내용이 SmartEditor에 불러와집니다.<br>
> 결재선은 자주쓰는 결재선을 불러와 선택하여 사용할 수 있고, +버튼을 통해 modal창으로 JSTree조직도를 불러와 선택하여 지정 할 수 있습니다.<br>
> 첨부파일을 다중으로 함께 기안 할 수 있습니다. <br>
> 제목 및 내용을 작성 후 기안이 가능합니다. 이때, 필수입력값(양식, 결재선, 제목 등)입력 시 등록버튼이 활성화 됩니다.<br>

#### 1-6 전자결재 수정
> 결재가 진행되기 전에만 가능한 기능이며, 기존에 입력되어있는 내용을 불러오며 임시저장과 같이 결재선은 재선택해야합니다.<br>
> 수정할 내용을 작성 후 등록버튼을 통해 수정이 가능합니다.<br>

#### 1-7 결재대기함 (승인 & 반려)
> 본인이 결재선에 포함되어있고 본인의 결재 순서 일 경우 결재대기함 목록에서 확인이 가능합니다.<br>
> 결재 기안 시 선택한 결재선의 순서 중 첫번째 결재자의 결재 대기함에서 기안된 문서를 확인 할 수 있으며, 승인 시 다음 결재자의 결재대기함으로, 반려시 바로 기안자의 결재완료함에서 확인이 가능합니다. <br>
> 결재 승인 시 마이페이지에서 본인 결재 사인을 등록해 두었을 경우 사인이 보여지며, 결재사인 미등록 시 결재 승인 도장 이미지로 승인처리 됩니다. <br>
> 결재 반려 시 기본 반려이미지로 보이며 본인의 결재순서 뒷사람이 있더라도 바로 반려처리 됩니다.
> 승인 및 반려 버튼은 ajax로 구성하여 버튼 클릭 시 바로 완료된 결재문서를 확인 할 수 있습니다. 

***
#### 자주쓰는 결재선, 결재기안, 임시저장 GIF
![KakaoTalk_20240605_173708570](https://github.com/suminghaan/Pinance/assets/153481563/716d436e-68c8-49e4-9d69-a4510f8a9981)

#### 결재 승인, 반려 GIF
![전자결재승인반려](https://github.com/suminghaan/Pinance/assets/153481563/8aecd1a2-5b1b-4b93-8df0-020d334b3cba)

### ❔ Retrospect
- 기능	<br>
> ▷ 우선 Naver Smart Editor를 처음으로 사용하다보니 내용을 작성하는부분은 어렵지않았지만 해당 작성된 내용 중 필요한 부분을 추출하여 선택하는 과정이 어려웠습니다. 다행이도 친절하게 플래티어의 박종우 멘토님께서 여러 방법을 추천해주셔서 양식등록 시 id 선택자를 미리 두고 해당 양식에 맞게 작성하였을 경우 값을 가져오도록 코드를 작성하였습니다. Editor내에서는 문법이 안먹히는것들이 꽤 많아 추후에 시간을 가지고 공부 해 두어야겠다는 생각을 하게 되는 계기였습니다. <br><br>
> ▷ JStree도 처음 구현하였는데 check, drag & drop 같은 다양한 tree형식과 부모 자식요소를 통해서 선택하는 방법들이 흥미롭고 재미있었습니다. 실제 사이트에서 굉장히 다양하게 많이 사용되고있는 기능이다보니 조직도 외에 다른 프로젝트를 구현 할 때에도 적용시켜보면 좋을 것 같습니다.
> 결재 승인 반려의 경우 처음 DB의 table을 구성할 때 결재 순서까지 고려하지 못하여 어려움이 있었으나 전자결재 대부분의 기능이 결재라인 순서대로 결재를 할 수 있도록 되어있다는것을 jsp를 작성하며 깨닫고 바로 컬럼 추가 및 쿼리문을 수정하여 구현해냈습니다.
      
- 협업에서 부족한 부분		<br>
> ▷ 이번 프로젝트에서는 전자결재의 기능 중 결재 양식 등록 부분을 다른 팀원과 함께하며 jsp작성도 일부 겹치는 부분이 있었습니다. 같은 controller와 service를 구현하다보니 깃으로 commit할 때 충돌이 있기도 하며, 본인이 작성한 부분을 표시를 해두지 않아 헷갈렸던 부분들도 존재 하였습니다. 이러한 경험을 해보니 협업을 할 때에는 충분한 의사소통과 함께 주석을 통해서 본인이 작성한 코드에 대한 설명을 적어주는것이 반드시 필요하다는것을 느꼈습니다. 프로젝트가 마무리 될 때에는 서로 작성한 코드도 확인해주며 원활하게 마무리되어 서로에게 도움이 될 수 있었습니다.<br><br>
> ▷ 프로젝트 마무리가 되어갈 때 즈음 샘플데이터를 위해 DB를 정리하는데 개인사유로 연락을 오후에 확인하게된 적이 있었습니다. 그 때 다른 팀원은 연락이 없어 ERD Cloud기반으로 DB를 다시 세팅하였고 그 중간에 만들어둔 트리거와 일부 수정된 내용들이 사라져 당황했던 경험이 있습니다. 다행이도 기존 DB를 백업해두어 금방 해결 할 수 있었지만 이번 경험을 통해 프로젝트 동안에는 최대한 중요 메세지들을 빠르게 확인하여 코멘트를 주어야하며, 개별 연락이 없다고 하더라도 다시한번 정확하게 체크해보며 혹시모를 경우를 대비하여 백업은 필수로 해두어야한다는 것을 깨닫게 되었습니다.




