// Read-only audit: validates the authored content without rewriting applied migrations.
import fs from 'node:fs';
import path from 'node:path';
import assert from 'node:assert/strict';
import { createHash } from 'node:crypto';
import { lessons } from '../content/lessons.mjs';
import { practice, part5 } from '../content/questions.mjs';
import { readingSets } from '../content/reading.mjs';
import { vocabularyCorrections, questionCorrection } from '../content/corrections.mjs';
const root = path.resolve(import.meta.dirname, '..');
const baselineV4 = process.argv.includes('--baseline-v4');
const words = fs.readFileSync(path.join(root, 'content/words.tsv'), 'utf8').trim().split(/\r?\n/).map(l => l.split('\t'));
for (const correction of baselineV4 ? [] : vocabularyCorrections) {
  const index = Number(correction.code.slice(6)) - 1;
  words[index][correction.field === 'meaning' ? 2 : 4] = correction.after;
}
const hasKorean = s => /[가-힣]/.test(s);
assert.equal(lessons.length, 10); assert.equal(words.length, 200); assert.equal(practice.length, 20); assert.equal(part5.length, 50);
assert.equal(new Set(lessons.map(l => l.code)).size, lessons.length);
assert.equal(new Set(words.map(w => w[0].toLowerCase())).size, words.length);
for (const l of lessons) {
  assert(l.content.length > 250 && hasKorean(l.content), `Incomplete Korean lesson: ${l.code}`);
  assert(l.easier.length > 50 && l.summary.length > 30 && hasKorean(l.objective), `Missing teaching fields: ${l.code}`);
  assert(l.examples.length >= 3 && practice.filter(q => q.lesson === l.code).length >= 2, `Missing lesson examples or practice: ${l.code}`);
  for (const e of l.examples) assert(e.length === 4 && e.every(Boolean) && hasKorean(e[1]) && hasKorean(e[2]) && hasKorean(e[3]), `Untranslated example: ${l.code}`);
}
for (const [word, pos, meaning, example, translation, extra] of words) {
  assert(!extra && [word, pos, meaning, example, translation].every(Boolean), `Incomplete vocabulary: ${word}`);
  assert(hasKorean(pos) && hasKorean(meaning) && hasKorean(translation) && /[a-z]/i.test(example), `Missing word translation: ${word}`);
}
const rc = readingSets.flatMap(s => s.questions);
for (const q of [...practice, ...part5, ...rc]) {
  assert(q.prompt && hasKorean(q.translation) && q.explanation.length >= 10 && hasKorean(q.explanation), `Missing question explanation: ${q.prompt}`);
  assert.equal(q.choices.length, 4); assert.equal(new Set(q.choices.map(c => c.split('|')[0])).size, 4);
  for (const c of q.choices) { const parts = c.split('|'); assert(parts.length === 2 && parts[0] && hasKorean(parts[1]), `Missing distractor explanation: ${q.prompt}`); }
}
assert.equal(readingSets.filter(s => s.kind === 'PART6').reduce((n, s) => n + s.questions.length, 0), 16);
assert.equal(readingSets.filter(s => s.kind === 'PART7').reduce((n, s) => n + s.questions.length, 0), 30);
for (const s of readingSets) {
  assert(s.passages.every(p => p.body.length > 180 && hasKorean(p.translation)), `Missing passage translation: ${s.code}`);
  if (s.kind === 'PART6') for (const n of [1, 2, 3, 4]) assert.equal(s.passages[0].body.split(`[${n}]`).length, 2);
}
for (const [file, expected] of Object.entries({
  'V1__schema.sql': '26d6f137148397bdda8b449953c241e60081d04c4cb21adc639e3485d7ea8d18',
  'V2__initial_learning_content.sql': 'd14c828d139243e542be3e5b5128c064d24274b11c3352a35d810c38a8eb1c3f',
})) assert.equal(createHash('sha256').update(fs.readFileSync(path.join(root, 'backend/src/main/resources/db/migration', file))).digest('hex'), expected, `Applied migration changed: ${file}`);

