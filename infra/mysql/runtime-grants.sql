-- Execute as administrator AFTER approved migrations in the NEW mytoeic database.
-- Replace ACCOUNT_HOST locally. Do not grant DDL to the application.
GRANT SELECT ON mytoeic.* TO 'mytoeic_app'@'ACCOUNT_HOST';
GRANT INSERT, UPDATE ON mytoeic.user_account TO 'mytoeic_app'@'ACCOUNT_HOST';
GRANT INSERT, UPDATE ON mytoeic.user_setting TO 'mytoeic_app'@'ACCOUNT_HOST';
GRANT INSERT, UPDATE ON mytoeic.lesson_progress TO 'mytoeic_app'@'ACCOUNT_HOST';
GRANT INSERT, UPDATE ON mytoeic.user_vocabulary TO 'mytoeic_app'@'ACCOUNT_HOST';
GRANT INSERT, UPDATE ON mytoeic.wrong_note TO 'mytoeic_app'@'ACCOUNT_HOST';
GRANT INSERT, DELETE ON mytoeic.question_bookmark TO 'mytoeic_app'@'ACCOUNT_HOST';
GRANT INSERT, UPDATE ON mytoeic.review_schedule TO 'mytoeic_app'@'ACCOUNT_HOST';
GRANT INSERT, UPDATE ON mytoeic.learning_daily_stat TO 'mytoeic_app'@'ACCOUNT_HOST';
GRANT INSERT, UPDATE ON mytoeic.learning_goal TO 'mytoeic_app'@'ACCOUNT_HOST';
GRANT INSERT, UPDATE ON mytoeic.level_test_run TO 'mytoeic_app'@'ACCOUNT_HOST';
GRANT INSERT ON mytoeic.lesson_study_event TO 'mytoeic_app'@'ACCOUNT_HOST';
GRANT INSERT ON mytoeic.question_attempt TO 'mytoeic_app'@'ACCOUNT_HOST';
GRANT INSERT ON mytoeic.word_review TO 'mytoeic_app'@'ACCOUNT_HOST';
GRANT INSERT ON mytoeic.review_event TO 'mytoeic_app'@'ACCOUNT_HOST';
GRANT INSERT ON mytoeic.diagnostic_result TO 'mytoeic_app'@'ACCOUNT_HOST';
