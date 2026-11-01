// Generates only the NEW V4 migration. V1/V2 are frozen after the 0.1.0 release.
import fs from 'node:fs';
import path from 'node:path';
import {readingSets} from '../content/reading.mjs';
const root=path.resolve(import.meta.dirname,'..');
const p6=readingSets.filter(s=>s.kind==='PART6');
const p7=readingSets.filter(s=>s.kind==='PART7');
if(p6.length!==4||p7.length!==8||p6.reduce((n,s)=>n+s.questions.length,0)!==16||p7.reduce((n,s)=>n+s.questions.length,0)!==30)throw Error('Expected 4 Part6 sets/16 questions and 8 Part7 sets/30 questions');
if(new Set(readingSets.map(s=>s.code)).size!==readingSets.length)throw Error('Duplicate reading code');
if(![1,2,3].every(n=>p7.some(s=>s.passages.length===n)))throw Error('Part7 must include single/double/triple passages');
for(const set of readingSets){
 if(!set.title||!set.directions||set.passages.length<1||set.passages.length>3)throw Error('Bad set '+set.code);
 if(set.kind==='PART6'&&(set.passages.length!==1||set.questions.length!==4||![1,2,3,4].every(n=>set.passages[0].body.split(`[${n}]`).length===2)))throw Error('Part6 requires one text, four numbered blanks and four questions');
 for(const p of set.passages)if(!p.title||!p.format||p.body.length<180||p.translation.length<80)throw Error('Incomplete passage '+set.code);
 for(const q of set.questions){
   if(!q.category||!q.prompt||!q.translation||!q.explanation||q.choices.length!==4||new Set(q.choices.map(c=>c.split('|')[0])).size!==4||q.choices.some(c=>c.split('|').length!==2||c.split('|').some(s=>!s.trim())))throw Error('Incomplete question '+set.code);
 }
}
const quote=s=>"'"+String(s).replaceAll("'","''")+"'";
const sqlExpr=sql=>({sql});
const val=v=>v&&typeof v==='object'?v.sql:v===null?'NULL':typeof v==='number'?String(v):typeof v==='boolean'?(v?'TRUE':'FALSE'):quote(v);
let sql='-- Original MyTOEIC RC Part 6/7 content. Insert-only and repeat-safe.\n';
function insert(table,values,where){sql+=`INSERT INTO ${table} (${Object.keys(values).join(',')},created_at,updated_at,version)\nSELECT ${Object.values(values).map(val).join(',')},CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0\nWHERE NOT EXISTS (SELECT 1 FROM ${table} WHERE ${where});\n`;}
readingSets.forEach((set,si)=>{
 const setId=sqlExpr(`(SELECT id FROM reading_set WHERE code=${quote(set.code)})`);
 insert('reading_set',{code:set.code,kind:set.kind,title:set.title,difficulty:set.difficulty,directions:set.directions},`code=${quote(set.code)}`);
 set.passages.forEach((p,pi)=>insert('reading_passage',{reading_set_id:setId,sequence_no:pi+1,title:p.title,format:p.format,body:p.body,translation:p.translation},`reading_set_id=${val(setId)} AND sequence_no=${pi+1}`));
 set.questions.forEach((q,qi)=>{
   const code=`${set.code}-q${qi+1}`;const qid=sqlExpr(`(SELECT id FROM question WHERE code=${quote(code)})`);
   insert('question',{code,lesson_id:null,kind:set.kind,difficulty:set.difficulty,grammar_type:q.category,prompt:q.prompt,translation:q.translation,revision:1,active:true},`code=${quote(code)}`);
   const shift=(si+qi)%4;let correctKey;
   for(let j=0;j<4;j++){const source=(j+shift)%4;const [content,explanation]=q.choices[source].split('|');const key='ABCD'[j];if(source===0)correctKey=key;
     insert('question_option',{question_id:qid,option_key:key,content,explanation},`question_id=${val(qid)} AND option_key=${quote(key)}`);
   }
   const correctId=sqlExpr(`(SELECT id FROM question_option WHERE question_id=${val(qid)} AND option_key=${quote(correctKey)})`);
   insert('question_answer',{question_id:qid,correct_option_id:correctId,explanation:q.explanation},`question_id=${val(qid)}`);
   insert('reading_set_question',{reading_set_id:setId,question_id:qid,sequence_no:qi+1},`question_id=${val(qid)}`);
 });
});
fs.writeFileSync(path.join(root,'backend/src/main/resources/db/migration/V4__rc_learning_content.sql'),sql);
console.log('Validated RC content: Part6 4 sets/16 questions; Part7 8 sets/30 questions; 16 passages; 184 choices with explanations.');
