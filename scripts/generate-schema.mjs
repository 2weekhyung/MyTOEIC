// Declarative schema source. Run only when authoring a NEW migration; never regenerate an applied migration.
import fs from 'node:fs';
import path from 'node:path';
const root = path.resolve(import.meta.dirname, '..');
const write = (p, s) => { fs.mkdirSync(path.dirname(path.join(root,p)), {recursive:true}); fs.writeFileSync(path.join(root,p),s); };
// name, SQL type, Java type; relation columns become LAZY ManyToOne associations.
const s = (name, len=255, nullable=false) => ({name, sql:`varchar(${len})`, java:'String', nullable});
const n = (name, nullable=false) => ({name,sql:'integer',java:'Integer',nullable});
const b = name => ({name,sql:'boolean',java:'Boolean',nullable:false});
const t = (name,nullable=false) => ({name,sql:'datetime(6)',java:'LocalDateTime',nullable});
const d = (name,nullable=false) => ({name,sql:'date',java:'LocalDate',nullable});
const text = name => ({name,sql:'text',java:'String',nullable:false});
const fk = (name,target,nullable=false) => ({name,sql:'bigint',java:target,nullable,target});
const tables = [
 ['UserAccount','user_account','개인 관리자 계정. 삭제 대신 비활성화.',[s('username',80),s('passwordHash',100),b('active')],['username']],
 ['UserSetting','user_setting','사용자별 현재 설정. 과거 학습일은 이벤트에 고정.',[fk('user','UserAccount'),n('targetScore'),n('dailyMinutes'),s('timezone',60),n('learningLevel')],['user_id']],
 ['GrammarLesson','grammar_lesson','왕초보 강의 본문과 쉬운 재설명. code는 영구 식별자.',[s('code',60),s('title'),n('level'),n('sortOrder'),n('estimatedMinutes'),n('revision'),text('objective'),text('content'),text('easierExplanation'),text('summary')],['code']],
 ['GrammarExample','grammar_example','예문, 번역, 문장 성분 분석과 설명.',[fk('lesson','GrammarLesson'),n('sequenceNo'),s('sentence',1000),s('translation',1000),text('analysis'),text('explanation')],['lesson_id,sequence_no']],
 ['Question','question','직접 제작한 연습/Part 5 문제. 사용 중 문항은 비활성화로 보존.',[s('code',60),fk('lesson','GrammarLesson',true),s('kind',20),n('difficulty'),s('grammarType',60),text('prompt'),text('translation'),n('revision'),b('active')],['code']],
 ['QuestionOption','question_option','문제별 4지선다 및 선택지별 해설.',[fk('question','Question'),s('optionKey',1),s('content',1000),text('explanation')],['question_id,option_key','question_id,id']],
 ['QuestionAnswer','question_answer','정답과 전체 해설. 문제 조회 API에서는 공개하지 않음.',[fk('question','Question'),fk('correctOption','QuestionOption'),text('explanation')],['question_id']],
 ['Vocabulary','vocabulary','공용 기초 단어. 단어+품사+뜻으로 의미 구분.',[s('code',60),s('word',100),s('partOfSpeech',30),s('meaning',255),s('example',1000),s('translation',1000),n('level')],['code','word,part_of_speech,meaning']],
 ['LessonProgress','lesson_progress','강의별 현재 최대 진도. 원본 이력은 study event.',[fk('user','UserAccount'),fk('lesson','GrammarLesson'),n('percent'),t('completedAt',true)],['user_id,lesson_id']],
 ['LessonStudyEvent','lesson_study_event','강의 학습의 불변 누적 이벤트. 재전송 방지 키.',[fk('user','UserAccount'),fk('lesson','GrammarLesson'),n('percent'),n('elapsedSeconds'),d('learningDate'),s('requestKey',80)],['user_id,request_key']],
 ['LevelTest','level_test','비공식 기초 진단 시험 정의. 공식 TOEIC 환산 없음.',[s('code',60),s('title'),b('active')],['code']],
 ['LevelTestQuestion','level_test_question','진단 시험과 문제 연결 및 순서.',[fk('test','LevelTest'),fk('question','Question'),n('sequenceNo')],['test_id,question_id','test_id,sequence_no']],
 ['LevelTestRun','level_test_run','사용자별 진단 회차. 각 회차의 결과를 보존.',[fk('user','UserAccount'),fk('test','LevelTest'),s('status',20),t('completedAt',true),n('recommendedLevel',true),s('requestKey',80)],['user_id,request_key']],
 ['QuestionAttempt','question_attempt','문제 풀이 원본. 제출 당시 문항/정답 전체 스냅샷과 학습일 보존.',[fk('user','UserAccount'),fk('question','Question'),fk('selectedOption','QuestionOption'),fk('testRun','LevelTestRun',true),b('correct'),n('elapsedSeconds'),n('questionRevision'),text('questionSnapshot'),text('answerSnapshot'),d('learningDate'),s('requestKey',80)],['user_id,request_key','test_run_id,question_id']],
 ['UserVocabulary','user_vocabulary','개인 단어장. 외우기 상태 변경 시에도 암기 이벤트는 보존.',[fk('user','UserAccount'),fk('vocabulary','Vocabulary'),s('status',20)],['user_id,vocabulary_id']],
 ['WordReview','word_review','암기 결과 및 해당 시점 단어 정보의 누적 기록.',[fk('user','UserAccount'),fk('userVocabulary','UserVocabulary'),b('remembered'),n('elapsedSeconds'),text('wordSnapshot'),d('learningDate'),s('requestKey',80)],['user_id,request_key']],
 ['WrongNote','wrong_note','문제별 오답 횟수와 최초/최근 오답. 재정답 시 원본 이력 유지.',[fk('user','UserAccount'),fk('question','Question'),fk('firstAttempt','QuestionAttempt'),fk('lastAttempt','QuestionAttempt'),n('errorCount'),b('resolved')],['user_id,question_id']],
 ['QuestionBookmark','question_bookmark','문제 즐겨찾기.',[fk('user','UserAccount'),fk('question','Question')],['user_id,question_id']],
 ['ReviewSchedule','review_schedule','강의/문제/개인단어 중 정확히 한 대상을 복습. 다음 일정과 성공 연속 횟수.',[fk('user','UserAccount'),fk('lesson','GrammarLesson',true),fk('question','Question',true),fk('userVocabulary','UserVocabulary',true),t('dueAt'),n('streak'),b('active')],['user_id,lesson_id','user_id,question_id','user_id,user_vocabulary_id']],
 ['ReviewEvent','review_event','복습 처리 이력. 다음 일정과 간격을 당시 값으로 보존.',[fk('user','UserAccount'),fk('schedule','ReviewSchedule'),b('successful'),n('intervalDays'),t('nextDueAt'),s('requestKey',80)],['user_id,request_key']],
 ['LearningDailyStat','learning_daily_stat','사용자 학습일별 파생 통계. 원본 이벤트로 재계산 가능.',[fk('user','UserAccount'),d('learningDate'),n('studySeconds'),n('attempts'),n('correctAnswers'),n('lessonEvents'),n('wordReviews')],['user_id,learning_date']],
 ['LearningGoal','learning_goal','기간별 목표 기록. 설정 변경과 독립적으로 보존.',[fk('user','UserAccount'),n('targetScore'),n('dailyMinutes'),d('startsOn'),d('endsOn',true),b('active')],[]],
 ['DiagnosticResult','diagnostic_result','진단 회차별 문법 유형 정답률과 권장 학습 설명.',[fk('run','LevelTestRun'),s('grammarType',60),n('totalQuestions'),n('correctAnswers'),text('recommendation')],['run_id,grammar_type']]
];
const snake = s => s.replace(/[A-Z]/g,c=>'_'+c.toLowerCase());
const lookup = Object.fromEntries(tables.map(x=>[x[0],x[1]]));
let sql = '-- MyTOEIC only. All references RESTRICT deletion; never cascade learning history.\n';
for (const [cls, table, purpose, fields, unique] of tables) {
 let cols = ['id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY','created_at datetime(6) NOT NULL','updated_at datetime(6) NOT NULL','version bigint NOT NULL DEFAULT 0'];
 for (const f of fields) cols.push(`${snake(f.name)}${f.target?'_id':''} ${f.sql}${f.nullable?'':' NOT NULL'}`);
 unique.forEach((u,i)=>cols.push(`CONSTRAINT uq_${table}_${i} UNIQUE (${u})`));
 for(const f of fields.filter(x=>x.target)) {
   // Composite foreign keys enforce that an answer/selection belongs to its own question.
   if((cls==='QuestionAnswer'&&f.name==='correctOption')||(cls==='QuestionAttempt'&&f.name==='selectedOption')) continue;
   cols.push(`CONSTRAINT fk_${table}_${snake(f.name)} FOREIGN KEY (${snake(f.name)}_id) REFERENCES ${lookup[f.target]}(id)`);
 }
 if(cls==='QuestionAnswer') cols.push('CONSTRAINT fk_answer_option FOREIGN KEY (question_id,correct_option_id) REFERENCES question_option(question_id,id)');
 if(cls==='QuestionAttempt') cols.push('CONSTRAINT fk_attempt_option FOREIGN KEY (question_id,selected_option_id) REFERENCES question_option(question_id,id)','CONSTRAINT ck_attempt_seconds CHECK (elapsed_seconds BETWEEN 0 AND 86400)');
 if(cls==='ReviewSchedule') cols.push('CONSTRAINT ck_review_target CHECK ((CASE WHEN lesson_id IS NULL THEN 0 ELSE 1 END + CASE WHEN question_id IS NULL THEN 0 ELSE 1 END + CASE WHEN user_vocabulary_id IS NULL THEN 0 ELSE 1 END) = 1)');
 if(cls==='LessonProgress'||cls==='LessonStudyEvent') cols.push(`CONSTRAINT ck_${table}_percent CHECK (percent BETWEEN 0 AND 100)`);
 if(cls==='Question') cols.push("CONSTRAINT ck_question_kind CHECK (kind IN ('PRACTICE','PART5'))",'CONSTRAINT ck_question_difficulty CHECK (difficulty BETWEEN 0 AND 4)');
 if(cls==='QuestionOption') cols.push("CONSTRAINT ck_option_key CHECK (option_key IN ('A','B','C','D'))");
 if(cls==='UserSetting'||cls==='LearningGoal') cols.push(`CONSTRAINT ck_${table}_score CHECK (target_score BETWEEN 10 AND 990)`,`CONSTRAINT ck_${table}_minutes CHECK (daily_minutes BETWEEN 5 AND 240)`);
 sql += `\nCREATE TABLE ${table} (\n  ${cols.join(',\n  ')}\n) ENGINE=InnoDB;\n`;
 let java = `package com.mytoeic.domain;\n\nimport jakarta.persistence.*;\nimport lombok.*;\nimport java.time.*;\n\n/** ${purpose} */\n@Entity\n@Table(name = "${table}")\n@Getter @Setter @NoArgsConstructor\npublic class ${cls} extends BaseEntity {\n`;
 for(const f of fields) {
   if(f.target) java+=`    @ManyToOne(fetch = FetchType.LAZY, optional = ${f.nullable})\n    @JoinColumn(name = "${snake(f.name)}_id", nullable = ${f.nullable})\n`;
   else java+=`    @Column(name = "${snake(f.name)}", nullable = ${f.nullable}${f.sql==='text'?', columnDefinition = "text"':f.java==='String'?`, length = ${f.sql.match(/\d+/)[0]}`:''})\n`;
   java+=`    private ${f.java} ${f.name};\n`;
 }
 java+='}\n';
 write(`backend/src/main/java/com/mytoeic/domain/${cls}.java`,java);
}
sql+=`\nCREATE INDEX ix_lesson_order ON grammar_lesson(level,sort_order);
CREATE INDEX ix_question_filter ON question(active,kind,difficulty,id);
CREATE INDEX ix_attempt_user_time ON question_attempt(user_id,created_at,id);
CREATE INDEX ix_attempt_user_type ON question_attempt(user_id,question_id,created_at);
CREATE INDEX ix_attempt_user_date ON question_attempt(user_id,learning_date);
CREATE INDEX ix_study_user_date ON lesson_study_event(user_id,learning_date);
CREATE INDEX ix_word_review_user_date ON word_review(user_id,learning_date);
CREATE INDEX ix_review_due ON review_schedule(user_id,active,due_at,id);
CREATE INDEX ix_wrong_open ON wrong_note(user_id,resolved,updated_at);
CREATE INDEX ix_goal_active ON learning_goal(user_id,active);
CREATE INDEX ix_run_user ON level_test_run(user_id,created_at);
`;
write('backend/src/main/resources/db/migration/V1__schema.sql',sql);
write('backend/src/main/java/com/mytoeic/domain/BaseEntity.java',`package com.mytoeic.domain;
import jakarta.persistence.*;
import lombok.Getter;
import java.time.*;
@MappedSuperclass @Getter
public abstract class BaseEntity {
 @Id @GeneratedValue(strategy=GenerationType.IDENTITY) private Long id;
 @Column(nullable=false, updatable=false) private LocalDateTime createdAt;
 @Column(nullable=false) private LocalDateTime updatedAt;
 @Version private long version;
 @PrePersist void create() { createdAt=LocalDateTime.now(ZoneOffset.UTC).truncatedTo(java.time.temporal.ChronoUnit.MICROS); updatedAt=createdAt; }
 @PreUpdate void update() { updatedAt=LocalDateTime.now(ZoneOffset.UTC).truncatedTo(java.time.temporal.ChronoUnit.MICROS); }
}
`);
let doc = '# 테이블 정의서\n\n모든 테이블: `id BIGINT AUTO_INCREMENT` PK, `created_at/updated_at DATETIME(6)` UTC, `version BIGINT` 낙관적 잠금. FK는 삭제 RESTRICT이며 학습 이력의 CASCADE DELETE는 없다. 별도 SQL의 CHECK와 인덱스도 적용한다.\n\n';
let erd = '# MyTOEIC ERD\n\n```mermaid\nerDiagram\n';
for (const [cls,table,purpose,fields,uniques] of tables) {
 doc+=`## ${table}\n\n${purpose}\n\n| 컬럼 | SQL 형식 | NULL | 관계 |\n|---|---|---|---|\n`;
 for(const f of fields) doc+=`| ${snake(f.name)}${f.target?'_id':''} | ${f.sql} | ${f.nullable?'허용':'불가'} | ${f.target?lookup[f.target]+'.id FK':'—'} |\n`;
 doc+=`\nUNIQUE: ${uniques.map(x=>'`'+x+'`').join(', ')||'없음'}.\n\n`;
 erd+=`    ${table} {\n        bigint id PK\n`;
 for(const f of fields) erd+=`        ${f.sql.split('(')[0]} ${snake(f.name)}${f.target?'_id FK':''}\n`;
 erd+='    }\n';
 for(const f of fields.filter(x=>x.target)) {
   const cardinality=uniques.includes(snake(f.name)+'_id')?'o|':'o{';
   erd+=`    ${lookup[f.target]} ||--${cardinality} ${table} : "${f.name}"\n`;
 }
}
erd+='```\n\n논리적 1:1은 FK의 UNIQUE로 강제한다. review_schedule은 세 대상 중 하나만 허용하는 CHECK가 있다. question_answer와 question_attempt는 복합 FK로 선택지가 해당 문제에 속하는지 보장한다.\n';
write('docs/TABLES.md',doc); write('docs/ERD.md',erd);
console.log(`Generated ${tables.length} entities, V1, ERD and table definitions.`);
