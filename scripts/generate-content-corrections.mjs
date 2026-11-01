import fs from 'node:fs';
import { vocabularyCorrections, questionCorrection as q } from '../content/corrections.mjs';
const quote = s => `'${s.replaceAll("'", "''")}'`;
let sql = '-- Content quality amendments. Preserve row IDs, every user event, and attempt snapshots.\n-- Replaying this migration does not increment versions again after the amendment.\n';
for (const c of vocabularyCorrections) {
  if (!['meaning', 'translation'].includes(c.field)) throw Error('Invalid vocabulary field');
  sql += `UPDATE vocabulary SET ${c.field}=${quote(c.after)},updated_at=CURRENT_TIMESTAMP,version=version+1 WHERE code=${quote(c.code)} AND ${c.field}=${quote(c.before)};\n`;
}
sql += `UPDATE question_option SET content=${quote(q.after)},explanation=${quote(q.explanation)},updated_at=CURRENT_TIMESTAMP,version=version+1 WHERE question_id=(SELECT id FROM question WHERE code=${quote(q.code)}) AND content=${quote(q.before)};\n`;
sql += `UPDATE question SET revision=2,updated_at=CURRENT_TIMESTAMP,version=version+1 WHERE code=${quote(q.code)} AND revision=1;\n`;
fs.writeFileSync(new URL('../backend/src/main/resources/db/migration/V5__content_quality_amendments.sql', import.meta.url), sql);
console.log('Generated V5: 2 vocabulary refinements, 1 unambiguous question choice, no learning-record changes.');
