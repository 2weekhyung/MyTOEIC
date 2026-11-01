-- Original MyTOEIC educational content. Insert-only and repeat-safe.
-- Never DELETE, TRUNCATE or UPDATE user learning data.
INSERT INTO grammar_lesson (code,title,level,sort_order,estimated_minutes,revision,objective,content,easier_explanation,summary,created_at,updated_at,version)
SELECT 'structure','영어 문장의 기본 구조',0,1,10,1,'단어를 뜻으로 묶고 누가 무엇을 하는지 찾습니다.','단어는 뜻을 가진 작은 조각이에요. I는 ''나'', work는 ''일하다''라는 뜻이에요. 단어들을 약속된 순서로 놓아 생각을 전하면 문장이 돼요. I work.는 ''나는 일한다''예요. 끝의 마침표는 말이 끝났다는 표시예요.
한국어는 ''나는 사과를 먹는다''라고 말하지만 영어는 I eat an apple.처럼 ''누가 → 한다 → 무엇을'' 순서로 말해요. 단어를 한국어 순서대로 옮기기보다 영어 순서에 익숙해져 보세요.
누가 하는지 나타내는 부분을 주어, 행동이나 상태를 나타내는 부분을 동사라고 불러요. I work.에서 I는 주어, work는 동사예요. an apple처럼 행동의 대상을 나타내는 부분은 목적어예요.
모든 문장에 목적어가 필요한 것은 아니에요. Birds fly.는 ''새들이 난다''라는 완전한 문장이에요. ''무엇을'' 날아가는 것이 아니므로 목적어가 없어요. 이번에는 주어와 동사부터 찾으면 충분해요.','영어 문장은 작은 기차예요. 맨 앞에서 누가 하는지 알려 주고, 그다음에 행동을 말해요. I(나는) → work(일한다). 필요하면 뒤에 무엇을 하는지도 붙여요.','영어의 기본 순서: 주어 → 동사 → 필요한 나머지. 주어는 누가/무엇이, 동사는 행동/상태입니다.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_lesson WHERE code='structure');
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='structure'),1,'I work.','나는 일한다.','I: 주어 / work: 동사','누가? 나는. 무엇을 하나요? 일해요. 목적어 없이도 뜻이 완성돼요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='structure') AND sequence_no=1);
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='structure'),2,'She reads a book.','그녀는 책을 읽는다.','She: 주어 / reads: 동사 / a book: 목적어','영어에서는 읽는 행동을 먼저 말하고 그 뒤에 읽는 대상을 말해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='structure') AND sequence_no=2);
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='structure'),3,'Birds fly.','새들이 난다.','Birds: 주어 / fly: 동사','주어는 사람뿐 아니라 동물이나 사물도 될 수 있어요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='structure') AND sequence_no=3);
INSERT INTO grammar_lesson (code,title,level,sort_order,estimated_minutes,revision,objective,content,easier_explanation,summary,created_at,updated_at,version)
SELECT 'subject-verb','주어와 동사',0,2,10,1,'행동의 주인공과 행동·상태를 구분합니다.','문장을 읽을 때 먼저 ''누가?'' 또는 ''무엇이?''라고 물어보세요. 그 답이 주어예요. Mina works.에서 일하는 사람은 Mina이므로 Mina가 주어예요. 주어가 꼭 사람 한 명일 필요는 없어요. The computers work.에서는 컴퓨터들이 주어예요.
다음에는 ''무엇을 하나요?'' 또는 ''어떤 상태인가요?''라고 물어보세요. 그 답을 나타내는 말이 동사예요. works는 일한다는 행동을, is는 어떤 상태인지를 연결해 줘요.
영어의 평범한 설명문에서는 주어 다음에 동사가 와요. She smiles.는 ''그녀는 웃는다''예요. smiles가 바로 행동이에요. She is happy.에서는 is가 동사이고 happy는 행복한 상태를 설명하는 말이에요. happy 자체는 동사가 아니에요.
명령하는 문장에는 주어가 겉으로 보이지 않을 수도 있지만, 지금은 주어가 있는 설명문부터 연습해요. 뜻을 먼저 읽고 주어와 동사에 하나씩 밑줄을 그어 보세요.','Mina works.를 두 조각으로 나눠요. Mina는 일하는 사람, works는 하는 일이에요. 사람 이름만 찾지 말고 무엇이 움직이거나 어떤 상태인지도 보세요.','주어는 행동·상태의 주인공입니다. 동사는 행동이나 상태를 나타냅니다. 형용사를 동사로 착각하지 마세요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_lesson WHERE code='subject-verb');
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='subject-verb'),1,'Mina works.','미나는 일한다.','Mina: 주어 / works: 동사','누가 일하나요? 미나예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='subject-verb') AND sequence_no=1);
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='subject-verb'),2,'The bus arrives.','버스가 도착한다.','The bus: 주어 / arrives: 동사','도착하는 것은 버스예요. the도 bus와 함께 주어에 들어가요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='subject-verb') AND sequence_no=2);
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='subject-verb'),3,'She is happy.','그녀는 행복하다.','She: 주어 / is: 동사 / happy: 보어','영어에서는 행복한 상태를 말할 때 is가 필요해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='subject-verb') AND sequence_no=3);
INSERT INTO grammar_lesson (code,title,level,sort_order,estimated_minutes,revision,objective,content,easier_explanation,summary,created_at,updated_at,version)
SELECT 'nouns','명사와 대명사',0,3,10,1,'이름을 나타내는 말과 이름을 대신하는 말을 배웁니다.','사람, 사물, 장소, 생각의 이름을 나타내는 말을 명사라고 불러요. teacher(선생님), desk(책상), office(사무실), time(시간)이 모두 명사예요. 손으로 잡을 수 없는 생각도 이름이 있으면 명사가 될 수 있어요.
같은 이름을 계속 말하면 길고 어색해요. Mina is a teacher. Mina works here.에서 두 번째 Mina 대신 She를 쓸 수 있어요. 이렇게 이름을 대신하는 말이 대명사예요. I(나), you(너/당신), he(그), she(그녀), it(그것), we(우리), they(그들/그것들)를 먼저 익혀요.
대명사의 모양은 문장 속 역할에 따라 바뀔 수 있어요. I like her.에서 I는 좋아하는 사람이고 her는 좋아하는 대상이에요. 이번에는 주어 자리에 I, she, they 같은 형태가 온다는 것을 기억해요.
명사와 대명사는 모두 주어가 될 수 있어요. The desk is new.에서 책상이 주어이고, It is new.에서는 It이 그 책상을 대신해요. it이 무엇을 가리키는지는 앞 문맥에서 확인해요.','명사는 이름표예요. Mina, desk가 이름표라면 she, it은 그 이름표 대신 쓰는 짧은 말이에요. 사람 이름만 명사인 것은 아니에요.','명사: 사람·사물·장소·생각의 이름. 대명사: 그 이름을 대신하는 말. 주어 자리의 I와 대상 자리의 me는 모양이 다릅니다.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_lesson WHERE code='nouns');
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='nouns'),1,'Mina is a teacher.','미나는 선생님이다.','Mina: 주어인 명사 / is: 동사 / a teacher: 보어인 명사구','teacher는 직업의 이름이라 명사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='nouns') AND sequence_no=1);
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='nouns'),2,'She works here.','그녀는 여기서 일한다.','She: 주어인 대명사 / works: 동사 / here: 장소 설명','She는 앞에서 말한 미나를 대신할 수 있어요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='nouns') AND sequence_no=2);
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='nouns'),3,'The desk is new.','그 책상은 새것이다.','The desk: 주어인 명사구 / is: 동사 / new: 보어','desk는 물건의 이름이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='nouns') AND sequence_no=3);
INSERT INTO grammar_lesson (code,title,level,sort_order,estimated_minutes,revision,objective,content,easier_explanation,summary,created_at,updated_at,version)
SELECT 'objects','목적어와 보어',0,4,10,1,'행동의 대상과 주어의 설명을 구분합니다.','I read a book.에서 ''무엇을 읽나요?''의 답은 a book이에요. 이렇게 행동이 향하는 대상을 목적어라고 해요. 목적어는 ''무엇을?'' 또는 ''누구를?''에 대한 답으로 찾아보면 좋아요.
She is a doctor.를 볼까요? 그녀가 의사를 무언가 하는 것이 아니에요. a doctor는 그녀가 어떤 사람인지 알려 줘요. 이런 설명을 보태 문장을 완성하는 부분이 보어예요. 여기서는 주어를 설명하므로 주격 보어라고 불러요.
She is kind.에서는 kind(친절한)가 주어의 상태를 설명해요. 따라서 보어에는 이름을 나타내는 명사도, 성질을 나타내는 형용사도 올 수 있어요. be동사 뒤의 말이 언제나 목적어인 것은 아니에요.
기초 단계에서는 read, like, need 뒤의 대상과 be동사 뒤의 설명을 비교해 보세요. I need help.의 help는 필요한 대상이고, I am tired.의 tired는 나의 상태예요. 나중에는 목적어를 설명하는 보어도 배우게 돼요.','I read a book.에서는 나와 책이 달라요. 책은 읽는 대상이에요. I am a teacher.에서는 나를 선생님이라고 설명해요. 이 차이를 먼저 느껴 보세요.','목적어: 행동의 대상. 보어: 주어나 목적어가 누구인지, 어떤 상태인지 설명하며 문장을 완성하는 말.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_lesson WHERE code='objects');
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='objects'),1,'I read a book.','나는 책을 읽는다.','I: 주어 / read: 동사 / a book: 목적어','책은 읽는 행동의 대상이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='objects') AND sequence_no=1);
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='objects'),2,'She is a doctor.','그녀는 의사이다.','She: 주어 / is: 동사 / a doctor: 주격 보어','의사는 그녀가 누구인지 설명해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='objects') AND sequence_no=2);
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='objects'),3,'He is tired.','그는 피곤하다.','He: 주어 / is: 동사 / tired: 주격 보어','tired는 그가 어떤 상태인지 알려 줘요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='objects') AND sequence_no=3);
INSERT INTO grammar_lesson (code,title,level,sort_order,estimated_minutes,revision,objective,content,easier_explanation,summary,created_at,updated_at,version)
SELECT 'modifiers','형용사와 부사',0,5,10,1,'이름을 꾸미는 말과 행동을 꾸미는 말을 구분합니다.','a new desk는 ''새 책상''이에요. new는 desk가 어떤 책상인지 설명해요. 이처럼 명사의 성질이나 상태를 알려 주는 말을 형용사라고 불러요. 형용사는 명사 앞에 올 수 있고 The desk is new.처럼 be동사 뒤에서 상태를 설명할 수도 있어요.
She works carefully.는 ''그녀는 주의 깊게 일한다''예요. carefully는 어떻게 일하는지 알려 줘요. 이처럼 동사, 형용사, 다른 부사나 문장 전체를 꾸미는 말을 부사라고 해요. 처음에는 동사를 꾸미는 경우부터 익혀요.
careful은 ''주의 깊은'', carefully는 ''주의 깊게''라는 뜻이에요. a careful driver에서는 운전자인 명사를 꾸미므로 careful을 쓰고, drives carefully에서는 운전하는 행동을 꾸미므로 carefully를 써요.
많은 부사가 -ly로 끝나지만 모두 그렇지는 않아요. fast는 ''빠른''이라는 형용사와 ''빠르게''라는 부사로 모두 쓰여요. friendly는 -ly로 끝나도 보통 ''친절한''이라는 형용사예요. 끝 모양만 보지 말고 어떤 말을 설명하는지 확인해요.','책상을 설명하면 어떤 책상? → new. 일하는 모습을 설명하면 어떻게 일해? → carefully. 꾸밈을 받는 말부터 찾으세요.','형용사는 명사를 설명합니다. 부사는 행동·형용사·다른 부사 등을 설명합니다. -ly만으로 품사를 확정하지 않습니다.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_lesson WHERE code='modifiers');
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='modifiers'),1,'This is a new desk.','이것은 새 책상이다.','This: 주어 / is: 동사 / a new desk: 보어 (new가 desk를 꾸밈)','new는 책상의 특징을 말해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='modifiers') AND sequence_no=1);
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='modifiers'),2,'She works carefully.','그녀는 주의 깊게 일한다.','She: 주어 / works: 동사 / carefully: 동사를 꾸미는 부사','어떻게 일하는지 알려 주므로 부사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='modifiers') AND sequence_no=2);
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='modifiers'),3,'The room is very clean.','그 방은 매우 깨끗하다.','The room: 주어 / is: 동사 / very clean: 보어 (very가 clean을 꾸밈)','very는 형용사 clean의 정도를 높이는 부사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='modifiers') AND sequence_no=3);
INSERT INTO grammar_lesson (code,title,level,sort_order,estimated_minutes,revision,objective,content,easier_explanation,summary,created_at,updated_at,version)
SELECT 'be','be동사: am, are, is',1,6,10,1,'주어가 누구인지, 어떤 상태인지 영어로 말합니다.','I am a student.는 ''나는 학생이다''예요. am은 나와 학생이라는 설명을 이어 줘요. am, are, is는 be라는 동사의 현재형이에요. ''~이다''나 ''어떤 상태다''라고 말할 때 자주 써요.
I 뒤에는 am, you/we/they 뒤에는 are, he/she/it이나 한 사람·한 사물 뒤에는 is를 써요. I am ready. You are ready. She is ready.처럼 주어에 맞춰 모양을 바꿔요. 주어에 따라 동사 모양을 맞추는 것을 수일치라고 해요.
be동사 뒤에는 명사뿐 아니라 형용사나 장소 표현도 올 수 있어요. He is kind.는 상태, He is in the office.는 위치를 말해요. 이 강의에서는 상태와 정체성을 먼저 연습해요.
한국어에서는 ''나는 바쁘다''라고 하지만 영어에서는 I busy.라고 하지 않아요. I am busy.처럼 동사가 필요해요. 반대로 ''나는 일한다''는 I work.예요. 행동 동사 앞에 am을 무조건 붙이지 마세요. 진행 중인 행동을 말하는 am working은 나중에 배워요.','I와 am은 짝이에요. you/we/they와 are도 짝이에요. he/she/it과 is도 짝이에요. 나 바쁨이라는 조각 대신 I am busy.라는 문장을 만들어 봐요.','I am / you·we·they are / he·she·it is. 이름·상태를 설명할 때 be동사를 빠뜨리지 않습니다.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_lesson WHERE code='be');
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='be'),1,'I am a student.','나는 학생이다.','I: 주어 / am: be동사 / a student: 보어','I에 맞는 be동사는 am이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='be') AND sequence_no=1);
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='be'),2,'They are busy.','그들은 바쁘다.','They: 주어 / are: be동사 / busy: 보어','여러 사람을 나타내는 They에는 are를 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='be') AND sequence_no=2);
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='be'),3,'The office is clean.','그 사무실은 깨끗하다.','The office: 주어 / is: be동사 / clean: 보어','사무실 한 곳을 말하므로 is를 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='be') AND sequence_no=3);
INSERT INTO grammar_lesson (code,title,level,sort_order,estimated_minutes,revision,objective,content,easier_explanation,summary,created_at,updated_at,version)
SELECT 'verbs','일반동사와 현재의 습관',1,7,10,1,'일상의 행동을 주어에 맞는 동사로 표현합니다.','work(일하다), like(좋아하다), read(읽다)처럼 be 이외의 동사를 여기서는 일반동사라고 불러요. I work here.는 ''나는 여기서 일한다''예요. 일반동사도 주어 바로 다음에 놓아요.
현재의 습관이나 반복되는 일을 말할 때 동사의 현재형을 써요. I work every day.는 매일 일한다는 뜻이에요. 반드시 지금 이 순간 일하는 중이라는 뜻은 아니에요.
주어가 he, she, it 또는 한 사람의 이름처럼 나와 너를 제외한 하나일 때는 현재형 동사에 보통 -s를 붙여요. I work.와 She works.를 비교해요. 이런 주어를 3인칭 단수라고 해요. we와 they처럼 여러 사람일 때는 work예요.
대부분은 -s를 붙이지만 watch는 watches, study는 studies, have는 has가 돼요. 처음부터 모든 철자 규칙을 외우기보다 I study.와 She studies.처럼 문장으로 익혀요. She is works.처럼 be와 일반동사 현재형을 나란히 쓰지 않아요.','내가 하는 일은 I work. 그녀가 늘 하는 일은 She works. 주어가 바뀌면 동사 끝이 바뀔 수 있어요. are를 붙여 행동을 표현하는 것은 아니에요.','일반동사는 행동 등을 말합니다. 현재형은 습관·사실을 나타냅니다. he/she/it의 현재 긍정문에는 보통 -s/-es를 붙입니다.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_lesson WHERE code='verbs');
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='verbs'),1,'I work here.','나는 여기서 일한다.','I: 주어 / work: 일반동사 / here: 장소 설명','I에는 work를 그대로 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='verbs') AND sequence_no=1);
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='verbs'),2,'She reads every day.','그녀는 매일 읽는다.','She: 주어 / reads: 일반동사 / every day: 때 설명','She는 3인칭 단수라 read에 -s가 붙어요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='verbs') AND sequence_no=2);
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='verbs'),3,'They study English.','그들은 영어를 공부한다.','They: 주어 / study: 동사 / English: 목적어','They는 여러 사람이라 studies가 아닌 study예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='verbs') AND sequence_no=3);
INSERT INTO grammar_lesson (code,title,level,sort_order,estimated_minutes,revision,objective,content,easier_explanation,summary,created_at,updated_at,version)
SELECT 'tense','현재형과 과거형',1,8,10,1,'평소의 일과 이미 끝난 일을 구분합니다.','I work every day.는 평소에 반복하는 일이에요. I worked yesterday.는 어제 일했다는 뜻이에요. 동사 모양으로 일이 일어나는 때를 나타내는 방법을 시제라고 해요.
많은 일반동사는 과거의 일을 말할 때 끝에 -ed를 붙여요. work는 worked, visit은 visited가 돼요. 이미 끝이 e인 live에는 d만 붙여 lived가 돼요. yesterday(어제), last week(지난주)는 끝난 과거를 찾는 단서예요.
규칙과 다르게 바뀌는 동사도 있어요. go는 went, have는 had, eat은 ate예요. I went home.은 ''나는 집에 갔다''예요. 일반동사의 과거 긍정문에서는 I worked와 She worked처럼 주어가 달라도 같은 과거형을 쓰는 경우가 많아요.
be동사의 과거형은 I/he/she/it에는 was, you/we/they에는 were예요. She is busy.와 She was busy yesterday.를 비교해요. 과거 부정문과 의문문은 did의 도움을 받는다는 것을 다음 강의에서 배워요.','매일 하는 일이면 work, 어제 끝난 일이면 worked예요. 단서 단어 yesterday를 보면 어제의 일을 떠올려요. go의 어제 모양은 went예요.','현재형: 습관·사실. 과거형: 끝난 과거의 일. work→worked, go→went. be의 과거형은 was/were입니다.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_lesson WHERE code='tense');
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='tense'),1,'I work every day.','나는 매일 일한다.','I: 주어 / work: 현재형 동사 / every day: 반복의 단서','평소의 습관을 말해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='tense') AND sequence_no=1);
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='tense'),2,'She worked yesterday.','그녀는 어제 일했다.','She: 주어 / worked: 과거형 동사 / yesterday: 과거의 단서','끝난 어제의 행동이라 worked예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='tense') AND sequence_no=2);
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='tense'),3,'They were busy last week.','그들은 지난주에 바빴다.','They: 주어 / were: be동사 과거형 / busy: 보어 / last week: 때 설명','They와 과거의 상태를 말하므로 were예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='tense') AND sequence_no=3);
INSERT INTO grammar_lesson (code,title,level,sort_order,estimated_minutes,revision,objective,content,easier_explanation,summary,created_at,updated_at,version)
SELECT 'negative','부정문과 의문문',1,9,10,1,'아니라고 말하고 질문하는 기본 순서를 배웁니다.','''아니다'' 또는 ''하지 않는다''라는 문장을 부정문이라고 해요. be동사는 바로 뒤에 not을 놓아요. She is not busy.는 ''그녀는 바쁘지 않다''예요. 질문할 때는 be동사를 주어 앞으로 옮겨요. Is she busy?는 ''그녀는 바쁜가요?''예요.
일반동사는 현재의 부정문에서 do not 또는 does not의 도움을 받아요. I do not work here.는 ''나는 여기서 일하지 않는다''예요. he/she/it처럼 3인칭 단수이면 does not을 써요. She does not work here.에서 work에 -s를 다시 붙이지 않아요.
일반동사의 현재 의문문은 Do/Does → 주어 → 동사원형 순서예요. Does she work here?에서 does가 이미 주어에 맞게 바뀌었으므로 뒤에는 원래 모양인 work가 와요. 원래 모양을 동사원형이라고 불러요.
끝난 과거를 부정하거나 질문할 때는 did를 써요. She did not work yesterday. / Did she work yesterday?처럼 뒤의 동사는 원형이에요. don''t는 do not, doesn''t는 does not, didn''t는 did not을 줄인 말이에요.','be가 있으면 not을 뒤에 붙이거나 be를 앞으로 옮겨요. 행동 동사라면 do/does/did에게 도움을 받아요. 도움 뒤의 행동 동사는 원래 모양이에요.','be: is not / Is she…? 일반동사: do/does not + 원형 / Do/Does + 주어 + 원형? 과거: did + 원형.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_lesson WHERE code='negative');
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='negative'),1,'She is not busy.','그녀는 바쁘지 않다.','She: 주어 / is: 동사 / not: 부정 / busy: 보어','be동사 뒤에 not을 넣어요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='negative') AND sequence_no=1);
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='negative'),2,'Does she work here?','그녀는 여기서 일하나요?','Does: 질문을 돕는 말 / she: 주어 / work: 동사원형 / here: 장소 설명','does 뒤의 work에는 -s를 붙이지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='negative') AND sequence_no=2);
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='negative'),3,'They did not visit us yesterday.','그들은 어제 우리를 방문하지 않았다.','They: 주어 / did not: 과거 부정 / visit: 동사원형 / us: 목적어 / yesterday: 때 설명','과거는 did가 나타내므로 visited가 아닌 visit이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='negative') AND sequence_no=3);
INSERT INTO grammar_lesson (code,title,level,sort_order,estimated_minutes,revision,objective,content,easier_explanation,summary,created_at,updated_at,version)
SELECT 'parts','기초 품사 구분',1,10,10,1,'문장 속 역할을 보고 알맞은 단어 형태를 고릅니다.','단어를 성질에 따라 나눈 종류를 품사라고 불러요. 이름인 명사, 이름을 대신하는 대명사, 행동·상태의 동사, 이름을 꾸미는 형용사, 행동 등을 꾸미는 부사를 배웠어요. 문장 속 자리인 주어·목적어·보어와 단어 종류인 품사는 서로 다른 구분이에요.
The careful driver works safely.를 보세요. driver는 사람의 이름인 명사이며 주어의 중심이에요. careful은 그 운전자를 설명하는 형용사예요. works는 동사, safely는 일하는 방식을 말하는 부사예요.
단어 앞뒤를 연결하는 작은 말도 있어요. a/an/the는 명사 앞에서 대상을 소개하거나 가리키는 관사예요. in/on/at은 장소나 시간을 연결하는 전치사예요. and/but은 말이나 문장을 이어 주는 접속사예요. 이들은 다음 단계에서 자세히 배워요.
Part 5 빈칸에서는 뜻뿐 아니라 자리를 보세요. a ___ report라면 report라는 명사를 설명하는 형용사를 생각해요. works ___라면 행동을 설명하는 부사를 생각해요. 한 단어가 문맥에 따라 다른 품사가 될 수 있으니 끝 모양만 외우지 마세요.','단어의 종류는 이름표예요. 문장 안에서 맡은 자리는 역할이에요. report는 명사지만 주어도 목적어도 될 수 있어요. 빈칸 옆의 단어가 무엇인지 먼저 보세요.','품사는 단어의 종류, 주어·목적어는 문장 안 역할입니다. 명사를 설명하면 형용사, 행동을 설명하면 부사를 먼저 생각합니다.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_lesson WHERE code='parts');
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='parts'),1,'The careful driver works safely.','그 주의 깊은 운전자는 안전하게 일한다.','The careful driver: 주어 (careful: 형용사, driver: 명사) / works: 동사 / safely: 부사','careful은 사람을, safely는 행동을 설명해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='parts') AND sequence_no=1);
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='parts'),2,'She writes a clear report.','그녀는 명확한 보고서를 쓴다.','She: 주어인 대명사 / writes: 동사 / a clear report: 목적어 (clear: 형용사)','clear는 report 앞에서 보고서의 성질을 설명해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='parts') AND sequence_no=2);
INSERT INTO grammar_example (lesson_id,sequence_no,sentence,translation,analysis,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM grammar_lesson WHERE code='parts'),3,'We work in an office.','우리는 사무실에서 일한다.','We: 주어 / work: 동사 / in an office: 장소 표현 (in: 전치사)','in은 사무실 안이라는 장소 관계를 나타내요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM grammar_example WHERE lesson_id=(SELECT id FROM grammar_lesson WHERE code='parts') AND sequence_no=3);
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'practice-001',(SELECT id FROM grammar_lesson WHERE code='structure'),'PRACTICE',0,'structure','I read a book.에서 읽는 대상은 무엇일까요?','나는 책을 읽는다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='practice-001');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-001'),'A','a book','책을 읽으므로 대상이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-001') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-001'),'B','I','읽는 사람인 주어예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-001') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-001'),'C','read','읽는 행동인 동사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-001') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-001'),'D','없음','책이라는 대상이 문장에 있어요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-001') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-001'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-001') AND option_key='A'),'read 뒤의 a book은 읽는 대상, 즉 목적어예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='practice-001'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'practice-002',(SELECT id FROM grammar_lesson WHERE code='structure'),'PRACTICE',0,'structure','영어로 “나는 커피를 좋아한다”에 맞는 순서를 고르세요.','나는 커피를 좋아한다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='practice-002');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-002'),'A','I coffee like.','한국어처럼 대상을 동사 앞에 놓았어요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-002') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-002'),'B','Like I coffee.','평범한 설명문의 주어보다 동사가 먼저 왔어요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-002') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-002'),'C','Coffee I like.','강조 등의 특수한 문맥 없이 쓰는 기본 순서가 아니에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-002') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-002'),'D','I like coffee.','주어, 동사, 대상 순서예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-002') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-002'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-002') AND option_key='D'),'영어는 주어 I → 동사 like → 목적어 coffee 순서예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='practice-002'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'practice-003',(SELECT id FROM grammar_lesson WHERE code='subject-verb'),'PRACTICE',0,'subject-verb','The bus arrives.에서 주어를 고르세요.','버스가 도착한다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='practice-003');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-003'),'A','The','bus와 함께 쓰이는 관사로, 혼자 주어가 아니에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-003') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-003'),'B','없음','주어 The bus가 있어요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-003') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-003'),'C','The bus','도착하는 주인공이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-003') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-003'),'D','arrives','도착한다는 동사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-003') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-003'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-003') AND option_key='C'),'도착하는 것은 버스이므로 The bus 전체가 주어예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='practice-003'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'practice-004',(SELECT id FROM grammar_lesson WHERE code='subject-verb'),'PRACTICE',0,'subject-verb','She is happy.에서 동사를 고르세요.','그녀는 행복하다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='practice-004');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-004'),'A','She happy','be동사 없이 이 두 말만으로 기본 설명문을 만들 수 없어요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-004') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-004'),'B','is','상태를 이어 주는 be동사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-004') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-004'),'C','She','상태의 주인공인 주어예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-004') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-004'),'D','happy','상태를 설명하는 형용사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-004') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-004'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-004') AND option_key='B'),'is가 그녀와 행복한 상태를 연결하는 동사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='practice-004'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'practice-005',(SELECT id FROM grammar_lesson WHERE code='nouns'),'PRACTICE',0,'nouns','다음 중 물건의 이름인 명사를 고르세요.','desk는 책상이라는 뜻이다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='practice-005');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-005'),'A','desk','책상이라는 물건의 이름이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-005') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-005'),'B','quickly','빠르게라는 부사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-005') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-005'),'C','read','여기서는 읽다라는 동사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-005') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-005'),'D','new','새로운이라는 형용사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-005') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-005'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-005') AND option_key='A'),'desk는 물건의 이름이므로 명사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='practice-005'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'practice-006',(SELECT id FROM grammar_lesson WHERE code='nouns'),'PRACTICE',0,'nouns','Mina is a teacher. ___ works here. 앞의 Mina(그녀)를 대신할 말을 고르세요.','미나는 선생님이다. 그녀는 여기서 일한다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='practice-006');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-006'),'A','Her','her는 보통 대상 또는 소유를 나타내며 이 주어 자리에 쓰지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-006') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-006'),'B','They','They를 주어로 쓰면 동사는 works가 아니라 work여야 해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-006') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-006'),'C','It','사람인 미나를 물건처럼 it으로 받지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-006') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-006'),'D','She','여자 한 사람을 대신하는 주어 형태예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-006') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-006'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-006') AND option_key='D'),'앞에서 말한 미나를 주어 자리의 She로 바꿀 수 있어요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='practice-006'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'practice-007',(SELECT id FROM grammar_lesson WHERE code='objects'),'PRACTICE',0,'objects','She is a doctor.에서 a doctor는 어떤 역할일까요?','그녀는 의사이다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='practice-007');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-007'),'A','동사','동사는 is예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-007') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-007'),'B','주어','주어는 She예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-007') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-007'),'C','보어','그녀가 의사라고 설명해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-007') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-007'),'D','목적어','무엇을 하는 대상이 아니에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-007') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-007'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-007') AND option_key='C'),'의사는 행동의 대상이 아니라 그녀가 누구인지 설명하는 보어예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='practice-007'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'practice-008',(SELECT id FROM grammar_lesson WHERE code='objects'),'PRACTICE',0,'objects','I need help.에서 목적어를 고르세요.','나는 도움이 필요하다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='practice-008');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-008'),'A','없음','need 뒤에 대상 help가 있어요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-008') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-008'),'B','help','필요한 대상인 도움을 뜻해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-008') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-008'),'C','I','도움이 필요한 사람인 주어예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-008') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-008'),'D','need','필요하다는 동사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-008') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-008'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-008') AND option_key='B'),'무엇이 필요한지에 대한 답인 help가 need의 대상이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='practice-008'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'practice-009',(SELECT id FROM grammar_lesson WHERE code='modifiers'),'PRACTICE',0,'modifiers','She works ___. 알맞은 말을 고르세요.','그녀는 주의 깊게 일한다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='practice-009');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-009'),'A','carefully','어떻게 일하는지 설명하는 부사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-009') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-009'),'B','careful','주의 깊은이라는 형용사라 이 행동을 꾸미는 자리에 맞지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-009') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-009'),'C','care','주의라는 명사 또는 돌보다라는 동사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-009') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-009'),'D','caring','돌보는 성질 등을 말하며 여기서 필요한 주의 깊게라는 뜻이 아니에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-009') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-009'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-009') AND option_key='A'),'일하는 행동 works를 꾸미므로 부사 carefully를 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='practice-009'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'practice-010',(SELECT id FROM grammar_lesson WHERE code='modifiers'),'PRACTICE',0,'modifiers','This is a ___ desk. “새 책상”이 되도록 고르세요.','이것은 새 책상이다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='practice-010');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-010'),'A','newly','새롭게라는 부사라 명사 desk를 바로 꾸미지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-010') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-010'),'B','news','소식이라는 명사로, 새 책상이라는 뜻이 아니에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-010') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-010'),'C','newness','새로움이라는 명사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-010') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-010'),'D','new','새로운이라는 형용사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-010') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-010'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-010') AND option_key='D'),'명사 desk 앞에서 책상의 성질을 말하므로 형용사 new예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='practice-010'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'practice-011',(SELECT id FROM grammar_lesson WHERE code='be'),'PRACTICE',0,'be','I ___ a student.','나는 학생이다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='practice-011');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-011'),'A','are','you, we, they 등에 맞는 모양이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-011') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-011'),'B','be','원형을 I 뒤에 그대로 쓴 현재 설명문은 맞지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-011') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-011'),'C','am','I와 짝인 be동사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-011') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-011'),'D','is','he, she, it 등에 맞는 모양이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-011') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-011'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-011') AND option_key='C'),'주어 I에 맞는 현재형 be동사는 am이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='practice-011'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'practice-012',(SELECT id FROM grammar_lesson WHERE code='be'),'PRACTICE',0,'be','They ___ busy.','그들은 바쁘다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='practice-012');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-012'),'A','being','단독으로 현재 설명문의 동사가 될 수 없어요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-012') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-012'),'B','are','They와 짝이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-012') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-012'),'C','is','한 사람이나 한 사물에 맞는 모양이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-012') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-012'),'D','am','I와 짝이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-012') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-012'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-012') AND option_key='B'),'주어 They에 맞는 현재형은 are예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='practice-012'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'practice-013',(SELECT id FROM grammar_lesson WHERE code='verbs'),'PRACTICE',0,'verbs','She ___ here every day.','그녀는 매일 여기서 일한다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='practice-013');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-013'),'A','works','현재 긍정문에서 She와 맞아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-013') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-013'),'B','work','I, you, we, they와 쓰는 현재형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-013') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-013'),'C','working','진행형에는 be가 추가로 필요해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-013') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-013'),'D','to work','to work만으로 주어 뒤의 동사 역할을 할 수 없어요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-013') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-013'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-013') AND option_key='A'),'She는 3인칭 단수이고 현재의 습관이므로 works예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='practice-013'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'practice-014',(SELECT id FROM grammar_lesson WHERE code='verbs'),'PRACTICE',0,'verbs','They ___ English every day.','그들은 매일 영어를 공부한다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='practice-014');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-014'),'A','studies','3인칭 단수 주어에 쓰는 현재형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-014') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-014'),'B','studying','be 없이 이 문장의 동사가 될 수 없어요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-014') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-014'),'C','to study','이 자리에는 시제를 가진 동사가 필요해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-014') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-014'),'D','study','복수 주어 They에 맞는 현재형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-014') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-014'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-014') AND option_key='D'),'They는 복수 주어라 현재형 study를 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='practice-014'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'practice-015',(SELECT id FROM grammar_lesson WHERE code='tense'),'PRACTICE',0,'tense','She ___ yesterday. “어제 일했다”가 되도록 고르세요.','그녀는 어제 일했다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='practice-015');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-015'),'A','work','과거의 일을 나타내지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-015') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-015'),'B','working','be 없이 과거 설명문을 만들지 못해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-015') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-015'),'C','worked','work의 과거형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-015') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-015'),'D','works','현재 습관을 말하는 모양이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-015') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-015'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-015') AND option_key='C'),'yesterday가 끝난 과거를 나타내므로 worked예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='practice-015'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'practice-016',(SELECT id FROM grammar_lesson WHERE code='tense'),'PRACTICE',0,'tense','They ___ busy last week.','그들은 지난주에 바빴다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='practice-016');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-016'),'A','is','현재형이며 복수 주어와도 맞지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-016') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-016'),'B','were','복수 주어의 be동사 과거형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-016') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-016'),'C','was','I, he, she, it 등에 쓰는 과거형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-016') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-016'),'D','are','현재형이라 지난주라는 문맥과 맞지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-016') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-016'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-016') AND option_key='B'),'They의 과거 상태에는 were를 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='practice-016'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'practice-017',(SELECT id FROM grammar_lesson WHERE code='negative'),'PRACTICE',0,'negative','She does not ___ here.','그녀는 여기서 일하지 않는다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='practice-017');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-017'),'A','work','does not 뒤에는 원형을 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-017') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-017'),'B','works','does와 동사 양쪽에 단수 표시를 하지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-017') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-017'),'C','worked','does not 뒤에 과거형을 쓰지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-017') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-017'),'D','working','does not 뒤에 -ing형을 쓰지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-017') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-017'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-017') AND option_key='A'),'does가 이미 주어에 맞게 바뀌었으므로 뒤에는 원형 work예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='practice-017'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'practice-018',(SELECT id FROM grammar_lesson WHERE code='negative'),'PRACTICE',0,'negative','___ she busy? 현재 상태를 묻는 질문입니다.','그녀는 바쁜가요?',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='practice-018');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-018'),'A','Does','Does 뒤에는 일반동사가 필요하지만 여기에는 없어요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-018') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-018'),'B','Do','she에는 does가 맞으며, 여기에는 be동사가 필요해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-018') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-018'),'C','Are','she와는 are가 아니라 is가 맞아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-018') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-018'),'D','Is','Is she busy?가 올바른 질문이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-018') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-018'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-018') AND option_key='D'),'busy는 상태를 말하는 형용사이므로 be동사 is를 앞으로 옮겨요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='practice-018'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'practice-019',(SELECT id FROM grammar_lesson WHERE code='parts'),'PRACTICE',0,'parts','a clear report에서 clear의 품사는 무엇일까요?','명확한 보고서',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='practice-019');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-019'),'A','동사','이 표현에서 행동을 말하지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-019') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-019'),'B','대명사','어떤 이름을 대신하지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-019') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-019'),'C','형용사','어떤 보고서인지 설명해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-019') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-019'),'D','명사','보고서라는 이름은 report예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-019') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-019'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-019') AND option_key='C'),'clear는 명사 report의 성질을 설명하는 형용사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='practice-019'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'practice-020',(SELECT id FROM grammar_lesson WHERE code='parts'),'PRACTICE',0,'parts','She writes ___. “그녀는 명확하게 쓴다”가 되도록 고르세요.','그녀는 명확하게 쓴다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='practice-020');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-020'),'A','clearness','명확함이라는 명사로 행동의 방식을 말하는 부사가 아니에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-020') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-020'),'B','clearly','어떻게 쓰는지 말하는 부사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-020') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-020'),'C','clear','형용사라 이 문맥에서 동사를 꾸미는 자리에 맞지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-020') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-020'),'D','clarity','명확함이라는 명사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-020') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='practice-020'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='practice-020') AND option_key='B'),'쓰는 행동 writes를 설명하므로 부사 clearly예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='practice-020'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-001',(SELECT id FROM grammar_lesson WHERE code='be'),'PART5',1,'be','The office ___ quiet today.','사무실은 오늘 조용하다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-001');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-001'),'A','is','단수 주어의 현재 상태를 이어 줘요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-001') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-001'),'B','are','복수 주어와 어울려요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-001') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-001'),'C','am','I에만 맞아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-001') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-001'),'D','be','현재 설명문에는 활용한 동사가 필요해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-001') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-001'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-001') AND option_key='A'),'사무실 한 곳의 현재 상태이므로 is예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-001'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-002',(SELECT id FROM grammar_lesson WHERE code='be'),'PART5',1,'be','Our employees ___ ready for the meeting.','우리 직원들은 회의 준비가 되어 있다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-002');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-002'),'A','is','단수 주어에 쓰는 모양이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-002') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-002'),'B','am','I와 쓰는 모양이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-002') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-002'),'C','being','이것만으로 설명문 동사를 만들 수 없어요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-002') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-002'),'D','are','복수 주어와 맞아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-002') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-002'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-002') AND option_key='D'),'employees는 여러 직원이므로 are예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-002'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-003',(SELECT id FROM grammar_lesson WHERE code='be'),'PART5',1,'be','I ___ available this afternoon.','나는 오늘 오후에 시간이 된다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-003');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-003'),'A','are','you, we, they와 맞아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-003') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-003'),'B','been','완료형 등을 만들 때 쓰며 단독으로 맞지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-003') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-003'),'C','am','I와 맞는 현재형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-003') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-003'),'D','is','I와 맞지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-003') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-003'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-003') AND option_key='C'),'I의 현재 상태는 am으로 이어 줘요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-003'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-004',(SELECT id FROM grammar_lesson WHERE code='be'),'PART5',1,'be','The manager ___ busy yesterday.','관리자는 어제 바빴다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-004');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-004'),'A','are','현재형이며 단수 주어와 맞지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-004') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-004'),'B','was','단수 주어의 과거 상태예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-004') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-004'),'C','were','복수 주어의 과거 상태에 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-004') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-004'),'D','is','어제가 아니라 현재 상태예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-004') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-004'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-004') AND option_key='B'),'단수 주어와 어제의 상태이므로 was예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-004'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-005',(SELECT id FROM grammar_lesson WHERE code='be'),'PART5',1,'be','The rooms ___ clean last night.','방들은 어젯밤에 깨끗했다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-005');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-005'),'A','were','복수 주어의 과거형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-005') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-005'),'B','was','단수 주어의 과거형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-005') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-005'),'C','are','현재형이라 과거 문맥과 맞지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-005') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-005'),'D','is','단수 현재형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-005') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-005'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-005') AND option_key='A'),'rooms는 복수이고 last night은 과거라 were예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-005'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-006',(SELECT id FROM grammar_lesson WHERE code='verbs'),'PART5',1,'verbs','Mina ___ the schedule every morning.','미나는 매일 아침 일정을 확인한다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-006');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-006'),'A','check','Mina 주어에 단수 표시가 필요해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-006') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-006'),'B','checking','be 없이 동사 자리를 채우지 못해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-006') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-006'),'C','to check','이 자리에는 시제를 가진 동사가 필요해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-006') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-006'),'D','checks','3인칭 단수 현재형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-006') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-006'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-006') AND option_key='D'),'Mina 한 사람의 현재 습관이므로 checks예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-006'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-007',(SELECT id FROM grammar_lesson WHERE code='verbs'),'PART5',1,'verbs','We ___ reports every Friday.','우리는 매주 금요일에 보고서를 작성한다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-007');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-007'),'A','writing','동사 앞에 be 등이 필요해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-007') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-007'),'B','to write','주어 뒤의 본동사로 이 형태만 쓰지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-007') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-007'),'C','write','We에 맞는 현재형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-007') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-007'),'D','writes','3인칭 단수에 쓰는 현재형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-007') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-007'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-007') AND option_key='C'),'We는 복수이므로 현재형 write를 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-007'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-008',(SELECT id FROM grammar_lesson WHERE code='verbs'),'PART5',1,'verbs','The bus ___ at this stop every day.','버스는 매일 이 정류장에 선다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-008');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-008'),'A','to stop','주어 뒤 본동사의 형태가 아니에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-008') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-008'),'B','stops','단수 주어와 현재 습관에 맞아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-008') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-008'),'C','stop','단수 표시 -s가 필요해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-008') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-008'),'D','stopping','단독으로 현재 설명문을 만들지 못해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-008') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-008'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-008') AND option_key='B'),'bus 한 대의 습관이므로 stops예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-008'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-009',(SELECT id FROM grammar_lesson WHERE code='verbs'),'PART5',1,'verbs','My colleague ___ English after work.','내 동료는 퇴근 후 영어를 공부한다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-009');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-009'),'A','studies','자음+y 끝은 y를 i로 바꾸고 -es를 붙여요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-009') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-009'),'B','study','단수 현재 긍정문이라 형태를 바꿔야 해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-009') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-009'),'C','studying','진행형이라면 be가 필요해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-009') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-009'),'D','to study','이 형태만으로 본동사가 될 수 없어요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-009') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-009'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-009') AND option_key='A'),'단수 주어의 study는 studies로 바뀌어요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-009'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-010',(SELECT id FROM grammar_lesson WHERE code='verbs'),'PART5',1,'verbs','They ___ lunch at noon every day.','그들은 매일 정오에 점심을 먹는다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-010');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-010'),'A','has','he, she 등 3인칭 단수에 맞아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-010') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-010'),'B','having','단독 본동사로 맞지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-010') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-010'),'C','to have','이 자리에 필요한 현재형이 아니에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-010') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-010'),'D','have','복수 주어와 맞아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-010') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-010'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-010') AND option_key='D'),'They의 현재형은 have예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-010'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-011',(SELECT id FROM grammar_lesson WHERE code='tense'),'PART5',1,'tense','We ___ the client yesterday.','우리는 어제 고객을 방문했다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-011');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-011'),'A','visits','현재 단수형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-011') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-011'),'B','visiting','과거 설명문 동사로 혼자 쓰지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-011') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-011'),'C','visited','visit의 과거형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-011') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-011'),'D','visit','현재형으로 과거를 나타내지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-011') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-011'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-011') AND option_key='C'),'어제 끝난 일이므로 visited를 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-011'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-012',(SELECT id FROM grammar_lesson WHERE code='tense'),'PART5',1,'tense','Jin ___ to the office last Monday.','진은 지난 월요일에 사무실에 갔다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-012');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-012'),'A','going','이 문장에서는 be 없이 쓸 수 없어요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-012') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-012'),'B','went','go의 불규칙 과거형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-012') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-012'),'C','go','원형이며 과거를 나타내지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-012') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-012'),'D','goes','현재 단수형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-012') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-012'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-012') AND option_key='B'),'go의 과거형은 went예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-012'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-013',(SELECT id FROM grammar_lesson WHERE code='tense'),'PART5',1,'tense','The team ___ the work last week.','그 팀은 지난주에 일을 마쳤다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-013');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-013'),'A','finished','끝난 과거의 행동을 말해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-013') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-013'),'B','finishes','현재 단수형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-013') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-013'),'C','finish','현재형이나 원형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-013') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-013'),'D','finishing','단독으로 과거형이 되지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-013') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-013'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-013') AND option_key='A'),'last week는 과거이므로 finished예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-013'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-014',(SELECT id FROM grammar_lesson WHERE code='tense'),'PART5',1,'tense','She ___ a new desk two days ago.','그녀는 이틀 전에 새 책상을 샀다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-014');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-014'),'A','buys','현재형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-014') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-014'),'B','buy','과거형이 아니에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-014') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-014'),'C','buying','단독으로 끝난 과거를 말하지 못해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-014') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-014'),'D','bought','buy의 과거형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-014') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-014'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-014') AND option_key='D'),'ago는 과거의 단서이며 buy는 bought로 바뀌어요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-014'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-015',(SELECT id FROM grammar_lesson WHERE code='tense'),'PART5',1,'tense','We ___ a meeting yesterday morning.','우리는 어제 아침 회의를 했다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-015');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-015'),'A','has','현재 단수형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-015') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-015'),'B','having','동사 자리에서 혼자 과거를 나타낼 수 없어요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-015') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-015'),'C','had','have의 과거형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-015') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-015'),'D','have','현재형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-015') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-015'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-015') AND option_key='C'),'have a meeting의 과거형은 had a meeting이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-015'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-016',(SELECT id FROM grammar_lesson WHERE code='negative'),'PART5',1,'negative','The manager does not ___ on Sundays.','관리자는 일요일마다 일하지 않는다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-016');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-016'),'A','working','does not 뒤의 원형 자리에 -ing형을 쓰지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-016') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-016'),'B','work','원형이라 맞아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-016') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-016'),'C','works','does 뒤에 -s를 다시 붙이지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-016') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-016'),'D','worked','현재 부정문에 과거형을 쓰지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-016') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-016'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-016') AND option_key='B'),'does not 뒤에는 동사원형 work예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-016'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-017',(SELECT id FROM grammar_lesson WHERE code='negative'),'PART5',1,'negative','___ you work in this building?','당신은 이 건물에서 일하나요?',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-017');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-017'),'A','Do','Do you + 원형 순서예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-017') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-017'),'B','Does','3인칭 단수 질문에 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-017') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-017'),'C','Is','be와 일반동사 원형을 이처럼 붙이지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-017') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-017'),'D','Am','I의 상태를 물을 때 쓰는 be동사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-017') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-017'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-017') AND option_key='A'),'일반동사 work의 현재 질문이며 you에는 Do예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-017'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-018',(SELECT id FROM grammar_lesson WHERE code='negative'),'PART5',1,'negative','She ___ not ready for the meeting.','그녀는 회의 준비가 되어 있지 않다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-018');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-018'),'A','does','뒤에 일반동사 원형이 필요해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-018') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-018'),'B','do','She와 맞지 않으며 행동 동사도 없어요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-018') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-018'),'C','are','She와 수일치하지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-018') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-018'),'D','is','is not ready로 상태를 부정해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-018') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-018'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-018') AND option_key='D'),'ready는 상태 형용사이고 She의 현재 be는 is예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-018'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-019',(SELECT id FROM grammar_lesson WHERE code='negative'),'PART5',1,'negative','Did they ___ the report yesterday?','그들은 어제 보고서를 보냈나요?',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-019');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-019'),'A','sends','did 뒤에 현재 단수형을 쓰지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-019') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-019'),'B','sending','did 뒤의 원형이 아니에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-019') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-019'),'C','send','did 뒤에는 동사원형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-019') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-019'),'D','sent','did가 과거를 나타내므로 과거형을 다시 쓰지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-019') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-019'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-019') AND option_key='C'),'과거 질문은 Did + 주어 + 원형이므로 send예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-019'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-020',(SELECT id FROM grammar_lesson WHERE code='negative'),'PART5',1,'negative','We did not ___ the office last night.','우리는 어젯밤 사무실을 청소하지 않았다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-020');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-020'),'A','cleaning','did not 뒤의 원형이 아니에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-020') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-020'),'B','clean','원형이라 맞아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-020') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-020'),'C','cleaned','과거 표시는 did가 이미 해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-020') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-020'),'D','cleans','현재 단수형을 쓰는 자리가 아니에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-020') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-020'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-020') AND option_key='B'),'did not 뒤에는 clean의 원형이 와요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-020'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-021',(SELECT id FROM grammar_lesson WHERE code='modifiers'),'PART5',1,'modifiers','Please read the instructions ___.','설명서를 주의 깊게 읽어 주세요.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-021');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-021'),'A','carefully','주의 깊게라는 부사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-021') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-021'),'B','careful','명사를 꾸미는 형용사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-021') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-021'),'C','care','주의라는 명사 또는 돌보다라는 동사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-021') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-021'),'D','cares','동사 단수형으로, 행동의 방식을 설명하지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-021') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-021'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-021') AND option_key='A'),'read라는 행동을 꾸미므로 carefully예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-021'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-022',(SELECT id FROM grammar_lesson WHERE code='modifiers'),'PART5',1,'modifiers','This report is very ___.','이 보고서는 매우 중요하다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-022');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-022'),'A','importantly','부사만으로 보고서가 어떤 상태인지 설명하는 이 보어 자리를 채우지 못해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-022') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-022'),'B','importance','중요성이라는 명사라 very 뒤의 형용사 자리에 맞지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-022') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-022'),'C','import','수입이라는 명사 또는 수입하다라는 동사라 이 형용사 자리에 맞지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-022') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-022'),'D','important','중요한이라는 형용사 보어예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-022') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-022'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-022') AND option_key='D'),'be동사 뒤에서 보고서의 성질을 설명하며 very의 꾸밈을 받는 형용사 important가 필요해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-022'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-023',(SELECT id FROM grammar_lesson WHERE code='modifiers'),'PART5',1,'modifiers','The receptionist speaks ___.','접수 직원은 공손하게 말한다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-023');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-023'),'A','politeness','공손함이라는 명사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-023') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-023'),'B','politer','더 공손한이라는 비교 형용사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-023') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-023'),'C','politely','말하는 방식을 나타내는 부사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-023') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-023'),'D','polite','형용사라 동사를 꾸미는 이 자리에 맞지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-023') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-023'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-023') AND option_key='C'),'speaks를 꾸미는 부사 politely가 맞아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-023'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-024',(SELECT id FROM grammar_lesson WHERE code='modifiers'),'PART5',1,'modifiers','We need a ___ answer.','우리는 명확한 답이 필요하다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-024');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-024'),'A','clearness','명확함이라는 명사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-024') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-024'),'B','clear','명사를 꾸미는 형용사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-024') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-024'),'C','clearly','행동 등을 꾸미는 부사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-024') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-024'),'D','clarity','명확성이라는 명사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-024') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-024'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-024') AND option_key='B'),'명사 answer의 성질을 설명하므로 clear예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-024'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-025',(SELECT id FROM grammar_lesson WHERE code='modifiers'),'PART5',1,'modifiers','The staff completed the task ___. 격식 있는 글에서 “빨리”에 해당하는 말을 고르세요.','직원들은 일을 빨리 완료했다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-025');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-025'),'A','quickly','완료하는 속도를 말하는 부사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-025') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-025'),'B','quick','이런 격식 있는 문장에서는 부사 quickly를 쓰는 것이 적절해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-025') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-025'),'C','quickness','빠름이라는 명사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-025') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-025'),'D','quicken','빨라지다라는 동사로, 완료한 방식을 설명하는 부사가 아니에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-025') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-025'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-025') AND option_key='A'),'격식 있는 글에서 completed라는 행동을 꾸미는 부사 quickly를 골라요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-025'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-026',(SELECT id FROM grammar_lesson WHERE code='nouns'),'PART5',1,'nouns','___ is our new manager. “그녀”에 해당하는 말을 고르세요.','그녀는 우리의 새 관리자이다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-026');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-026'),'A','Her','대상 또는 소유를 나타내는 형태예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-026') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-026'),'B','Hers','그녀의 것이라는 소유대명사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-026') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-026'),'C','Herself','그녀 자신이라는 말로 여기서 독립된 기본 주어가 아니에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-026') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-026'),'D','She','주어 형태예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-026') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-026'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-026') AND option_key='D'),'주어 자리에 쓰는 그녀는 She예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-026'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-027',(SELECT id FROM grammar_lesson WHERE code='nouns'),'PART5',1,'nouns','Please send the email to ___. “나에게”가 되도록 고르세요.','그 이메일을 나에게 보내 주세요.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-027');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-027'),'A','my','뒤에 소유하는 명사가 필요해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-027') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-027'),'B','mine','나의 것이라는 소유대명사로 나에게라는 뜻이 아니에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-027') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-027'),'C','me','전치사 뒤의 목적격이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-027') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-027'),'D','I','주어로 쓰는 형태예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-027') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-027'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-027') AND option_key='C'),'전치사 to 뒤에서 대상이 되는 나를 me라고 해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-027'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-028',(SELECT id FROM grammar_lesson WHERE code='nouns'),'PART5',1,'nouns','The employees brought ___ laptops.','직원들은 자신들의 노트북을 가져왔다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-028');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-028'),'A','theirs','뒤에 명사를 붙이지 않는 소유대명사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-028') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-028'),'B','their','명사 앞에서 소유를 나타내요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-028') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-028'),'C','they','주어 형태예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-028') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-028'),'D','them','대상 형태로 명사 앞에서 소유를 나타내지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-028') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-028'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-028') AND option_key='B'),'명사 laptops 앞에서 그들의 소유를 나타내는 their가 와요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-028'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-029',(SELECT id FROM grammar_lesson WHERE code='nouns'),'PART5',1,'nouns','This is ___ desk. “나의 책상”이 되도록 고르세요.','이것은 나의 책상이다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-029');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-029'),'A','my','나의라는 뜻으로 명사 앞에 와요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-029') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-029'),'B','I','주어 형태예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-029') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-029'),'C','me','대상 형태예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-029') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-029'),'D','mine','나의 것이라는 뜻으로 뒤에 desk를 붙이지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-029') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-029'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-029') AND option_key='A'),'desk 앞에 소유를 나타내는 my를 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-029'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-030',(SELECT id FROM grammar_lesson WHERE code='nouns'),'PART5',1,'nouns','The printer is new. ___ works well.','그 프린터는 새것이다. 그것은 잘 작동한다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-030');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-030'),'A','They','여러 사물을 나타내므로 한 프린터와 맞지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-030') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-030'),'B','Its','보통 뒤에 명사가 와야 하는 소유 형태예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-030') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-030'),'C','Them','주어 자리에 쓰는 형태가 아니에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-030') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-030'),'D','It','한 사물을 대신하는 주어예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-030') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-030'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-030') AND option_key='D'),'프린터 한 대를 주어 It으로 받아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-030'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-031',(SELECT id FROM grammar_lesson WHERE code='parts'),'PART5',1,'parts','Please write your ___ here.','여기에 당신의 이름을 써 주세요.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-031');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-031'),'A','named','이 문장에서 이름이라는 대상 명사로 쓰이지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-031') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-031'),'B','nameless','이름 없는이라는 형용사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-031') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-031'),'C','name','이름이라는 명사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-031') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-031'),'D','namely','즉이라는 부사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-031') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-031'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-031') AND option_key='C'),'your 뒤에서 쓰는 대상의 이름을 나타내는 명사 name이 필요해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-031'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-032',(SELECT id FROM grammar_lesson WHERE code='parts'),'PART5',1,'parts','The ___ starts at nine.','회의는 9시에 시작한다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-032');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-032'),'A','met','동사 과거형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-032') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-032'),'B','meeting','회의라는 명사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-032') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-032'),'C','to meet','to가 붙은 동사 표현을 The 바로 뒤에서 이런 명사처럼 쓰지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-032') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-032'),'D','meets','동사 현재 단수형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-032') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-032'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-032') AND option_key='B'),'시작하는 일의 이름인 명사 meeting이 주어의 중심이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-032'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-033',(SELECT id FROM grammar_lesson WHERE code='parts'),'PART5',1,'parts','Thank you for your ___.','도와주셔서 감사합니다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-033');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-033'),'A','assistance','도움이라는 명사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-033') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-033'),'B','assist','돕다라는 동사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-033') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-033'),'C','assisted','동사의 과거형 또는 분사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-033') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-033'),'D','assists','도움을 주다라는 동사의 단수 현재형이며 이 자리의 도움이라는 명사 형태가 아니에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-033') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-033'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-033') AND option_key='A'),'your 뒤에서 감사하는 대상인 명사 assistance가 필요해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-033'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-034',(SELECT id FROM grammar_lesson WHERE code='parts'),'PART5',1,'parts','The ___ of the project is important.','그 프로젝트의 성공은 중요하다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-034');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-034'),'A','successful','성공적인이라는 형용사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-034') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-034'),'B','successfully','성공적으로라는 부사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-034') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-034'),'C','succeed','성공하다라는 동사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-034') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-034'),'D','success','성공이라는 명사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-034') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-034'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-034') AND option_key='D'),'The와 of 사이에서 주어를 이루는 명사 success가 필요해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-034'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-035',(SELECT id FROM grammar_lesson WHERE code='parts'),'PART5',1,'parts','Please check the ___ before you travel.','여행하기 전에 정보를 확인해 주세요.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-035');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-035'),'A','informative','유익한이라는 형용사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-035') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-035'),'B','informatively','유익하게라는 부사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-035') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-035'),'C','information','정보라는 명사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-035') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-035'),'D','inform','알리다라는 동사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-035') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-035'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-035') AND option_key='C'),'check의 대상에 해당하는 명사 information이 맞아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-035'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-036',(SELECT id FROM grammar_lesson WHERE code='structure'),'PART5',1,'structure','The meeting starts ___ nine o’clock.','회의는 9시에 시작한다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-036');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-036'),'A','with','~와 함께라는 뜻으로 시작 시각 앞에 맞지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-036') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-036'),'B','at','시각 nine o’clock과 맞아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-036') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-036'),'C','on','주로 요일이나 날짜에 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-036') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-036'),'D','in','월, 연도, 기간 등에 쓰며 이 시각과 맞지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-036') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-036'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-036') AND option_key='B'),'정확한 시각 앞에는 전치사 at을 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-036'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-037',(SELECT id FROM grammar_lesson WHERE code='structure'),'PART5',1,'structure','We have a meeting ___ Monday.','우리는 월요일에 회의가 있다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-037');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-037'),'A','on','요일과 함께 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-037') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-037'),'B','at','정확한 시각 등에 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-037') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-037'),'C','in','월이나 연도 등에 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-037') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-037'),'D','under','아래에라는 위치 관계라 맞지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-037') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-037'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-037') AND option_key='A'),'요일 앞에는 on을 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-037'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-038',(SELECT id FROM grammar_lesson WHERE code='structure'),'PART5',1,'structure','The files are ___ the box. “상자 안에”가 되도록 고르세요.','파일들은 상자 안에 있다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-038');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-038'),'A','on','표면 위에라는 뜻이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-038') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-038'),'B','under','아래에라는 뜻이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-038') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-038'),'C','near','근처에라는 뜻이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-038') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-038'),'D','in','안에라는 뜻이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-038') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-038'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-038') AND option_key='D'),'상자 내부의 위치이므로 in이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-038'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-039',(SELECT id FROM grammar_lesson WHERE code='structure'),'PART5',1,'structure','I need ___ umbrella because it is raining.','비가 오므로 나는 우산 하나가 필요하다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-039');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-039'),'A','many','여러 개라 뒤에 복수 명사가 필요해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-039') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-039'),'B','these','이것들이라는 복수 표현이라 단수와 맞지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-039') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-039'),'C','an','umbrella의 첫소리는 모음이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-039') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-039'),'D','a','자음 소리 앞에서 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-039') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-039'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-039') AND option_key='C'),'umbrella는 셀 수 있는 단수이며 모음 소리로 시작하므로 an이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-039'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-040',(SELECT id FROM grammar_lesson WHERE code='structure'),'PART5',1,'structure','She is ___ teacher at a local school.','그녀는 지역 학교의 선생님이다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-040');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-040'),'A','those','복수 대상을 가리키므로 단수 teacher와 맞지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-040') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-040'),'B','a','teacher 앞에 맞는 부정관사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-040') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-040'),'C','an','teacher는 모음 소리로 시작하지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-040') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-040'),'D','many','복수 명사와 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-040') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-040'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-040') AND option_key='B'),'처음 소개하는 직업의 셀 수 있는 단수 명사이고 자음 소리라 a예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-040'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-041',(SELECT id FROM grammar_lesson WHERE code='objects'),'PART5',1,'objects','We need two ___ for the new office.','우리는 새 사무실에 책상 두 개가 필요하다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-041');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-041'),'A','desks','책상 두 개라는 복수형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-041') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-041'),'B','desk','단수형이라 two와 맞지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-041') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-041'),'C','desking','이 문맥의 책상 복수형이 아니에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-041') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-041'),'D','desked','이 문맥의 책상 복수형이 아니에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-041') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-041'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-041') AND option_key='A'),'two 뒤에는 셀 수 있는 명사의 복수형 desks를 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-041'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-042',(SELECT id FROM grammar_lesson WHERE code='objects'),'PART5',1,'objects','There are three ___ in the room.','방에 상자 세 개가 있다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-042');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-042'),'A','box','하나를 나타내는 단수형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-042') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-042'),'B','boxs','올바른 복수 철자는 boxes예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-042') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-042'),'C','boxing','권투 또는 동사형으로 상자 세 개가 아니에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-042') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-042'),'D','boxes','box의 복수형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-042') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-042'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-042') AND option_key='D'),'box는 -es를 붙여 boxes가 돼요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-042'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-043',(SELECT id FROM grammar_lesson WHERE code='objects'),'PART5',1,'objects','The manager gave me some ___. “정보”에 해당하는 말을 고르세요.','관리자는 나에게 정보를 좀 주었다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-043');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-043'),'A','inform','알리다라는 동사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-043') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-043'),'B','informative','유익한이라는 형용사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-043') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-043'),'C','information','some information으로 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-043') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-043'),'D','informations','보통 information에 복수 -s를 붙이지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-043') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-043'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-043') AND option_key='C'),'information은 셀 수 없는 명사여서 보통 -s를 붙이지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-043'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-044',(SELECT id FROM grammar_lesson WHERE code='objects'),'PART5',1,'objects','He is a ___. “의사”에 해당하는 말을 고르세요.','그는 의사이다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-044');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-044'),'A','medicine','의약품 또는 의학이라는 뜻이라 의사라는 뜻이 아니에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-044') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-044'),'B','doctor','a 뒤에 오는 단수 직업 명사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-044') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-044'),'C','doctors','a는 단수 명사를 요구해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-044') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-044'),'D','medical','의학의라는 형용사로 이 명사 자리를 채우지 못해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-044') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-044'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-044') AND option_key='B'),'주어 He가 누구인지 설명하는 명사 doctor가 보어예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-044'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-045',(SELECT id FROM grammar_lesson WHERE code='objects'),'PART5',1,'objects','The new employee is ___. “친절하다”가 되도록 고르세요.','새 직원은 친절하다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-045');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-045'),'A','kind','친절한이라는 형용사 보어예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-045') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-045'),'B','kindly','이 문맥에서는 친절하게라는 부사라 성질을 설명하는 보어로 맞지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-045') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-045'),'C','kindness','친절이라는 명사로 그 직원이 친절 그 자체라는 뜻은 자연스럽지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-045') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-045'),'D','kinds','종류들이라는 복수 명사예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-045') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-045'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-045') AND option_key='A'),'be동사 뒤에서 직원의 상태·성질을 설명하는 kind예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-045'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-046',(SELECT id FROM grammar_lesson WHERE code='parts'),'PART5',1,'parts','Please bring a pen ___ a notebook. “그리고”가 되도록 고르세요.','펜과 공책을 가져와 주세요.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-046');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-046'),'A','but','하지만이라는 반대 관계예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-046') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-046'),'B','because','이유를 나타내며 뒤에 문장이 필요해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-046') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-046'),'C','although','비록 ~이지만이라는 양보 관계예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-046') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-046'),'D','and','펜과 공책을 연결해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-046') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-046'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-046') AND option_key='D'),'두 물건을 나란히 연결할 때 and를 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-046'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-047',(SELECT id FROM grammar_lesson WHERE code='parts'),'PART5',1,'parts','I stayed home ___ I was sick.','나는 아파서 집에 있었다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-047');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-047'),'A','or','선택 관계예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-047') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-047'),'B','although','아픈데도라는 반대 방향 의미가 되어 이 번역과 달라요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-047') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-047'),'C','because','이유를 나타내요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-047') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-047'),'D','but','대조 관계예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-047') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-047'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-047') AND option_key='C'),'뒤 문장이 집에 머문 이유이므로 because예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-047'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-048',(SELECT id FROM grammar_lesson WHERE code='modifiers'),'PART5',1,'modifiers','The train is ___ than the bus.','기차는 버스보다 더 빠르다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-048');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-048'),'A','fastly','보통 쓰지 않는 형태예요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-048') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-048'),'B','faster','더 빠른이라는 비교급이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-048') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-048'),'C','fast','비교급 모양이 아니에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-048') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-048'),'D','fastest','가장 빠른이라는 최상급이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-048') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-048'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-048') AND option_key='B'),'than과 비교할 때 fast의 비교급 faster를 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-048'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-049',(SELECT id FROM grammar_lesson WHERE code='verbs'),'PART5',1,'verbs','You can ___ the form online.','당신은 온라인으로 양식을 작성할 수 있다.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-049');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-049'),'A','complete','조동사 뒤의 원형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-049') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-049'),'B','completes','단수 현재형을 쓰지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-049') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-049'),'C','completed','과거형을 쓰지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-049') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-049'),'D','completing','-ing형을 쓰지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-049') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-049'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-049') AND option_key='A'),'can 뒤에는 동사원형 complete를 써요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-049'));
INSERT INTO question (code,lesson_id,kind,difficulty,grammar_type,prompt,translation,revision,active,created_at,updated_at,version)
SELECT 'part5-050',(SELECT id FROM grammar_lesson WHERE code='verbs'),'PART5',1,'verbs','Please ___ the door.','문을 닫아 주세요.',1,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question WHERE code='part5-050');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-050'),'A','closes','주어가 있는 3인칭 현재형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-050') AND option_key='A');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-050'),'B','closed','이 명령문에 과거형을 쓰지 않아요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-050') AND option_key='B');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-050'),'C','closing','이 자리에서 혼자 명령을 만들지 못해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-050') AND option_key='C');
INSERT INTO question_option (question_id,option_key,content,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-050'),'D','close','명령문에 맞는 원형이에요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-050') AND option_key='D');
INSERT INTO question_answer (question_id,correct_option_id,explanation,created_at,updated_at,version)
SELECT (SELECT id FROM question WHERE code='part5-050'),(SELECT id FROM question_option WHERE question_id=(SELECT id FROM question WHERE code='part5-050') AND option_key='D'),'Please 뒤의 명령문은 동사원형 close로 시작해요.',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM question_answer WHERE question_id=(SELECT id FROM question WHERE code='part5-050'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-001','I','대명사','나(는)','I work here.','나는 여기서 일한다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-001' OR (word='I' AND part_of_speech='대명사' AND meaning='나(는)'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-002','you','대명사','너, 당신','You are ready.','당신은 준비가 되었다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-002' OR (word='you' AND part_of_speech='대명사' AND meaning='너, 당신'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-003','he','대명사','그(는)','He is kind.','그는 친절하다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-003' OR (word='he' AND part_of_speech='대명사' AND meaning='그(는)'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-004','she','대명사','그녀(는)','She reads every day.','그녀는 매일 읽는다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-004' OR (word='she' AND part_of_speech='대명사' AND meaning='그녀(는)'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-005','it','대명사','그것(은)','It is new.','그것은 새것이다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-005' OR (word='it' AND part_of_speech='대명사' AND meaning='그것(은)'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-006','we','대명사','우리(는)','We study English.','우리는 영어를 공부한다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-006' OR (word='we' AND part_of_speech='대명사' AND meaning='우리(는)'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-007','they','대명사','그들(은), 그것들(은)','They work together.','그들은 함께 일한다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-007' OR (word='they' AND part_of_speech='대명사' AND meaning='그들(은), 그것들(은)'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-008','my','한정사','나의','This is my desk.','이것은 나의 책상이다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-008' OR (word='my' AND part_of_speech='한정사' AND meaning='나의'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-009','your','한정사','너의, 당신의','Your bag is here.','당신의 가방은 여기에 있다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-009' OR (word='your' AND part_of_speech='한정사' AND meaning='너의, 당신의'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-010','our','한정사','우리의','Our office is clean.','우리 사무실은 깨끗하다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-010' OR (word='our' AND part_of_speech='한정사' AND meaning='우리의'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-011','person','명사','사람','One person is waiting.','한 사람이 기다리고 있다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-011' OR (word='person' AND part_of_speech='명사' AND meaning='사람'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-012','people','명사','사람들','People are waiting outside.','사람들이 밖에서 기다리고 있다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-012' OR (word='people' AND part_of_speech='명사' AND meaning='사람들'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-013','man','명사','남자','The man is a teacher.','그 남자는 선생님이다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-013' OR (word='man' AND part_of_speech='명사' AND meaning='남자'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-014','woman','명사','여자','The woman is a doctor.','그 여자는 의사이다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-014' OR (word='woman' AND part_of_speech='명사' AND meaning='여자'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-015','child','명사','아이','The child is happy.','그 아이는 행복하다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-015' OR (word='child' AND part_of_speech='명사' AND meaning='아이'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-016','friend','명사','친구','My friend is here.','내 친구가 여기에 있다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-016' OR (word='friend' AND part_of_speech='명사' AND meaning='친구'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-017','family','명사','가족','My family lives here.','우리 가족은 여기에 산다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-017' OR (word='family' AND part_of_speech='명사' AND meaning='가족'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-018','name','명사','이름','Please write your name.','이름을 써 주세요.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-018' OR (word='name' AND part_of_speech='명사' AND meaning='이름'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-019','student','명사','학생','I am a student.','나는 학생이다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-019' OR (word='student' AND part_of_speech='명사' AND meaning='학생'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-020','teacher','명사','선생님','The teacher speaks slowly.','선생님은 천천히 말한다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-020' OR (word='teacher' AND part_of_speech='명사' AND meaning='선생님'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-021','office','명사','사무실','The office is quiet.','사무실은 조용하다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-021' OR (word='office' AND part_of_speech='명사' AND meaning='사무실'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-022','company','명사','회사','Our company is small.','우리 회사는 작다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-022' OR (word='company' AND part_of_speech='명사' AND meaning='회사'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-023','employee','명사','직원','The employee is ready.','그 직원은 준비가 되었다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-023' OR (word='employee' AND part_of_speech='명사' AND meaning='직원'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-024','manager','명사','관리자','The manager is busy.','관리자는 바쁘다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-024' OR (word='manager' AND part_of_speech='명사' AND meaning='관리자'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-025','colleague','명사','동료','My colleague helps me.','내 동료는 나를 도와준다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-025' OR (word='colleague' AND part_of_speech='명사' AND meaning='동료'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-026','customer','명사','고객','The customer needs help.','고객은 도움이 필요하다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-026' OR (word='customer' AND part_of_speech='명사' AND meaning='고객'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-027','client','명사','의뢰인, 고객','The client called today.','고객이 오늘 전화했다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-027' OR (word='client' AND part_of_speech='명사' AND meaning='의뢰인, 고객'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-028','staff','명사','직원들','Our staff are friendly.','우리 직원들은 친절하다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-028' OR (word='staff' AND part_of_speech='명사' AND meaning='직원들'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-029','department','명사','부서','Our department is small.','우리 부서는 작다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-029' OR (word='department' AND part_of_speech='명사' AND meaning='부서'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-030','team','명사','팀','The team works hard.','팀은 열심히 일한다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-030' OR (word='team' AND part_of_speech='명사' AND meaning='팀'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-031','meeting','명사','회의','The meeting starts at nine.','회의는 9시에 시작한다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-031' OR (word='meeting' AND part_of_speech='명사' AND meaning='회의'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-032','schedule','명사','일정','Please check the schedule.','일정을 확인해 주세요.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-032' OR (word='schedule' AND part_of_speech='명사' AND meaning='일정'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-033','appointment','명사','약속, 예약','I have an appointment today.','나는 오늘 약속이 있다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-033' OR (word='appointment' AND part_of_speech='명사' AND meaning='약속, 예약'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-034','report','명사','보고서','She writes a report.','그녀는 보고서를 쓴다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-034' OR (word='report' AND part_of_speech='명사' AND meaning='보고서'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-035','document','명사','문서','Please read this document.','이 문서를 읽어 주세요.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-035' OR (word='document' AND part_of_speech='명사' AND meaning='문서'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-036','file','명사','파일, 서류','The file is on the desk.','파일은 책상 위에 있다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-036' OR (word='file' AND part_of_speech='명사' AND meaning='파일, 서류'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-037','form','명사','양식','Please complete this form.','이 양식을 작성해 주세요.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-037' OR (word='form' AND part_of_speech='명사' AND meaning='양식'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-038','email','명사','이메일','I sent an email.','나는 이메일을 보냈다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-038' OR (word='email' AND part_of_speech='명사' AND meaning='이메일'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-039','message','명사','메시지','Please read my message.','내 메시지를 읽어 주세요.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-039' OR (word='message' AND part_of_speech='명사' AND meaning='메시지'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-040','letter','명사','편지','The letter arrived today.','편지가 오늘 도착했다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-040' OR (word='letter' AND part_of_speech='명사' AND meaning='편지'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-041','desk','명사','책상','My desk is clean.','내 책상은 깨끗하다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-041' OR (word='desk' AND part_of_speech='명사' AND meaning='책상'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-042','chair','명사','의자','This chair is comfortable.','이 의자는 편안하다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-042' OR (word='chair' AND part_of_speech='명사' AND meaning='의자'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-043','table','명사','탁자','The table is large.','탁자는 크다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-043' OR (word='table' AND part_of_speech='명사' AND meaning='탁자'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-044','computer','명사','컴퓨터','The computer works well.','컴퓨터는 잘 작동한다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-044' OR (word='computer' AND part_of_speech='명사' AND meaning='컴퓨터'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-045','printer','명사','프린터','The printer is new.','프린터는 새것이다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-045' OR (word='printer' AND part_of_speech='명사' AND meaning='프린터'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-046','phone','명사','전화기','My phone is on the desk.','내 전화기는 책상 위에 있다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-046' OR (word='phone' AND part_of_speech='명사' AND meaning='전화기'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-047','screen','명사','화면','The screen is bright.','화면이 밝다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-047' OR (word='screen' AND part_of_speech='명사' AND meaning='화면'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-048','keyboard','명사','키보드','The keyboard is black.','키보드는 검은색이다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-048' OR (word='keyboard' AND part_of_speech='명사' AND meaning='키보드'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-049','paper','명사','종이','We need more paper.','우리는 종이가 더 필요하다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-049' OR (word='paper' AND part_of_speech='명사' AND meaning='종이'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-050','pen','명사','펜','Please bring a pen.','펜을 가져와 주세요.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-050' OR (word='pen' AND part_of_speech='명사' AND meaning='펜'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-051','book','명사','책','I read a book.','나는 책을 읽는다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-051' OR (word='book' AND part_of_speech='명사' AND meaning='책'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-052','notebook','명사','공책','This is my notebook.','이것은 나의 공책이다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-052' OR (word='notebook' AND part_of_speech='명사' AND meaning='공책'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-053','bag','명사','가방','My bag is heavy.','내 가방은 무겁다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-053' OR (word='bag' AND part_of_speech='명사' AND meaning='가방'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-054','box','명사','상자','The box is empty.','상자는 비어 있다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-054' OR (word='box' AND part_of_speech='명사' AND meaning='상자'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-055','key','명사','열쇠','I found my key.','나는 내 열쇠를 찾았다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-055' OR (word='key' AND part_of_speech='명사' AND meaning='열쇠'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-056','door','명사','문','Please close the door.','문을 닫아 주세요.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-056' OR (word='door' AND part_of_speech='명사' AND meaning='문'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-057','window','명사','창문','The window is open.','창문은 열려 있다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-057' OR (word='window' AND part_of_speech='명사' AND meaning='창문'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-058','room','명사','방','The room is clean.','방은 깨끗하다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-058' OR (word='room' AND part_of_speech='명사' AND meaning='방'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-059','building','명사','건물','The building is tall.','건물은 높다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-059' OR (word='building' AND part_of_speech='명사' AND meaning='건물'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-060','floor','명사','층','Our office is on the second floor.','우리 사무실은 2층에 있다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-060' OR (word='floor' AND part_of_speech='명사' AND meaning='층'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-061','time','명사','시간','We have enough time.','우리는 시간이 충분하다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-061' OR (word='time' AND part_of_speech='명사' AND meaning='시간'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-062','day','명사','날, 하루','Have a good day.','좋은 하루 보내세요.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-062' OR (word='day' AND part_of_speech='명사' AND meaning='날, 하루'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-063','week','명사','주, 일주일','The course starts next week.','강좌는 다음 주에 시작한다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-063' OR (word='week' AND part_of_speech='명사' AND meaning='주, 일주일'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-064','month','명사','월, 한 달','The project ends this month.','프로젝트는 이번 달에 끝난다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-064' OR (word='month' AND part_of_speech='명사' AND meaning='월, 한 달'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-065','year','명사','년, 한 해','I moved here last year.','나는 작년에 여기로 이사했다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-065' OR (word='year' AND part_of_speech='명사' AND meaning='년, 한 해'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-066','morning','명사','아침','I study in the morning.','나는 아침에 공부한다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-066' OR (word='morning' AND part_of_speech='명사' AND meaning='아침'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-067','afternoon','명사','오후','We have a meeting this afternoon.','우리는 오늘 오후에 회의가 있다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-067' OR (word='afternoon' AND part_of_speech='명사' AND meaning='오후'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-068','evening','명사','저녁','I read in the evening.','나는 저녁에 읽는다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-068' OR (word='evening' AND part_of_speech='명사' AND meaning='저녁'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-069','today','부사','오늘','I am busy today.','나는 오늘 바쁘다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-069' OR (word='today' AND part_of_speech='부사' AND meaning='오늘'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-070','tomorrow','부사','내일','She will arrive tomorrow.','그녀는 내일 도착할 것이다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-070' OR (word='tomorrow' AND part_of_speech='부사' AND meaning='내일'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-071','yesterday','부사','어제','We worked yesterday.','우리는 어제 일했다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-071' OR (word='yesterday' AND part_of_speech='부사' AND meaning='어제'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-072','now','부사','지금','Please start now.','지금 시작해 주세요.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-072' OR (word='now' AND part_of_speech='부사' AND meaning='지금'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-073','early','부사','일찍','He arrived early.','그는 일찍 도착했다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-073' OR (word='early' AND part_of_speech='부사' AND meaning='일찍'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-074','late','부사','늦게','She arrived late.','그녀는 늦게 도착했다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-074' OR (word='late' AND part_of_speech='부사' AND meaning='늦게'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-075','soon','부사','곧','The bus will arrive soon.','버스는 곧 도착할 것이다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-075' OR (word='soon' AND part_of_speech='부사' AND meaning='곧'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-076','always','부사','항상','He always checks the schedule.','그는 항상 일정을 확인한다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-076' OR (word='always' AND part_of_speech='부사' AND meaning='항상'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-077','usually','부사','보통','I usually walk to work.','나는 보통 걸어서 출근한다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-077' OR (word='usually' AND part_of_speech='부사' AND meaning='보통'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-078','often','부사','자주','We often meet here.','우리는 여기서 자주 만난다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-078' OR (word='often' AND part_of_speech='부사' AND meaning='자주'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-079','sometimes','부사','때때로','She sometimes works at home.','그녀는 때때로 집에서 일한다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-079' OR (word='sometimes' AND part_of_speech='부사' AND meaning='때때로'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-080','never','부사','절대 ~않다','I never work on Sundays.','나는 일요일에는 절대 일하지 않는다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-080' OR (word='never' AND part_of_speech='부사' AND meaning='절대 ~않다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-081','work','동사','일하다','I work in an office.','나는 사무실에서 일한다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-081' OR (word='work' AND part_of_speech='동사' AND meaning='일하다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-082','study','동사','공부하다','We study together.','우리는 함께 공부한다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-082' OR (word='study' AND part_of_speech='동사' AND meaning='공부하다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-083','read','동사','읽다','Please read this email.','이 이메일을 읽어 주세요.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-083' OR (word='read' AND part_of_speech='동사' AND meaning='읽다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-084','write','동사','쓰다','She writes clearly.','그녀는 명확하게 쓴다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-084' OR (word='write' AND part_of_speech='동사' AND meaning='쓰다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-085','speak','동사','말하다','Please speak slowly.','천천히 말해 주세요.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-085' OR (word='speak' AND part_of_speech='동사' AND meaning='말하다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-086','listen','동사','듣다','Please listen carefully.','주의 깊게 들어 주세요.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-086' OR (word='listen' AND part_of_speech='동사' AND meaning='듣다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-087','learn','동사','배우다','I learn new words every day.','나는 매일 새 단어를 배운다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-087' OR (word='learn' AND part_of_speech='동사' AND meaning='배우다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-088','teach','동사','가르치다','She teaches English.','그녀는 영어를 가르친다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-088' OR (word='teach' AND part_of_speech='동사' AND meaning='가르치다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-089','know','동사','알다','I know the answer.','나는 답을 안다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-089' OR (word='know' AND part_of_speech='동사' AND meaning='알다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-090','understand','동사','이해하다','I understand the question.','나는 질문을 이해한다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-090' OR (word='understand' AND part_of_speech='동사' AND meaning='이해하다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-091','ask','동사','묻다','Please ask a question.','질문해 주세요.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-091' OR (word='ask' AND part_of_speech='동사' AND meaning='묻다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-092','answer','동사','대답하다','Please answer the phone.','전화를 받아 주세요.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-092' OR (word='answer' AND part_of_speech='동사' AND meaning='대답하다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-093','help','동사','돕다','We help our customers.','우리는 고객들을 돕는다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-093' OR (word='help' AND part_of_speech='동사' AND meaning='돕다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-094','need','동사','필요로 하다','I need a pen.','나는 펜이 필요하다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-094' OR (word='need' AND part_of_speech='동사' AND meaning='필요로 하다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-095','want','동사','원하다','I want some water.','나는 물을 좀 원한다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-095' OR (word='want' AND part_of_speech='동사' AND meaning='원하다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-096','like','동사','좋아하다','She likes coffee.','그녀는 커피를 좋아한다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-096' OR (word='like' AND part_of_speech='동사' AND meaning='좋아하다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-097','have','동사','가지다, 있다','We have a meeting today.','우리는 오늘 회의가 있다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-097' OR (word='have' AND part_of_speech='동사' AND meaning='가지다, 있다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-098','make','동사','만들다','They make chairs.','그들은 의자를 만든다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-098' OR (word='make' AND part_of_speech='동사' AND meaning='만들다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-099','do','동사','하다','I do my work carefully.','나는 내 일을 주의 깊게 한다.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-099' OR (word='do' AND part_of_speech='동사' AND meaning='하다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-100','use','동사','사용하다','Please use this computer.','이 컴퓨터를 사용해 주세요.',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-100' OR (word='use' AND part_of_speech='동사' AND meaning='사용하다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-101','go','동사','가다','I go to work by bus.','나는 버스로 출근한다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-101' OR (word='go' AND part_of_speech='동사' AND meaning='가다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-102','come','동사','오다','Please come to the office.','사무실로 와 주세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-102' OR (word='come' AND part_of_speech='동사' AND meaning='오다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-103','arrive','동사','도착하다','The train arrives at noon.','기차는 정오에 도착한다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-103' OR (word='arrive' AND part_of_speech='동사' AND meaning='도착하다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-104','leave','동사','떠나다','We leave at five.','우리는 5시에 떠난다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-104' OR (word='leave' AND part_of_speech='동사' AND meaning='떠나다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-105','visit','동사','방문하다','We visit the client tomorrow.','우리는 내일 고객을 방문한다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-105' OR (word='visit' AND part_of_speech='동사' AND meaning='방문하다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-106','travel','동사','여행하다','I travel by train.','나는 기차로 여행한다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-106' OR (word='travel' AND part_of_speech='동사' AND meaning='여행하다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-107','walk','동사','걷다','She walks to work.','그녀는 걸어서 출근한다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-107' OR (word='walk' AND part_of_speech='동사' AND meaning='걷다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-108','drive','동사','운전하다','He drives carefully.','그는 주의 깊게 운전한다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-108' OR (word='drive' AND part_of_speech='동사' AND meaning='운전하다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-109','bring','동사','가져오다','Please bring your notebook.','공책을 가져와 주세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-109' OR (word='bring' AND part_of_speech='동사' AND meaning='가져오다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-110','send','동사','보내다','Please send the report.','보고서를 보내 주세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-110' OR (word='send' AND part_of_speech='동사' AND meaning='보내다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-111','receive','동사','받다','We receive emails every day.','우리는 매일 이메일을 받는다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-111' OR (word='receive' AND part_of_speech='동사' AND meaning='받다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-112','buy','동사','사다','I buy lunch here.','나는 여기서 점심을 산다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-112' OR (word='buy' AND part_of_speech='동사' AND meaning='사다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-113','sell','동사','팔다','The store sells books.','그 가게는 책을 판다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-113' OR (word='sell' AND part_of_speech='동사' AND meaning='팔다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-114','pay','동사','지불하다','I pay by card.','나는 카드로 지불한다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-114' OR (word='pay' AND part_of_speech='동사' AND meaning='지불하다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-115','cost','동사','비용이 들다','This pen costs two dollars.','이 펜은 2달러이다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-115' OR (word='cost' AND part_of_speech='동사' AND meaning='비용이 들다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-116','order','동사','주문하다','We order lunch online.','우리는 온라인으로 점심을 주문한다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-116' OR (word='order' AND part_of_speech='동사' AND meaning='주문하다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-117','open','동사','열다','Please open the window.','창문을 열어 주세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-117' OR (word='open' AND part_of_speech='동사' AND meaning='열다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-118','close','동사','닫다','Please close the door.','문을 닫아 주세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-118' OR (word='close' AND part_of_speech='동사' AND meaning='닫다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-119','start','동사','시작하다','The class starts at ten.','수업은 10시에 시작한다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-119' OR (word='start' AND part_of_speech='동사' AND meaning='시작하다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-120','finish','동사','끝내다','I finish work at six.','나는 6시에 일을 끝낸다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-120' OR (word='finish' AND part_of_speech='동사' AND meaning='끝내다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-121','check','동사','확인하다','Please check your email.','이메일을 확인해 주세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-121' OR (word='check' AND part_of_speech='동사' AND meaning='확인하다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-122','change','동사','바꾸다','We changed the schedule.','우리는 일정을 바꿨다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-122' OR (word='change' AND part_of_speech='동사' AND meaning='바꾸다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-123','prepare','동사','준비하다','Please prepare the documents.','문서를 준비해 주세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-123' OR (word='prepare' AND part_of_speech='동사' AND meaning='준비하다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-124','complete','동사','완료하다, 작성하다','Please complete this form.','이 양식을 작성해 주세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-124' OR (word='complete' AND part_of_speech='동사' AND meaning='완료하다, 작성하다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-125','wait','동사','기다리다','Please wait here.','여기서 기다려 주세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-125' OR (word='wait' AND part_of_speech='동사' AND meaning='기다리다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-126','call','동사','전화하다','Please call me tomorrow.','내일 나에게 전화해 주세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-126' OR (word='call' AND part_of_speech='동사' AND meaning='전화하다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-127','meet','동사','만나다','We meet every Monday.','우리는 매주 월요일에 만난다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-127' OR (word='meet' AND part_of_speech='동사' AND meaning='만나다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-128','find','동사','찾다','I cannot find my key.','나는 내 열쇠를 찾을 수 없다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-128' OR (word='find' AND part_of_speech='동사' AND meaning='찾다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-129','keep','동사','보관하다, 유지하다','Please keep this receipt.','이 영수증을 보관해 주세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-129' OR (word='keep' AND part_of_speech='동사' AND meaning='보관하다, 유지하다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-130','remember','동사','기억하다','I remember your name.','나는 당신의 이름을 기억한다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-130' OR (word='remember' AND part_of_speech='동사' AND meaning='기억하다'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-131','good','형용사','좋은','This is a good idea.','이것은 좋은 생각이다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-131' OR (word='good' AND part_of_speech='형용사' AND meaning='좋은'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-132','bad','형용사','나쁜','The weather is bad today.','오늘 날씨가 나쁘다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-132' OR (word='bad' AND part_of_speech='형용사' AND meaning='나쁜'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-133','new','형용사','새로운','This is a new printer.','이것은 새 프린터이다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-133' OR (word='new' AND part_of_speech='형용사' AND meaning='새로운'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-134','old','형용사','오래된','The building is old.','그 건물은 오래되었다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-134' OR (word='old' AND part_of_speech='형용사' AND meaning='오래된'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-135','big','형용사','큰','We need a big table.','우리는 큰 탁자가 필요하다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-135' OR (word='big' AND part_of_speech='형용사' AND meaning='큰'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-136','small','형용사','작은','Our office is small.','우리 사무실은 작다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-136' OR (word='small' AND part_of_speech='형용사' AND meaning='작은'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-137','long','형용사','긴','The meeting was long.','회의가 길었다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-137' OR (word='long' AND part_of_speech='형용사' AND meaning='긴'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-138','short','형용사','짧은','This is a short message.','이것은 짧은 메시지이다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-138' OR (word='short' AND part_of_speech='형용사' AND meaning='짧은'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-139','easy','형용사','쉬운','This question is easy.','이 문제는 쉽다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-139' OR (word='easy' AND part_of_speech='형용사' AND meaning='쉬운'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-140','difficult','형용사','어려운','The test is difficult.','그 시험은 어렵다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-140' OR (word='difficult' AND part_of_speech='형용사' AND meaning='어려운'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-141','important','형용사','중요한','This report is important.','이 보고서는 중요하다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-141' OR (word='important' AND part_of_speech='형용사' AND meaning='중요한'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-142','busy','형용사','바쁜','I am busy today.','나는 오늘 바쁘다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-142' OR (word='busy' AND part_of_speech='형용사' AND meaning='바쁜'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-143','ready','형용사','준비된','We are ready now.','우리는 이제 준비가 되었다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-143' OR (word='ready' AND part_of_speech='형용사' AND meaning='준비된'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-144','available','형용사','이용 가능한, 시간이 되는','The room is available.','그 방은 이용 가능하다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-144' OR (word='available' AND part_of_speech='형용사' AND meaning='이용 가능한, 시간이 되는'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-145','clean','형용사','깨끗한','The desk is clean.','책상은 깨끗하다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-145' OR (word='clean' AND part_of_speech='형용사' AND meaning='깨끗한'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-146','quiet','형용사','조용한','The office is quiet.','사무실은 조용하다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-146' OR (word='quiet' AND part_of_speech='형용사' AND meaning='조용한'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-147','safe','형용사','안전한','This area is safe.','이 지역은 안전하다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-147' OR (word='safe' AND part_of_speech='형용사' AND meaning='안전한'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-148','careful','형용사','주의 깊은','He is a careful driver.','그는 주의 깊은 운전자이다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-148' OR (word='careful' AND part_of_speech='형용사' AND meaning='주의 깊은'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-149','clear','형용사','명확한','The instructions are clear.','설명은 명확하다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-149' OR (word='clear' AND part_of_speech='형용사' AND meaning='명확한'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-150','friendly','형용사','친절한','The staff are friendly.','직원들은 친절하다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-150' OR (word='friendly' AND part_of_speech='형용사' AND meaning='친절한'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-151','quickly','부사','빨리','She works quickly.','그녀는 빨리 일한다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-151' OR (word='quickly' AND part_of_speech='부사' AND meaning='빨리'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-152','slowly','부사','천천히','Please speak slowly.','천천히 말해 주세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-152' OR (word='slowly' AND part_of_speech='부사' AND meaning='천천히'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-153','carefully','부사','주의 깊게','Read the report carefully.','보고서를 주의 깊게 읽으세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-153' OR (word='carefully' AND part_of_speech='부사' AND meaning='주의 깊게'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-154','clearly','부사','명확하게','Please write clearly.','명확하게 써 주세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-154' OR (word='clearly' AND part_of_speech='부사' AND meaning='명확하게'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-155','well','부사','잘','The printer works well.','프린터는 잘 작동한다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-155' OR (word='well' AND part_of_speech='부사' AND meaning='잘'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-156','together','부사','함께','We work together.','우리는 함께 일한다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-156' OR (word='together' AND part_of_speech='부사' AND meaning='함께'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-157','here','부사','여기에','Please wait here.','여기서 기다려 주세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-157' OR (word='here' AND part_of_speech='부사' AND meaning='여기에'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-158','there','부사','거기에','The bus stop is there.','버스 정류장은 거기에 있다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-158' OR (word='there' AND part_of_speech='부사' AND meaning='거기에'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-159','inside','부사','안으로, 안에','Please wait inside.','안에서 기다려 주세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-159' OR (word='inside' AND part_of_speech='부사' AND meaning='안으로, 안에'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-160','outside','부사','밖에','The car is outside.','차는 밖에 있다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-160' OR (word='outside' AND part_of_speech='부사' AND meaning='밖에'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-161','food','명사','음식','The food is good.','음식은 좋다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-161' OR (word='food' AND part_of_speech='명사' AND meaning='음식'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-162','water','명사','물','I need some water.','나는 물이 좀 필요하다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-162' OR (word='water' AND part_of_speech='명사' AND meaning='물'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-163','coffee','명사','커피','She likes coffee.','그녀는 커피를 좋아한다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-163' OR (word='coffee' AND part_of_speech='명사' AND meaning='커피'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-164','lunch','명사','점심','We have lunch at noon.','우리는 정오에 점심을 먹는다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-164' OR (word='lunch' AND part_of_speech='명사' AND meaning='점심'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-165','breakfast','명사','아침 식사','I eat breakfast at seven.','나는 7시에 아침을 먹는다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-165' OR (word='breakfast' AND part_of_speech='명사' AND meaning='아침 식사'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-166','dinner','명사','저녁 식사','We have dinner at home.','우리는 집에서 저녁을 먹는다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-166' OR (word='dinner' AND part_of_speech='명사' AND meaning='저녁 식사'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-167','restaurant','명사','식당','The restaurant is near the office.','식당은 사무실 근처에 있다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-167' OR (word='restaurant' AND part_of_speech='명사' AND meaning='식당'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-168','store','명사','가게','The store opens at nine.','가게는 9시에 문을 연다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-168' OR (word='store' AND part_of_speech='명사' AND meaning='가게'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-169','hotel','명사','호텔','The hotel is clean.','호텔은 깨끗하다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-169' OR (word='hotel' AND part_of_speech='명사' AND meaning='호텔'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-170','reservation','명사','예약','I have a reservation.','나는 예약을 했다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-170' OR (word='reservation' AND part_of_speech='명사' AND meaning='예약'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-171','bus','명사','버스','The bus is late.','버스가 늦다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-171' OR (word='bus' AND part_of_speech='명사' AND meaning='버스'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-172','train','명사','기차','The train arrives soon.','기차가 곧 도착한다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-172' OR (word='train' AND part_of_speech='명사' AND meaning='기차'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-173','station','명사','역','The station is near here.','역은 여기 근처에 있다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-173' OR (word='station' AND part_of_speech='명사' AND meaning='역'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-174','airport','명사','공항','We arrived at the airport.','우리는 공항에 도착했다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-174' OR (word='airport' AND part_of_speech='명사' AND meaning='공항'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-175','ticket','명사','표','Please keep your ticket.','표를 보관해 주세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-175' OR (word='ticket' AND part_of_speech='명사' AND meaning='표'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-176','price','명사','가격','The price is low.','가격이 낮다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-176' OR (word='price' AND part_of_speech='명사' AND meaning='가격'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-177','receipt','명사','영수증','Please keep the receipt.','영수증을 보관해 주세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-177' OR (word='receipt' AND part_of_speech='명사' AND meaning='영수증'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-178','bill','명사','청구서','Please check the bill.','청구서를 확인해 주세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-178' OR (word='bill' AND part_of_speech='명사' AND meaning='청구서'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-179','money','명사','돈','We need more money.','우리는 돈이 더 필요하다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-179' OR (word='money' AND part_of_speech='명사' AND meaning='돈'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-180','bank','명사','은행','The bank is open.','은행은 영업 중이다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-180' OR (word='bank' AND part_of_speech='명사' AND meaning='은행'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-181','job','명사','직업, 일자리','She has a new job.','그녀는 새 직장이 있다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-181' OR (word='job' AND part_of_speech='명사' AND meaning='직업, 일자리'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-182','task','명사','과제, 업무','Please finish this task.','이 업무를 끝내 주세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-182' OR (word='task' AND part_of_speech='명사' AND meaning='과제, 업무'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-183','project','명사','프로젝트','The project starts today.','프로젝트는 오늘 시작한다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-183' OR (word='project' AND part_of_speech='명사' AND meaning='프로젝트'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-184','plan','명사','계획','We have a new plan.','우리는 새 계획이 있다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-184' OR (word='plan' AND part_of_speech='명사' AND meaning='계획'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-185','goal','명사','목표','My goal is to study every day.','내 목표는 매일 공부하는 것이다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-185' OR (word='goal' AND part_of_speech='명사' AND meaning='목표'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-186','question','명사','질문, 문제','I have a question.','나는 질문이 있다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-186' OR (word='question' AND part_of_speech='명사' AND meaning='질문, 문제'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-187','information','명사','정보','We need more information.','우리는 정보가 더 필요하다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-187' OR (word='information' AND part_of_speech='명사' AND meaning='정보'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-188','instruction','명사','지시, 설명','Please read each instruction.','각 지시 사항을 읽어 주세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-188' OR (word='instruction' AND part_of_speech='명사' AND meaning='지시, 설명'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-189','problem','명사','문제','We have a small problem.','우리는 작은 문제가 있다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-189' OR (word='problem' AND part_of_speech='명사' AND meaning='문제'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-190','solution','명사','해결책','We found a solution.','우리는 해결책을 찾았다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-190' OR (word='solution' AND part_of_speech='명사' AND meaning='해결책'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-191','application','명사','지원서, 신청서','Please send your application.','지원서를 보내 주세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-191' OR (word='application' AND part_of_speech='명사' AND meaning='지원서, 신청서'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-192','interview','명사','면접','My interview is tomorrow.','내 면접은 내일이다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-192' OR (word='interview' AND part_of_speech='명사' AND meaning='면접'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-193','experience','명사','경험','She has useful experience.','그녀는 유용한 경험이 있다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-193' OR (word='experience' AND part_of_speech='명사' AND meaning='경험'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-194','training','명사','교육, 훈련','The training starts today.','교육은 오늘 시작한다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-194' OR (word='training' AND part_of_speech='명사' AND meaning='교육, 훈련'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-195','salary','명사','급여','The salary is paid monthly.','급여는 매달 지급된다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-195' OR (word='salary' AND part_of_speech='명사' AND meaning='급여'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-196','deadline','명사','마감일','The deadline is Friday.','마감일은 금요일이다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-196' OR (word='deadline' AND part_of_speech='명사' AND meaning='마감일'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-197','equipment','명사','장비','The equipment is new.','그 장비는 새것이다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-197' OR (word='equipment' AND part_of_speech='명사' AND meaning='장비'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-198','delivery','명사','배송','The delivery arrived today.','배송 물품이 오늘 도착했다.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-198' OR (word='delivery' AND part_of_speech='명사' AND meaning='배송'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-199','invoice','명사','송장, 청구서','Please check this invoice.','이 청구서를 확인해 주세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-199' OR (word='invoice' AND part_of_speech='명사' AND meaning='송장, 청구서'));
INSERT INTO vocabulary (code,word,part_of_speech,meaning,example,translation,level,created_at,updated_at,version)
SELECT 'basic-200','confirm','동사','확인하다, 확정하다','Please confirm the date.','날짜를 확인해 주세요.',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM vocabulary WHERE code='basic-200' OR (word='confirm' AND part_of_speech='동사' AND meaning='확인하다, 확정하다'));
INSERT INTO level_test (code,title,active,created_at,updated_at,version)
SELECT 'foundation-v1','기초 문법 진단 (공식 TOEIC 점수 아님)',TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM level_test WHERE code='foundation-v1');
INSERT INTO level_test_question (test_id,question_id,sequence_no,created_at,updated_at,version)
SELECT (SELECT id FROM level_test WHERE code='foundation-v1'),(SELECT id FROM question WHERE code='practice-001'),1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM level_test_question WHERE test_id=(SELECT id FROM level_test WHERE code='foundation-v1') AND question_id=(SELECT id FROM question WHERE code='practice-001'));
INSERT INTO level_test_question (test_id,question_id,sequence_no,created_at,updated_at,version)
SELECT (SELECT id FROM level_test WHERE code='foundation-v1'),(SELECT id FROM question WHERE code='practice-003'),2,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM level_test_question WHERE test_id=(SELECT id FROM level_test WHERE code='foundation-v1') AND question_id=(SELECT id FROM question WHERE code='practice-003'));
INSERT INTO level_test_question (test_id,question_id,sequence_no,created_at,updated_at,version)
SELECT (SELECT id FROM level_test WHERE code='foundation-v1'),(SELECT id FROM question WHERE code='practice-005'),3,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM level_test_question WHERE test_id=(SELECT id FROM level_test WHERE code='foundation-v1') AND question_id=(SELECT id FROM question WHERE code='practice-005'));
INSERT INTO level_test_question (test_id,question_id,sequence_no,created_at,updated_at,version)
SELECT (SELECT id FROM level_test WHERE code='foundation-v1'),(SELECT id FROM question WHERE code='practice-007'),4,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM level_test_question WHERE test_id=(SELECT id FROM level_test WHERE code='foundation-v1') AND question_id=(SELECT id FROM question WHERE code='practice-007'));
INSERT INTO level_test_question (test_id,question_id,sequence_no,created_at,updated_at,version)
SELECT (SELECT id FROM level_test WHERE code='foundation-v1'),(SELECT id FROM question WHERE code='practice-009'),5,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM level_test_question WHERE test_id=(SELECT id FROM level_test WHERE code='foundation-v1') AND question_id=(SELECT id FROM question WHERE code='practice-009'));
INSERT INTO level_test_question (test_id,question_id,sequence_no,created_at,updated_at,version)
SELECT (SELECT id FROM level_test WHERE code='foundation-v1'),(SELECT id FROM question WHERE code='practice-011'),6,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM level_test_question WHERE test_id=(SELECT id FROM level_test WHERE code='foundation-v1') AND question_id=(SELECT id FROM question WHERE code='practice-011'));
INSERT INTO level_test_question (test_id,question_id,sequence_no,created_at,updated_at,version)
SELECT (SELECT id FROM level_test WHERE code='foundation-v1'),(SELECT id FROM question WHERE code='practice-013'),7,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM level_test_question WHERE test_id=(SELECT id FROM level_test WHERE code='foundation-v1') AND question_id=(SELECT id FROM question WHERE code='practice-013'));
INSERT INTO level_test_question (test_id,question_id,sequence_no,created_at,updated_at,version)
SELECT (SELECT id FROM level_test WHERE code='foundation-v1'),(SELECT id FROM question WHERE code='practice-015'),8,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM level_test_question WHERE test_id=(SELECT id FROM level_test WHERE code='foundation-v1') AND question_id=(SELECT id FROM question WHERE code='practice-015'));
INSERT INTO level_test_question (test_id,question_id,sequence_no,created_at,updated_at,version)
SELECT (SELECT id FROM level_test WHERE code='foundation-v1'),(SELECT id FROM question WHERE code='practice-017'),9,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM level_test_question WHERE test_id=(SELECT id FROM level_test WHERE code='foundation-v1') AND question_id=(SELECT id FROM question WHERE code='practice-017'));
INSERT INTO level_test_question (test_id,question_id,sequence_no,created_at,updated_at,version)
SELECT (SELECT id FROM level_test WHERE code='foundation-v1'),(SELECT id FROM question WHERE code='practice-019'),10,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0
WHERE NOT EXISTS (SELECT 1 FROM level_test_question WHERE test_id=(SELECT id FROM level_test WHERE code='foundation-v1') AND question_id=(SELECT id FROM question WHERE code='practice-019'));
