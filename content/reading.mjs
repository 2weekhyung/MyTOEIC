// Original MyTOEIC RC learning texts. Correct choice is first in source; generation rotates positions.
const question=(category,prompt,translation,explanation,choices)=>({category,prompt,translation,explanation,choices});
const passage=(title,format,body,translation)=>({title,format,body,translation});
const p6directions='지문 전체를 먼저 읽고 [1]~[4]에 들어갈 단어·문장 중 가장 알맞은 것을 고르세요. 제목으로 상황을 파악하고, 빈칸 앞뒤의 시제·문법·연결 관계를 확인하세요.';
const p7directions='문서 제목으로 상황을 파악한 뒤 질문의 핵심어를 찾아 읽으세요. 날짜·시간·가격과 예외 조건을 구분하세요. 여러 문서가 있으면 같은 이름·주문번호·날짜를 연결해 답의 근거를 찾으세요.';
export const readingSets=[
{code:'p6-training',kind:'PART6',title:'신입 직원 교육 안내 이메일',difficulty:1,directions:p6directions,
 passages:[passage('New Employee Training','EMAIL',`To: New employees
From: Hana Lee, Training Coordinator
Subject: Friday training session

Thank you for joining our team. We [1] your registration forms yesterday. Your first training session will take place this Friday from 9 a.m. to noon in Room 201. Please arrive ten minutes early so that we can begin on time.

Each employee will receive a [2] with the training schedule and safety rules. Please read it before the session starts. The training room has computers for everyone. [3]

Coffee and water will be available, [4] lunch will not be provided. Please bring your own lunch if you plan to stay for the afternoon office tour. Contact me by Thursday if you have any questions.`,
`수신: 신입 직원 / 발신: 교육 담당자 하나 리 / 제목: 금요일 교육

우리 팀에 합류해 주셔서 감사합니다. 어제 등록 서류를 받았습니다. 첫 교육은 이번 금요일 오전 9시부터 정오까지 201호에서 열립니다. 제시간에 시작할 수 있도록 10분 일찍 도착해 주세요.

각 직원은 교육 일정과 안전 수칙이 담긴 안내서를 받습니다. 교육 시작 전에 읽어 주세요. 교육실에는 모두 사용할 수 있는 컴퓨터가 있습니다. 따라서 노트북을 가져올 필요는 없습니다.

커피와 물은 제공되지만 점심은 제공되지 않습니다. 오후 사무실 견학에 남을 예정이라면 점심을 가져오세요. 질문이 있으면 목요일까지 연락해 주세요.`)],
 questions:[
question('tense','[1]에 알맞은 단어를 고르세요.','어제 등록 서류를 받았습니다.','yesterday는 이미 끝난 과거의 단서예요. receive의 과거형 received가 필요해요.',['received|어제 끝난 행동을 나타내는 과거형이에요.','receive|현재형으로 yesterday와 맞지 않아요.','receives|현재 단수형이며 주어 We와도 맞지 않아요.','receiving|-ing형만으로 이 문장의 동사 자리를 채울 수 없어요.']),
question('text-vocabulary','[2]에 알맞은 단어를 고르세요.','각 직원은 교육 일정과 안전 수칙이 담긴 안내서를 받습니다.','뒤에서 it을 읽으라고 하므로 읽을 수 있는 안내 자료인 handbook이 맞아요.',['handbook|일정과 안전 수칙을 담아 읽는 안내서예요.','receipt|영수증은 구매 기록이라 교육 일정·수칙이라는 내용과 맞지 않아요.','ticket|입장권이라는 뜻으로 교육 안내 자료가 아니에요.','invoice|청구서라는 뜻으로 교육 안내 자료가 아니에요.']),
question('text-sentence','[3]에 들어갈 가장 자연스러운 문장을 고르세요.','따라서 노트북을 가져올 필요는 없습니다.','앞 문장에서 모두 사용할 컴퓨터가 있다고 했어요. 그래서 개인 노트북이 필요 없다는 문장이 자연스럽게 이어져요.',['You do not need to bring a laptop.|교육실의 컴퓨터를 쓸 수 있다는 앞 내용의 결과예요.','The registration deadline was moved to next month.|이미 어제 등록 서류를 받았고 금요일 교육이므로 다음 달 마감으로 바뀌었다는 내용은 흐름과 맞지 않아요.','Please send payment for your computer today.|컴퓨터 구매나 결제는 언급되지 않았어요.','The afternoon tour has already ended.|견학은 금요일 오후에 있을 예정이지 이미 끝난 일이 아니에요.']),
question('text-connector','[4]에 알맞은 연결어를 고르세요.','커피와 물은 제공되지만 점심은 제공되지 않습니다.','제공되는 음료와 제공되지 않는 식사를 대조하므로 but을 써요.',['but|서로 다른 제공 조건을 대조해요.','because|점심 미제공이 음료 제공의 이유라는 관계는 아니에요.','unless|~하지 않는 한이라는 조건 관계가 아니에요.','so|음료 제공 때문에 점심을 안 준다는 인과관계는 아니에요.'])]},
{code:'p6-library',kind:'PART6',title:'도서관 임시 휴관 공지',difficulty:1,directions:p6directions,
 passages:[passage('Temporary Library Closure','NOTICE',`Westfield Library will be closed on Saturday, November 7, while workers replace the lights in the main reading room. The work is [1] to finish that evening, and the library will reopen at its usual time of 10 a.m. on Sunday.

During the closure, you can still use our website to renew books and search the online catalog. [2] books that are due on Saturday, the return date will automatically change to Sunday. You will not need to call us to request this change.

The outdoor return box will remain open. [3] Please use the box only for books, not for tablets or other electronic equipment. Our employees [4] you for your patience during this improvement work.`,
`웨스트필드 도서관은 주 열람실 조명을 교체하는 11월 7일 토요일에 문을 닫습니다. 작업은 그날 저녁 끝날 예정이며, 일요일에는 평소처럼 오전 10시에 다시 엽니다.

휴관 중에도 웹사이트에서 대출을 연장하고 온라인 목록을 검색할 수 있습니다. 토요일이 반납일인 책은 반납일이 자동으로 일요일로 바뀝니다. 이 변경을 요청하려고 전화할 필요는 없습니다.

야외 반납함은 계속 열려 있습니다. 도서관 문이 닫혀 있어도 그곳에 책을 반납할 수 있습니다. 태블릿이나 다른 전자 장비는 넣지 말고 책만 반납해 주세요. 직원들은 시설 개선 중 기다려 주시는 데 감사드립니다.`)],
 questions:[
question('text-vocabulary','[1]에 알맞은 단어를 고르세요.','작업은 그날 저녁 끝날 예정입니다.','is expected to finish는 끝날 것으로 예상된다는 뜻이에요. 예상 일정에 맞는 expected를 골라요.',['expected|is expected to finish는 끝날 것으로 예상된다는 자연스러운 표현이에요.','invited|작업 자체를 초대한다는 뜻은 이 문맥에 맞지 않아요.','borrowed|작업을 빌렸다는 뜻은 끝날 예정이라는 문맥과 맞지 않아요.','paid|작업이 끝나도록 급여를 받는다는 표현은 자연스럽지 않아요.']),
question('text-connector','[2]에 알맞은 단어를 고르세요.','토요일이 반납일인 책은 반납일이 자동으로 일요일로 바뀝니다.','For books that are due on Saturday는 토요일 반납 예정인 책에 대해서는이라는 뜻이에요. 적용 대상을 소개하는 For가 맞아요.',['For|어떤 책에 규칙이 적용되는지 나타내요.','During|기간을 나타내는 말이 뒤에 와야 하므로 books와 맞지 않아요.','Between|둘 사이의 관계를 나타내며 여기서 필요한 적용 대상 소개가 아니에요.','Despite|책에도 불구하고라는 양보 관계는 문맥과 맞지 않아요.']),
question('text-sentence','[3]에 들어갈 가장 자연스러운 문장을 고르세요.','도서관 문이 닫혀 있어도 반납함에 책을 반납할 수 있습니다.','앞 문장의 outdoor return box가 어떤 용도로 계속 열려 있는지 설명하는 문장이 맞아요.',['You may leave your books there even when the building is closed.|there는 앞의 야외 반납함을 가리켜요.','All online services will be unavailable until Monday.|앞에서 웹사이트의 대출 연장·검색을 이용할 수 있다고 했어요.','The library will stay closed throughout Sunday.|앞에서 일요일 오전 10시에 재개관한다고 했어요.','Please return all tablets through the box.|다음 문장에서 반납함에 전자 장비를 넣지 말라고 했어요.']),
question('verbs','[4]에 알맞은 단어를 고르세요.','직원들은 기다려 주셔서 감사합니다.','employees는 복수 주어이므로 현재형 thank를 써요. thank you for는 무엇에 대해 감사한다는 표현이에요.',['thank|복수 주어 employees와 맞는 현재형이에요.','thanks|3인칭 단수 주어의 형태라 복수 employees와 맞지 않아요.','thanking|be 없이 이 자리의 현재 동사가 될 수 없어요.','thankful|감사하는이라는 형용사라 are 같은 동사가 추가로 필요해요.'])]},
{code:'p6-delivery',kind:'PART6',title:'배송 일정 변경 이메일',difficulty:1,directions:p6directions,
 passages:[passage('Update on Order 482','EMAIL',`Dear Ms. Park,

Thank you for ordering office chairs from Maple Furniture. Your order was originally scheduled to arrive on Wednesday. [1], a road closure near our warehouse has delayed the shipment. We now expect your chairs to arrive on Friday between 1 p.m. and 3 p.m.

Our driver will call you thirty minutes before [2]. Please make sure that someone is available to receive the chairs. [3] If Friday is not convenient, reply to this message by Tuesday afternoon so that we can arrange a different date.

We are sorry for the delay. The delivery fee will be [4] from your bill, so you will pay only for the chairs. Thank you for your understanding.

Sincerely,
Daniel Cho`,
`박 고객님께,

메이플 가구에서 사무용 의자를 주문해 주셔서 감사합니다. 원래 수요일 배송 예정이었지만 창고 근처 도로 폐쇄로 배송이 늦어졌습니다. 현재 금요일 오후 1~3시에 도착할 것으로 예상합니다.

운전기사는 도착 30분 전에 전화할 것입니다. 의자를 받을 사람이 있도록 해 주세요. 의자를 창고에 다시 가져가지 않도록 하기 위한 조치입니다. 금요일이 불편하면 화요일 오후까지 이 메시지에 답해 다른 날짜를 정해 주세요.

지연에 사과드립니다. 배송료는 청구서에서 제외하므로 의자 값만 내시면 됩니다. 이해해 주셔서 감사합니다.

다니엘 조 드림`)],
 questions:[
question('text-connector','[1]에 알맞은 연결 표현을 고르세요.','하지만 도로 폐쇄로 배송이 늦어졌습니다.','수요일 도착이라는 원래 계획과 지연된 상황을 대조하므로 However가 맞아요.',['However|하지만이라는 뜻으로 계획과 다른 상황을 이어 줘요.','Therefore|그러므로라는 뜻이지만 원래 수요일 일정이 도로 폐쇄의 원인은 아니에요.','For example|도로 폐쇄는 원래 일정의 예시가 아니에요.','Similarly|서로 비슷한 두 상황을 나열하는 문맥이 아니에요.']),
question('parts','[2]에 알맞은 단어를 고르세요.','운전기사는 도착 30분 전에 전화할 것입니다.','before 뒤에서 도착이라는 일의 이름을 나타내는 명사 arrival이 자연스러워요.',['arrival|도착이라는 명사예요.','arrive|동사원형만으로 before 뒤에 이처럼 쓰지 않아요.','arrives|주어 없이 이 현재형 동사만 쓸 수 없어요.','arrived|주어 없이 이 과거형 동사만 쓸 수 없어요.']),
question('text-sentence','[3]에 들어갈 가장 자연스러운 문장을 고르세요.','의자를 다시 창고로 가져가지 않도록 하기 위한 조치입니다.','앞에서 수령인이 있어야 한다고 했어요. 그 이유를 설명하는 문장이 자연스러워요.',['This will help us avoid taking the chairs back to the warehouse.|수령인이 없으면 물건을 다시 가져가야 하는 상황을 설명해요.','Your chairs were delivered successfully last Monday.|아직 금요일에 배송할 예정이므로 이미 배송했다는 말과 맞지 않아요.','Please collect the chairs from our store on Wednesday.|새 계획은 금요일 방문 배송이며 매장 수령을 요청하지 않았어요.','We no longer sell office furniture.|현재 의자 주문을 처리하는 내용과 맞지 않아요.']),
question('text-vocabulary','[4]에 알맞은 단어를 고르세요.','배송료는 청구서에서 제외됩니다.','뒤에서 의자 값만 낸다고 했으므로 배송료를 removed, 즉 제거한다는 뜻이어야 해요.',['removed|청구서에서 배송료를 빼 준다는 뜻이에요.','increased|배송료가 오르면 의자 값만 낸다는 내용과 맞지 않아요.','added|배송료를 더하면 의자 값만 내는 것이 아니에요.','copied|배송료를 복사한다는 뜻은 비용을 빼 준다는 문맥과 맞지 않아요.'])]},
{code:'p6-booking',kind:'PART6',title:'회의실 예약 규정 공지',difficulty:1,directions:p6directions,
 passages:[passage('New Meeting Room Booking Process','NOTICE',`Starting next month, all meeting rooms must be booked through the company website. The new system allows employees [1] room availability before making a reservation. This should reduce scheduling problems between departments.

To book a room, choose a date, a start time, and the number of people attending. Then click the confirmation button. You will receive a [2] email within five minutes. Please keep this message because it includes a link for changing your booking.

Each reservation may last for up to two hours. [3] For longer meetings, contact the office manager before booking. If your meeting is canceled, please release the room [4] so that other employees can use it.`,
`다음 달부터 모든 회의실은 회사 웹사이트에서 예약해야 합니다. 새 시스템은 예약 전에 직원들이 회의실 이용 가능 여부를 확인할 수 있게 합니다. 부서 간 일정 충돌이 줄어들 것으로 기대합니다.

날짜, 시작 시각, 참석 인원을 선택하고 확인 버튼을 누르세요. 5분 안에 확인 이메일을 받게 됩니다. 예약 변경 링크가 있으니 보관해 주세요.

예약 한 건은 최대 2시간입니다. 이 시간 제한은 소형·대형 회의실에 모두 적용됩니다. 더 긴 회의는 예약 전에 사무 관리자에게 연락하세요. 취소된 회의실은 다른 직원들이 사용할 수 있도록 신속히 반납 처리해 주세요.`)],
 questions:[
question('verbs','[1]에 알맞은 표현을 고르세요.','새 시스템은 직원들이 이용 가능 여부를 확인할 수 있게 합니다.','allow + 사람 + to + 동사원형은 누군가가 무엇을 하도록 허용한다는 구조예요.',['to check|allows employees to check가 올바른 구조예요.','check|이 구조에서는 사람 뒤에 to가 필요해요.','checked|사람 뒤에 동사의 과거형을 놓는 구조가 아니에요.','checks|사람 뒤에 현재 단수형을 놓는 구조가 아니에요.']),
question('text-vocabulary','[2]에 알맞은 단어를 고르세요.','5분 안에 확인 이메일을 받습니다.','예약을 완료했다는 정보를 보내므로 confirmation email이라는 표현이 맞아요.',['confirmation|예약 확인이라는 뜻으로 이메일의 용도에 맞아요.','rejection|예약을 거절했다는 말은 이 예약 성공 안내와 맞지 않아요.','complaint|불평이라는 뜻으로 예약 완료 안내와 맞지 않아요.','advertising|예약 변경 링크가 든 확인 안내를 광고로 설명하지 않아요.']),
question('text-sentence','[3]에 들어갈 가장 자연스러운 문장을 고르세요.','이 시간 제한은 소형·대형 회의실 모두에 적용됩니다.','앞 문장의 최대 두 시간이라는 제한을 구체적으로 설명한 뒤, 긴 회의의 예외 신청 방법으로 이어져요.',['This limit applies to both small and large meeting rooms.|This limit은 앞에서 말한 두 시간 제한을 받아요.','The website will not show any available rooms.|앞에서 웹사이트에서 이용 가능 여부를 볼 수 있다고 했어요.','All reservations must be made by telephone.|앞에서 웹사이트를 통해 예약해야 한다고 했어요.','There is no limit on the length of a reservation.|앞에서 최대 두 시간이라고 했어요.']),
question('modifiers','[4]에 알맞은 단어를 고르세요.','취소된 회의실은 신속히 반납 처리해 주세요.','release라는 행동을 어떻게 하는지 꾸미므로 부사 promptly를 써요.',['promptly|신속히라는 부사로 release를 꾸며요.','prompt|여기서는 형용사라 이 행동의 방식을 나타내는 자리에 맞지 않아요.','promptness|신속함이라는 명사예요.','prompted|동사의 과거형 또는 분사로 이 부사 자리에 맞지 않아요.'])]},
{code:'p7-computer-email',kind:'PART7',title:'수리 완료 노트북 수령 안내',difficulty:1,directions:p7directions,
 passages:[passage('Your Laptop Is Ready','EMAIL',`To: Mina Park
From: Green Street Computer Service
Subject: Repair completed

Dear Ms. Park,

Your laptop repair is complete. We replaced the battery and tested the computer this morning. You may collect it at our Green Street shop from Tuesday through Friday, between 10 a.m. and 6 p.m. We are closed on Mondays.

Please bring your repair receipt and a photo ID. The total repair charge is $85. Since you paid a $20 deposit when you left the laptop, the remaining balance is $65. We accept cash and credit cards.

If you cannot visit this week, reply to this email. We can keep the laptop for one additional week at no extra charge.

Best regards,
Jon Kim`,
`미나 박 고객님께,

노트북 수리를 완료했습니다. 배터리를 교체하고 오늘 아침 컴퓨터를 점검했습니다. 화요일부터 금요일까지 오전 10시~오후 6시에 그린 스트리트 매장에서 찾아가실 수 있습니다. 월요일에는 문을 닫습니다.

수리 접수증과 사진이 있는 신분증을 가져오세요. 총 수리비는 85달러입니다. 접수할 때 보증금 20달러를 냈으므로 남은 금액은 65달러입니다. 현금과 신용카드를 받습니다.

이번 주 방문이 어려우면 이메일에 답해 주세요. 추가 비용 없이 한 주 더 보관할 수 있습니다.

존 김 드림`)],questions:[
question('reading-purpose','Why was this email sent?','이 이메일을 보낸 목적은 무엇인가요?','제목 Repair completed와 첫 문장 Your laptop repair is complete가 핵심이에요. 수리가 끝난 기기를 찾아가라고 알리는 이메일이에요.',['To explain how to collect a repaired laptop|수리 완료, 수령 시간, 준비물과 비용을 안내하고 있어요.','To advertise a new laptop model|새 모델을 판매하는 광고는 없어요.','To ask the customer to approve a repair estimate|이미 수리가 끝났으므로 견적 승인을 요청하는 단계가 아니에요.','To announce that the shop is moving|매장 이전에 대한 내용은 없어요.']),
question('reading-detail','How much does Ms. Park still need to pay?','박 고객님이 추가로 내야 할 금액은 얼마인가요?','총액 85달러에서 이미 낸 20달러를 빼면 65달러예요. 본문에도 remaining balance is $65라고 명시돼요.',['$65|아직 내야 하는 잔액이에요.','$85|이미 낸 금액을 빼기 전 전체 수리비예요.','$20|이미 낸 보증금이에요.','$105|전체 수리비에 보증금을 더하면 안 돼요.']),
question('reading-detail','What should Ms. Park do if she cannot visit this week?','이번 주에 방문할 수 없다면 무엇을 해야 하나요?','마지막 문장의 reply to this email이 직접적인 근거예요. 다음 주 보관을 원하면 이메일로 답해야 해요.',['Reply to the email|추가 보관을 위해 안내된 연락 방법이에요.','Visit the shop on Monday|매장은 월요일에 닫는다고 했어요.','Pay another $20 deposit|추가 보증금을 내라는 안내는 없어요.','Ask the shop to send the laptop by mail|우편 배송을 요청하라는 내용은 없어요.'])]},
{code:'p7-parking-notice',kind:'PART7',title:'주차장 공사 안내',difficulty:1,directions:p7directions,
 passages:[passage('Parking Area Maintenance','NOTICE',`Notice to Riverside Office Employees

The east parking area will be closed for surface repairs on Thursday, June 11, from 7 a.m. until 5 p.m. Please remove your car from that area by 6 p.m. on Wednesday.

Employees may use the west parking area during the repairs. If it becomes full, free parking is also available at River Mall, a five-minute walk from the office. Show your employee badge to the mall parking attendant to receive a free parking ticket.

Delivery drivers should continue to use the loading entrance on Oak Street. The repairs will not affect this entrance. If heavy rain is expected, the repairs will be moved to the following Thursday. Any change will be announced by email on Wednesday afternoon.`,
`리버사이드 사무실 직원 안내

동쪽 주차장은 6월 11일 목요일 오전 7시~오후 5시에 바닥 보수로 폐쇄됩니다. 수요일 오후 6시까지 차량을 빼 주세요.

공사 중에는 서쪽 주차장을 사용할 수 있습니다. 서쪽이 가득 차면 사무실에서 걸어서 5분 거리의 리버 몰에서도 무료 주차할 수 있습니다. 몰 주차 안내원에게 직원증을 보여 무료 주차권을 받으세요.

배송 기사는 계속 오크 스트리트의 하역장 입구를 이용하면 됩니다. 그 입구에는 공사 영향이 없습니다. 폭우가 예상되면 공사는 다음 목요일로 미룹니다. 변경 사항은 수요일 오후 이메일로 알립니다.`)],questions:[
question('reading-detail','When should employees remove their cars from the east parking area?','직원들은 언제까지 동쪽 주차장에서 차를 빼야 하나요?','공사 시작 시각과 차량 이동 마감은 달라요. remove your car ... by 6 p.m. on Wednesday가 근거예요.',['By 6 p.m. on Wednesday|차량 이동 마감 시각이에요.','By 7 a.m. on Thursday|공사 시작 시각이며 차량 이동 마감은 그 전날이에요.','By 5 p.m. on Thursday|공사가 끝날 예정인 시각이에요.','By 6 p.m. on Friday|금요일 이동은 안내되지 않았어요.']),
question('reading-detail','What is required for free parking at River Mall?','리버 몰에서 무료 주차하려면 무엇이 필요한가요?','Show your employee badge ... to receive a free parking ticket가 직접적인 근거예요.',['An employee badge|직원임을 확인할 직원증을 보여야 해요.','A store purchase receipt|무료 주차 조건으로 안내된 것은 구매 영수증이 아니라 직원증이에요.','An online reservation|온라인 예약은 언급되지 않았어요.','A delivery permit|배송 허가증은 무료 주차 조건이 아니에요.']),
question('reading-inference','What could cause the repair date to change?','어떤 상황에서 공사 날짜가 바뀔 수 있나요?','If heavy rain is expected, the repairs will be moved가 근거예요. 날씨 조건 때문에 날짜가 바뀔 수 있어요.',['A forecast of heavy rain|폭우가 예상되면 다음 목요일로 미뤄요.','The west parking area becoming full|서쪽 주차장이 차면 몰 주차장을 사용하도록 했어요.','A late delivery on Oak Street|배송 지연 때문에 공사 일정을 바꾼다는 내용은 없어요.','A request from River Mall|몰의 요청이 변경 조건이라고 하지 않았어요.'])]},
{code:'p7-meeting-chat',kind:'PART7',title:'회의실 변경 메신저 대화',difficulty:1,directions:p7directions,
 passages:[passage('Project Team Chat','CHAT',`9:10 a.m. — Jo: The planning meeting is still at 10 a.m., but Room 3 is being used for an interview. Could we move to Room 5?
9:11 a.m. — Amir: Room 5 is available. It does not have a projector, though.
9:12 a.m. — Jo: That is fine. Can you bring the portable projector from the IT desk? I will update the calendar invitation with the new room number.
9:13 a.m. — Amir: I will take care of it. I can pick it up at 9:40.
9:14 a.m. — Jo: Thanks. I will bring printed copies of the sales report for everyone. Please ask Lena to bring her budget notes.
9:15 a.m. — Amir: I have just sent her a message. She will be there on time.`,
`오전 9:10 조: 기획 회의는 그대로 오전 10시인데, 3호실은 면접에 쓰이고 있어요. 5호실로 옮길까요?
오전 9:11 아미르: 5호실은 비어 있어요. 다만 프로젝터가 없어요.
오전 9:12 조: 괜찮아요. IT 데스크에서 이동식 프로젝터를 가져올 수 있나요? 저는 일정 초대장의 회의실 번호를 고칠게요.
오전 9:13 아미르: 제가 처리할게요. 9시 40분에 가져올 수 있어요.
오전 9:14 조: 고마워요. 저는 모두에게 줄 판매 보고서 인쇄본을 가져갈게요. 레나에게 예산 메모를 가져오라고 부탁해 주세요.
오전 9:15 아미르: 방금 메시지를 보냈어요. 제시간에 올 거예요.`)],questions:[
question('reading-detail','Where will the planning meeting take place?','기획 회의는 어디에서 열리나요?','Room 3은 면접에 쓰이고, Room 5로 옮기기로 했어요. IT desk는 장비를 가져오는 장소예요.',['In Room 5|변경한 회의실이에요.','In Room 3|원래 장소이며 면접 때문에 사용할 수 없어요.','At the IT desk|프로젝터를 수령할 장소이지 회의 장소가 아니에요.','In Lena’s office|레나의 사무실에서 한다는 내용은 없어요.']),
question('reading-intention','At 9:13 a.m., what does Amir mean by “I will take care of it”?','오전 9시 13분의 “제가 처리할게요”는 무엇을 뜻하나요?','직전 조의 부탁은 이동식 프로젝터를 가져오는 것이에요. 바로 뒤의 pick it up도 그 장비를 가리켜요.',['He will collect the portable projector.|프로젝터를 가져오겠다는 뜻이에요.','He will conduct the interview.|면접을 진행하겠다는 부탁은 없었어요.','He will print the sales reports.|보고서 인쇄본은 조가 가져오기로 했어요.','He will change the meeting time.|회의 시각은 오전 10시로 유지돼요.']),
question('reading-detail','What has Jo asked Lena to bring?','조는 레나에게 무엇을 가져오라고 부탁했나요?','9:14의 Please ask Lena to bring her budget notes가 근거예요. 부탁을 전달하는 사람과 물건을 가져올 사람을 구분해요.',['Her budget notes|레나가 가져와야 할 자료예요.','The portable projector|아미르가 가져와요.','Printed copies of the sales report|조가 가져와요.','A revised calendar invitation|초대장은 조가 수정하며 레나가 가져오는 물건이 아니에요.'])]},
{code:'p7-cafe-article',kind:'PART7',title:'카페 확장 소식과 문장 삽입',difficulty:1,directions:p7directions,
 passages:[passage('Harbor Café Expands','ARTICLE',`Harbor Café will open a second location near Central Station next month. The original shop on Pine Street will remain open. [1]

The new location has a larger kitchen and more seats than the original shop. [2] The extra space will be used for cooking classes on Saturday mornings. [3] She will teach participants how to prepare two simple dishes. Each class will be limited to eight people.

The first class will take place on November 14. Reservations open on the café website on November 1. [4] Regular coffee service will continue during the classes, but customers who only want coffee should use the seating area near the front window.`,
`하버 카페가 다음 달 센트럴 역 근처에 두 번째 매장을 엽니다. 파인 스트리트의 기존 매장도 계속 영업합니다.

새 매장은 기존 매장보다 주방이 크고 좌석이 많습니다. 추가 공간에서는 토요일 아침 요리 수업을 엽니다. 지역 요리사 미아 첸이 이 수업들을 이끕니다. 그녀는 간단한 요리 두 가지 만드는 법을 가르칩니다. 수업은 매회 8명으로 제한됩니다.

첫 수업은 11월 14일이며, 예약은 11월 1일 카페 웹사이트에서 시작합니다. 수업 중에도 일반 커피 영업은 계속되지만, 커피만 마시는 고객은 앞 창문 근처 좌석을 이용해야 합니다.`)],questions:[
question('reading-purpose','What is the article mainly about?','기사의 주요 내용은 무엇인가요?','새 매장 개점과 그곳에서 제공할 요리 수업을 소개해요. 기존 매장 폐점이나 바리스타 채용 이야기가 아니에요.',['A café’s new location and cooking classes|기사의 개점·공간 활용 안내를 함께 요약해요.','The closing of the Pine Street shop|기존 매장은 계속 영업한다고 했어요.','A competition for professional cooks|요리 대회가 아니라 고객 대상 수업이에요.','A change in Central Station’s train schedule|역은 위치 설명일 뿐 기차 시간표 이야기는 없어요.']),
question('reading-detail','How many people can attend each cooking class?','요리 수업 한 회에 몇 명까지 참석할 수 있나요?','Each class will be limited to eight people가 정확한 근거예요. 날짜 14와 예약일 1을 인원으로 혼동하지 마세요.',['Eight|매회 참석 제한 인원이에요.','Two|배울 간단한 요리의 수예요.','Fourteen|첫 수업 날짜의 숫자예요.','One|예약 시작 날짜의 숫자예요.']),
question('reading-insertion','Where should this sentence be inserted? “Local chef Mia Chen will lead these classes.”','“지역 요리사 미아 첸이 이 수업들을 이끕니다.”를 어느 위치에 넣어야 하나요?','these classes는 앞에서 소개한 요리 수업을 받고, 다음 문장의 She가 미아 첸을 받아야 해요. 두 연결 조건을 모두 만족하는 위치는 [3]이에요.',['[3]|앞의 cooking classes와 뒤의 She 사이를 연결해요.','[1]|아직 수업이 소개되지 않아 these classes가 가리킬 대상이 없어요.','[2]|요리 수업이 소개되기 전이고, 바로 뒤 문장과 She의 연결도 늦어져요.','[4]|그 전에 나온 She가 누구인지 설명하지 못한 채 읽게 돼요.'])]},
{code:'p7-workshop-schedule',kind:'PART7',title:'주말 직무 교육 시간표',difficulty:1,directions:p7directions,
 passages:[passage('Saturday Skills Workshops','SCHEDULE',`Meadow Community Center — Saturday, May 16

Time          Workshop                Room       Fee
09:00–10:00   Writing Clear Emails    Room A     $10
10:15–11:45   Basic Spreadsheets      Room B     $20
13:00–14:00   Speaking at Meetings    Room A     $15

Register on the center website by May 13. Each workshop is limited to twelve participants. Fees include printed materials but not lunch. A full refund is available for cancellations received by May 14; cancellations after that date cannot be refunded.

Participants in Basic Spreadsheets should bring a laptop. The center will provide computers only to people who request one when registering. The other two workshops do not require a computer.`,
`메도 커뮤니티 센터 — 5월 16일 토요일

오전 9~10시: 명확한 이메일 쓰기 / A호실 / 10달러
오전 10시 15분~11시 45분: 기초 스프레드시트 / B호실 / 20달러
오후 1~2시: 회의에서 말하기 / A호실 / 15달러

5월 13일까지 센터 웹사이트에서 등록하세요. 각 수업은 12명까지입니다. 요금에는 인쇄 자료가 포함되고 점심은 포함되지 않습니다. 5월 14일까지 접수된 취소는 전액 환불되지만 그 후에는 환불되지 않습니다.

스프레드시트 수업 참가자는 노트북을 가져와야 합니다. 센터 컴퓨터는 등록할 때 요청한 사람에게만 제공합니다. 나머지 두 수업에는 컴퓨터가 필요 없습니다.`)],questions:[
question('reading-detail','Which workshop takes place in Room B?','B호실에서 열리는 수업은 무엇인가요?','시간표에서 Room B와 같은 행을 따라가면 Basic Spreadsheets예요. 표는 열과 행을 함께 확인해야 해요.',['Basic Spreadsheets|시간표의 B호실 행에 해당해요.','Writing Clear Emails|A호실에서 열려요.','Speaking at Meetings|오후에 A호실에서 열려요.','Preparing Lunch|이런 수업은 시간표에 없어요.']),
question('reading-detail','What is included in each workshop fee?','각 수업 요금에는 무엇이 포함되나요?','Fees include printed materials but not lunch가 근거예요. include 뒤와 not 뒤를 구분해요.',['Printed materials|인쇄 자료는 요금에 포함돼요.','Lunch|점심은 포함되지 않는다고 명시했어요.','A new laptop|새 노트북을 제공한다는 내용은 없어요.','A year of center membership|연간 회원권은 언급되지 않았어요.']),
question('reading-inference','What should a person do to use a center computer in Basic Spreadsheets?','스프레드시트 수업에서 센터 컴퓨터를 쓰려면 무엇을 해야 하나요?','컴퓨터는 등록 시 요청한 사람에게만 제공해요. 단순히 수업에 나타나는 것만으로 보장되지 않아요.',['Request one during registration|등록할 때 컴퓨터 사용을 요청해야 해요.','Cancel the workshop by May 14|5월 14일은 환불 가능한 취소 마감이에요.','Arrive at Room A at 1 p.m.|다른 수업의 장소와 시각이에요.','Pay an additional $15 for lunch|추가 컴퓨터 비용이나 점심 구매 조건은 없어요.'])]},
{code:'p7-class-ad-email',kind:'PART7',title:'영어 강좌 광고와 수강 신청 이메일',difficulty:2,directions:p7directions,
 passages:[passage('Bright Learning Center Courses','ADVERTISEMENT',`Evening English Courses — New Term Begins September 8

Course                    Day       Time           Monthly Fee
Everyday Conversation     Monday    18:00–19:00    $60
Workplace Writing         Tuesday   19:00–20:30    $80
Presentation Skills       Thursday  18:30–20:00    $90

All courses meet once a week. Register by August 25 to receive a $10 discount on your first month. Course materials are included. Classes are held at 18 Garden Road, a three-minute walk from North Station.

Apply through our website. Send any questions to courses@bright.example.`,
`브라이트 학습 센터 저녁 영어 강좌 — 새 학기는 9월 8일 시작

일상 회화: 월요일 오후 6~7시 / 월 60달러
직장 글쓰기: 화요일 오후 7~8시 30분 / 월 80달러
발표 기술: 목요일 오후 6시 30분~8시 / 월 90달러

모든 강좌는 주 1회입니다. 8월 25일까지 등록하면 첫 달에 10달러 할인됩니다. 교재비는 포함됩니다. 수업은 노스 역에서 도보 3분인 가든 로드 18번지에서 합니다. 웹사이트에서 신청하세요.`),
 passage('Course Question from Yuna Kim','EMAIL',`To: courses@bright.example
From: Yuna Kim
Date: August 20
Subject: Tuesday course

Hello,

I would like to join the course about writing messages and reports at work. I finish work at 6 p.m. on Tuesdays, so the advertised starting time is convenient. I submitted the online registration form today.

Could you confirm the fee for my first month? I also want to know whether I need to buy a textbook before the first lesson. I usually take the train to North Station, so your location is convenient for me.

Thank you,
Yuna Kim`,
`수신: 센터 강좌 담당 / 발신: 유나 김 / 8월 20일 / 제목: 화요일 강좌

직장에서 메시지와 보고서를 쓰는 강좌를 듣고 싶습니다. 화요일 오후 6시에 퇴근하므로 광고의 시작 시각이 편리합니다. 오늘 온라인 등록서를 제출했습니다.

첫 달 요금을 확인해 주실 수 있나요? 첫 수업 전에 교재를 사야 하는지도 알고 싶습니다. 평소 노스 역까지 기차를 타므로 위치도 편리합니다.`)],questions:[
question('reading-cross-document','Which course is Ms. Kim interested in?','김 씨가 관심 있는 강좌는 무엇인가요?','이메일의 writing messages and reports at work를 광고의 강좌 이름과 연결하면 Workplace Writing이에요. 화요일이라는 단서도 일치해요.',['Workplace Writing|직장 글쓰기이며 화요일 강좌라는 두 조건에 맞아요.','Everyday Conversation|월요일 회화 강좌라 이메일의 내용·요일과 달라요.','Presentation Skills|목요일 발표 강좌예요.','Train Travel English|광고에 없는 강좌예요.']),
question('reading-cross-document','How much should Ms. Kim pay for her first month?','김 씨의 첫 달 요금은 얼마인가요?','직장 글쓰기 월 80달러에서 8월 25일 이전 등록 할인 10달러를 빼요. 이메일은 8월 20일에 등록했다고 했으므로 70달러예요.',['$70|80달러에서 조기 등록 할인 10달러를 뺀 금액이에요.','$80|할인 전 직장 글쓰기 요금이에요.','$60|일상 회화의 할인 전 월 요금이에요.','$90|발표 기술의 할인 전 월 요금이에요.']),
question('reading-detail','What does the advertisement say about course materials?','광고는 교재에 관해 무엇이라고 하나요?','Course materials are included가 근거예요. 이메일의 교재 구매 질문에 광고에서 답을 찾을 수 있어요.',['They are included in the course fee.|교재가 수강료에 포함돼요.','They must be purchased at North Station.|역에서 사라는 안내는 없어요.','They cost an additional $10.|10달러는 조기 등록 할인 금액이에요.','They are available only for the Thursday course.|교재 포함 조건을 특정 강좌로 제한하지 않았어요.']),
question('reading-cross-document','When will Ms. Kim’s chosen class begin each week?','김 씨가 선택한 수업은 매주 몇 시에 시작하나요?','이메일의 선택 강좌를 Workplace Writing으로 찾은 뒤 광고의 해당 행에서 시작 시각 19:00을 읽어요.',['At 7 p.m.|화요일 직장 글쓰기의 시작 시각이에요.','At 6 p.m.|회화 강좌 시작 시각이며 김 씨의 퇴근 시각이기도 해요.','At 6:30 p.m.|목요일 발표 강좌의 시작 시각이에요.','At 8:30 p.m.|화요일 수업이 끝나는 시각이에요.']),
question('reading-inference','Why does Ms. Kim find the center’s location convenient?','김 씨가 센터 위치를 편리하게 여기는 이유는 무엇인가요?','광고에는 노스 역 도보 3분이라고 하고, 이메일에는 그 역까지 기차를 탄다고 했어요. 두 문서의 장소 정보를 합쳐요.',['It is close to the station she uses.|이용하는 노스 역과 가까워요.','It is in the building where she works.|그녀의 직장 건물이라는 내용은 없어요.','It offers free parking for all students.|무료 주차는 언급되지 않았어요.','It is next to a bookstore she owns.|서점이나 소유에 관한 내용은 없어요.'])]},
{code:'p7-supply-order',kind:'PART7',title:'문구 주문서와 품절 안내 이메일',difficulty:2,directions:p7directions,
 passages:[passage('Office Supply Order 731','ORDER',`Northline Supplies — Order 731
Customer: Oak Design Studio
Requested delivery date: March 12

Item                 Quantity   Unit Price   Total
A4 paper box         2          $15          $30
Blue pen pack        3          $6           $18
Desk organizer       1          $12          $12

Items subtotal: $60
Delivery fee: $5
Total before any changes: $65

Please use the studio’s side entrance for deliveries. The main entrance is for visitors.`,
`노스라인 사무용품 — 주문 731 / 고객: 오크 디자인 스튜디오 / 요청 배송일: 3월 12일

A4 용지 상자: 2개 × 15달러 = 30달러
파란 펜 묶음: 3개 × 6달러 = 18달러
책상 정리함: 1개 × 12달러 = 12달러

상품 합계 60달러, 배송료 5달러, 변경 전 총액 65달러. 배송은 스튜디오 옆문을 사용하고, 정문은 방문객용입니다.`),
 passage('Change to Order 731','EMAIL',`To: Oak Design Studio
From: Northline Supplies
Date: March 9
Subject: Order 731 update

Thank you for your order. The desk organizer is currently out of stock and will not be available until March 20. As requested in your call this morning, we have removed that item from your order. The paper and pen packs will still arrive on March 12.

We will also waive the $5 delivery fee because of this inconvenience. Your final bill will reflect both changes. You do not need to submit a new order. The driver has received your instructions about which entrance to use.`,
`오크 디자인 스튜디오 귀하 / 노스라인 사무용품 / 3월 9일 / 주문 731 변경

책상 정리함은 현재 품절이고 3월 20일에야 입고됩니다. 오늘 아침 통화에서 요청하신 대로 주문에서 그 품목을 제외했습니다. 용지와 펜은 예정대로 3월 12일 도착합니다.

불편을 드려 5달러 배송료도 면제합니다. 최종 청구서에 두 변경을 모두 반영합니다. 새로 주문할 필요는 없습니다. 운전기사에게 사용할 출입구 지시도 전달했습니다.`)],questions:[
question('reading-detail','Why was an item removed from the order?','주문에서 한 품목을 제외한 이유는 무엇인가요?','이메일의 desk organizer is currently out of stock가 근거예요. 제품 파손이나 고객 주소 문제 때문이 아니에요.',['It was not available in stock.|책상 정리함이 품절이었어요.','It was damaged during delivery.|아직 배송 전이며 파손 사고는 없어요.','The customer changed its address.|주소 변경은 언급되지 않았어요.','The unit price was printed incorrectly.|가격 오기는 안내되지 않았어요.']),
question('reading-cross-document','What will be the final amount charged?','최종 청구 금액은 얼마인가요?','변경 전 총액 65달러에서 정리함 12달러와 면제 배송료 5달러를 모두 빼면 48달러예요. 또는 용지 30달러+펜 18달러로 확인해요.',['$48|배송되는 두 상품의 합계이며 배송료도 면제돼요.','$53|정리함만 빼고 배송료 면제를 반영하지 않은 금액이에요.','$60|상품 소계이며 품절 제외와 배송료 면제를 반영한 최종 금액이 아니에요.','$65|변경 전 총액이에요.']),
question('reading-cross-document','Which entrance should the driver use?','운전기사는 어느 입구를 사용해야 하나요?','이메일은 주문서의 출입구 지시를 전달했다고 해요. 주문서에는 side entrance라고 명시돼 있어요.',['The studio’s side entrance|배송용으로 지정된 옆문이에요.','The main visitor entrance|정문은 방문객용이라고 했어요.','The loading entrance of Northline’s warehouse|공급업체 창고 입구는 고객 수령 장소가 아니에요.','Any entrance at the driver’s choice|특정 출입구 지시가 있어요.']),
question('reading-cross-document','When will the remaining items arrive?','남은 상품은 언제 도착하나요?','주문서 요청일 March 12와 이메일 still arrive on March 12가 일치해요. 품절 정리함 입고일 March 20과 구분해요.',['March 12|용지와 펜의 배송일은 유지돼요.','March 9|변경 안내 이메일 날짜예요.','March 20|제외된 정리함의 입고 가능 날짜예요.','March 5|문서에 나오지 않은 날짜예요.']),
question('reading-detail','What does the customer need to do about the revised order?','변경된 주문과 관련해 고객이 해야 할 일은 무엇인가요?','You do not need to submit a new order가 근거예요. 공급업체가 기존 주문을 수정했으므로 다시 주문할 필요가 없어요.',['Keep the existing order without submitting a new one|공급업체가 기존 주문과 청구서를 변경했어요.','Place a new order for all items|새 주문이 필요 없다고 명시했어요.','Pay the delivery fee in cash|배송료는 면제됐어요.','Pick up all items from the warehouse|남은 상품은 예정대로 배송돼요.'])]},
{code:'p7-event-delivery',kind:'PART7',title:'행사 상품 안내·주문·배송 변경 확인',difficulty:2,directions:p7directions,
 passages:[passage('Conference Welcome Packs','ADVERTISEMENT',`Summit Print — Welcome Packs for Your Event

Each welcome pack contains one notebook, one pen, and one name badge. The price is $8 per pack for orders of fewer than 50 packs, or $7 per pack for orders of 50 or more. Delivery is free for orders of 50 or more packs.

Order at least seven days before your event. We can print your organization’s logo on the notebook cover at no additional cost. Email your logo file when placing the order. Delivery is normally made to the address on your order form.`,
`서밋 프린트 — 행사 환영 꾸러미

꾸러미마다 공책 1권, 펜 1개, 이름표 1개가 있습니다. 50개 미만 주문은 개당 8달러, 50개 이상은 개당 7달러입니다. 50개 이상은 배송도 무료입니다.

행사 최소 7일 전에 주문하세요. 단체 로고를 공책 표지에 추가 비용 없이 인쇄할 수 있습니다. 주문할 때 로고 파일을 이메일로 보내세요. 일반적으로 주문서의 주소로 배송합니다.`),
 passage('Order 960 from Elm Training','ORDER',`Order number: 960
Customer: Elm Training
Order date: October 2
Event date: October 12
Quantity: 60 welcome packs
Logo printing: Requested; logo file attached
Requested delivery date: October 9
Original delivery address: Elm Training, 25 Park Lane

Contact: Nari Song
Please deliver between 10 a.m. and noon. Our event team will check all packs before the conference.`,
`주문 960 / 고객: 엘름 트레이닝 / 주문일: 10월 2일 / 행사일: 10월 12일
환영 꾸러미 60개 / 로고 인쇄 요청, 파일 첨부 / 요청 배송일: 10월 9일
원래 배송지: 파크 레인 25번지 엘름 트레이닝 / 담당: 나리 송
오전 10시~정오에 배송해 주세요. 행사팀이 회의 전에 모든 꾸러미를 확인할 예정입니다.`),
 passage('Delivery Confirmation for Order 960','EMAIL',`To: Nari Song
From: Summit Print Delivery Team
Date: October 6
Subject: Updated delivery details — Order 960

We received your request to change the delivery address. Your 60 welcome packs will now be sent directly to the conference venue, Brook Hotel, 8 River Road, rather than your office. The date and time remain October 9, between 10 a.m. and noon.

Your logo has been printed on all notebook covers. Please ask a member of your team to meet the driver at the hotel’s service entrance. There is no change to the price or delivery charge.`,
`나리 송 귀하 / 서밋 프린트 배송팀 / 10월 6일 / 주문 960 배송 변경 확인

배송지 변경 요청을 받았습니다. 꾸러미 60개는 사무실 대신 행사장인 리버 로드 8번지 브룩 호텔로 직접 보냅니다. 날짜와 시간은 10월 9일 오전 10시~정오로 유지됩니다.

모든 공책 표지에 로고를 인쇄했습니다. 호텔 서비스 출입구에서 팀원 한 명이 기사를 맞아 주세요. 가격과 배송료에는 변동이 없습니다.`)],questions:[
question('reading-cross-document','What is the total product cost for Order 960?','주문 960의 상품 총액은 얼마인가요?','주문서는 60개예요. 광고의 50개 이상 단가 7달러를 적용하면 60×7=420달러예요. 로고 추가비와 배송료도 없어요.',['$420|60개에 개당 7달러를 적용한 금액이에요.','$480|50개 미만 단가 8달러를 잘못 적용한 금액이에요.','$350|실제 수량 60개 대신 기준 수량 50개를 쓴 금액이에요.','$428|추가 8달러를 붙일 근거가 없어요.']),
question('reading-cross-document','Where will the packs actually be delivered?','꾸러미는 최종적으로 어디로 배송되나요?','주문서의 원래 주소보다 나중 이메일의 변경 확인이 우선이에요. Brook Hotel, 8 River Road로 바뀌었어요.',['Brook Hotel, 8 River Road|최종 이메일에서 확인한 새 배송지예요.','Elm Training, 25 Park Lane|주문서의 원래 사무실 주소로, 이후 변경됐어요.','Summit Print’s main shop|물품을 만드는 업체이며 최종 배송지가 아니에요.','North Station|세 문서 어디에도 최종 배송지로 나오지 않아요.']),
question('reading-detail','What should the customer arrange at the delivery location?','고객은 배송지에서 무엇을 준비해야 하나요?','마지막 이메일의 meet the driver at the hotel’s service entrance가 근거예요. 사무실이나 호텔 정문이 아니라 서비스 출입구예요.',['A team member to meet the driver at the service entrance|직원이 호텔 서비스 출입구에서 기사를 맞아야 해요.','An extra payment for the logo printing|로고 인쇄는 광고에서 무료라고 했어요.','A new logo file for every notebook|하나의 로고 파일로 이미 모든 공책에 인쇄했어요.','Someone to collect the packs on October 12|10월 12일은 행사일이며 배송일은 9일이에요.']),
question('reading-cross-document','Did Elm Training order early enough to meet the advertised requirement?','엘름 트레이닝은 광고의 사전 주문 조건을 충족했나요?','광고는 행사 최소 7일 전에 주문하라고 해요. 주문일 10월 2일과 행사일 10월 12일은 10일 차이이므로 충족해요.',['Yes, the order was placed ten days before the event.|최소 7일보다 앞선 주문이에요.','No, the order was placed only three days before the event.|3일은 배송일과 행사일 차이이며 주문일 기준이 아니에요.','No, orders must be placed at least a month in advance.|광고의 조건은 한 달이 아니라 최소 7일이에요.','It cannot be determined because the event date is missing.|주문서에 행사일 10월 12일이 나와 있어요.']),
question('reading-cross-document','Which service was requested and completed without an extra fee?','추가 요금 없이 요청하고 완료한 서비스는 무엇인가요?','광고의 무료 로고 인쇄, 주문서의 인쇄 요청, 이메일의 인쇄 완료를 세 문서에서 차례로 연결해야 해요.',['Printing the organization’s logo on notebooks|무료 제공 조건·요청·완료가 모두 확인돼요.','Adding a second notebook to every pack|구성은 공책 한 권이며 두 번째 공책 추가는 없어요.','Preparing lunch for the conference|식사는 어떤 문서에도 포함되지 않았어요.','Printing the logo on the hotel’s entrance sign|인쇄 대상은 공책 표지이며 호텔 표지판이 아니에요.'])]},
];

export {question,passage,p7directions};
