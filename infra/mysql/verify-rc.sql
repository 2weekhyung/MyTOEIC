-- READ ONLY. Connect explicitly to mytoeic before running.
SELECT version,description,success FROM flyway_schema_history ORDER BY installed_rank;
SELECT kind,COUNT(*) AS questions FROM question GROUP BY kind ORDER BY kind;
SELECT 'lessons' AS item,COUNT(*) AS total FROM grammar_lesson
UNION ALL SELECT 'words',COUNT(*) FROM vocabulary
UNION ALL SELECT 'reading_sets',COUNT(*) FROM reading_set
UNION ALL SELECT 'reading_passages',COUNT(*) FROM reading_passage
UNION ALL SELECT 'reading_links',COUNT(*) FROM reading_set_question;
SELECT s.code,s.kind,
 (SELECT COUNT(*) FROM reading_passage p WHERE p.reading_set_id=s.id) AS passages,
 (SELECT COUNT(*) FROM reading_set_question q WHERE q.reading_set_id=s.id) AS questions
FROM reading_set s ORDER BY s.id;
