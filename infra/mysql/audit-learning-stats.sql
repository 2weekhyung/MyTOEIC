-- READ ONLY. Connect explicitly to the dedicated MyTOEIC database before running.
WITH events AS (
 SELECT user_id,learning_date,elapsed_seconds AS seconds,0 AS attempts,0 AS correct,1 AS lessons,0 AS words FROM lesson_study_event
 UNION ALL
 SELECT user_id,learning_date,elapsed_seconds,1,CASE WHEN correct THEN 1 ELSE 0 END,0,0 FROM question_attempt
 UNION ALL
 SELECT user_id,learning_date,elapsed_seconds,0,0,0,1 FROM word_review
), totals AS (
 SELECT user_id,learning_date,SUM(seconds) AS seconds,SUM(attempts) AS attempts,SUM(correct) AS correct,SUM(lessons) AS lessons,SUM(words) AS words
 FROM events GROUP BY user_id,learning_date
)
SELECT t.user_id,t.learning_date,t.seconds,t.attempts,t.correct,t.lessons,t.words,
 s.study_seconds AS stored_seconds,s.attempts AS stored_attempts,s.correct_answers AS stored_correct,
 s.lesson_events AS stored_lessons,s.word_reviews AS stored_words
FROM totals t LEFT JOIN learning_daily_stat s ON s.user_id=t.user_id AND s.learning_date=t.learning_date
WHERE s.id IS NULL OR t.seconds<>s.study_seconds OR t.attempts<>s.attempts OR t.correct<>s.correct_answers OR t.lessons<>s.lesson_events OR t.words<>s.word_reviews
UNION ALL
SELECT s.user_id,s.learning_date,0,0,0,0,0,s.study_seconds,s.attempts,s.correct_answers,s.lesson_events,s.word_reviews
FROM learning_daily_stat s LEFT JOIN totals t ON s.user_id=t.user_id AND s.learning_date=t.learning_date
WHERE t.user_id IS NULL;
