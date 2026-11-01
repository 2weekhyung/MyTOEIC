import fs from 'node:fs';
import path from 'node:path';
import {lessons} from '../content/lessons.mjs';
import {practice,part5} from '../content/questions.mjs';
const root=path.resolve(import.meta.dirname,'..');
const words=fs.readFileSync(path.join(root,'content/words.tsv'),'utf8').trim().split(/\r?\n/).map(x=>x.split('\t'));
if(lessons.length!==10 || practice.length!==20 || part5.length!==50 || words.length!==200) throw Error(`Counts: lessons=${lessons.length}, practice=${practice.length}, part5=${part5.length}, words=${words.length}`);
if(new Set(words.map(w=>w[0])).size!==200||words.some(w=>w.length!==5||w.some(s=>!s)))throw Error('Invalid or duplicate vocabulary');
if(lessons.some(l=>l.examples.length<3))throw Error('At least 3 examples per lesson');
if(lessons.some(l=>practice.filter(q=>q.lesson===l.code).length<2))throw Error('At least 2 practice/review questions per lesson');
const quote=s=>"'"+String(s).replaceAll("'","''")+"'";
const expr=s=>({sql:s});
const val=v=>v&&typeof v==='object'?v.sql:typeof v==='number'?String(v):typeof v==='boolean'?(v?'TRUE':'FALSE'):v===null?'NULL':quote(v);
const lessonId=code=>expr(`(SELECT id FROM grammar_lesson WHERE code=${quote(code)})`);
const questionId=code=>expr(`(SELECT id FROM question WHERE code=${quote(code)})`);
let sql='-- Original MyTOEIC educational content. Insert-only and repeat-safe.\n-- Never DELETE, TRUNCATE or UPDATE user learning data.\n';
function insert(table,values,where){
 const keys=Object.keys(values);sql+=`INSERT INTO ${table} (${keys.join(',')},created_at,updated_at,version)\nSELECT ${Object.values(values).map(val).join(',')},CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0\nWHERE NOT EXISTS (SELECT 1 FROM ${table} WHERE ${where});\n`;
}
lessons.forEach((l,i)=>{
 insert('grammar_lesson',{code:l.code,title:l.title,level:l.level,sort_order:i+1,estimated_minutes:10,revision:1,objective:l.objective,content:l.content,easier_explanation:l.easier,summary:l.summary},`code=${quote(l.code)}`);
 l.examples.forEach((e,j)=>insert('grammar_example',{lesson_id:lessonId(l.code),sequence_no:j+1,sentence:e[0],translation:e[1],analysis:e[2],explanation:e[3]},`lesson_id=${val(lessonId(l.code))} AND sequence_no=${j+1}`));
});
function addQuestion(q,i,kind){
 if(!lessons.find(l=>l.code===q.lesson)||q.choices.length!==4||new Set(q.choices.map(c=>c.split('|')[0])).size!==4||q.choices.some(c=>c.split('|').length!==2))throw Error('Bad question '+i);
 const code=`${kind.toLowerCase()}-${String(i+1).padStart(3,'0')}`;
 insert('question',{code,lesson_id:lessonId(q.lesson),kind,difficulty:kind==='PART5'?1:0,grammar_type:q.lesson,prompt:q.prompt,translation:q.translation,revision:1,active:true},`code=${quote(code)}`);
 const shift=i%4;let right='';
 for(let j=0;j<4;j++) {const source=(j+shift)%4;const [content,explanation]=q.choices[source].split('|');const key='ABCD'[j];if(source===0)right=key;
 insert('question_option',{question_id:questionId(code),option_key:key,content,explanation},`question_id=${val(questionId(code))} AND option_key=${quote(key)}`);}
 insert('question_answer',{question_id:questionId(code),correct_option_id:expr(`(SELECT id FROM question_option WHERE question_id=${val(questionId(code))} AND option_key=${quote(right)})`),explanation:q.explanation},`question_id=${val(questionId(code))}`);
 return code;
}
practice.forEach((q,i)=>addQuestion(q,i,'PRACTICE'));part5.forEach((q,i)=>addQuestion(q,i,'PART5'));
words.forEach(([word,pos,meaning,example,translation],i)=>insert('vocabulary',{code:`basic-${String(i+1).padStart(3,'0')}`,word,part_of_speech:pos,meaning,example,translation,level:i<100?0:1},`code=${quote('basic-'+String(i+1).padStart(3,'0'))} OR (word=${quote(word)} AND part_of_speech=${quote(pos)} AND meaning=${quote(meaning)})`));
insert('level_test',{code:'foundation-v1',title:'기초 문법 진단 (공식 TOEIC 점수 아님)',active:true},"code='foundation-v1'");
lessons.forEach((l,i)=>{
 const code=`practice-${String(i*2+1).padStart(3,'0')}`;const testId=expr("(SELECT id FROM level_test WHERE code='foundation-v1')");
 insert('level_test_question',{test_id:testId,question_id:questionId(code),sequence_no:i+1},`test_id=${val(testId)} AND question_id=${val(questionId(code))}`);
});
fs.writeFileSync(path.join(root,'backend/src/main/resources/db/migration/V2__initial_learning_content.sql'),sql);
console.log(`Validated & generated: ${lessons.length} lessons / 30 examples / ${practice.length} practice / ${part5.length} Part5 / ${words.length} words / 1 diagnostic`);