const checks = []; const quote = s => `'${String(s).replaceAll('\\', '\\\\').replaceAll("'", "''")}'`;
const exact = (col, value) => typeof value === 'number' ? `${col}=${value}` : `BINARY ${col}=BINARY ${quote(value)}`;
function check(label, table, identity, values) { checks.push(`SELECT ${quote(label)} AS item,IF((SELECT COUNT(*) FROM ${table} WHERE ${identity}${Object.entries(values).map(([k, v]) => ' AND ' + exact(k, v)).join('')})=1,'OK','MISMATCH') AS result;`); }
for (const l of lessons) {
  check(`lesson:${l.code}`, 'grammar_lesson', `code=${quote(l.code)}`, { title: l.title, content: l.content, easier_explanation: l.easier, summary: l.summary, objective: l.objective, level: l.level });
  l.examples.forEach((e, i) => check(`example:${l.code}:${i + 1}`, 'grammar_example e JOIN grammar_lesson l ON l.id=e.lesson_id', `l.code=${quote(l.code)} AND e.sequence_no=${i + 1}`, { 'e.sentence': e[0], 'e.translation': e[1], 'e.analysis': e[2], 'e.explanation': e[3] }));
}
words.forEach(([word, pos, meaning, example, translation], i) => check(`word:basic-${String(i + 1).padStart(3, '0')}`, 'vocabulary', `code=${quote('basic-' + String(i + 1).padStart(3, '0'))}`, { word, part_of_speech: pos, meaning, example, translation, level: i < 100 ? 0 : 1 }));
function question(q, code, kind, shift, category) {
  if (!baselineV4 && code === questionCorrection.code) q = { ...q, choices: q.choices.map(c => c.split('|')[0] === questionCorrection.before ? `${questionCorrection.after}|${questionCorrection.explanation}` : c) };
  check(`question:${code}`, 'question', `code=${quote(code)} AND active=TRUE`, { kind, prompt: q.prompt, translation: q.translation, grammar_type: category });
  const right = q.choices[0].split('|')[0];
  check(`answer:${code}`, 'question_answer a JOIN question q ON q.id=a.question_id JOIN question_option o ON o.id=a.correct_option_id AND o.question_id=q.id', `q.code=${quote(code)}`, { 'a.explanation': q.explanation, 'o.content': right });
  for (let j = 0; j < 4; j++) { const [content, explanation] = q.choices[(j + shift) % 4].split('|'); check(`choice:${code}:${'ABCD'[j]}`, 'question_option o JOIN question q ON q.id=o.question_id', `q.code=${quote(code)} AND o.option_key=${quote('ABCD'[j])}`, { 'o.content': content, 'o.explanation': explanation }); }
}
practice.forEach((q, i) => question(q, `practice-${String(i + 1).padStart(3, '0')}`, 'PRACTICE', i % 4, q.lesson));
part5.forEach((q, i) => question(q, `part5-${String(i + 1).padStart(3, '0')}`, 'PART5', i % 4, q.lesson));
readingSets.forEach((s, si) => {
  check(`set:${s.code}`, 'reading_set', `code=${quote(s.code)}`, { kind: s.kind, title: s.title, directions: s.directions, difficulty: s.difficulty });
  s.passages.forEach((p, i) => check(`passage:${s.code}:${i + 1}`, 'reading_passage p JOIN reading_set s ON s.id=p.reading_set_id', `s.code=${quote(s.code)} AND p.sequence_no=${i + 1}`, { 'p.title': p.title, 'p.format': p.format, 'p.body': p.body, 'p.translation': p.translation }));
  s.questions.forEach((q, qi) => { const code = `${s.code}-q${qi + 1}`; question(q, code, s.kind, (si + qi) % 4, q.category); check(`link:${code}`, 'reading_set_question l JOIN reading_set s ON s.id=l.reading_set_id JOIN question q ON q.id=l.question_id', `s.code=${quote(s.code)} AND q.code=${quote(code)}`, { 'l.sequence_no': qi + 1 }); });
});
const output = process.argv.indexOf('--sql');
if (output >= 0) { const destination = process.argv[output + 1]; assert(destination, 'Output filename required'); fs.writeFileSync(path.resolve(destination), `-- READ ONLY: compare every authored content field against the installed database.\nSET NAMES utf8mb4;\nSTART TRANSACTION WITH CONSISTENT SNAPSHOT, READ ONLY;\n${checks.join('\n')}\nCOMMIT;\n`); }
console.log(`PASS: 10 lessons / 30 translated examples / 200 complete words / 116 questions / 464 explained choices / 16 translated reading passages.`);
console.log(`Prepared ${checks.length} exact-content DB checks for ${baselineV4 ? 'server baseline V4' : 'code V5'}. Applied V1/V2 are unchanged. Semantic review remains a separate human responsibility.`);
