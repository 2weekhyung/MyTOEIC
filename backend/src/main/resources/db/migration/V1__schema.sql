-- MyTOEIC only. All references RESTRICT deletion; never cascade learning history.

CREATE TABLE user_account (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  version bigint NOT NULL DEFAULT 0,
  username varchar(80) NOT NULL,
  password_hash varchar(100) NOT NULL,
  active boolean NOT NULL,
  CONSTRAINT uq_user_account_0 UNIQUE (username)
) ENGINE=InnoDB;

CREATE TABLE user_setting (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  version bigint NOT NULL DEFAULT 0,
  user_id bigint NOT NULL,
  target_score integer NOT NULL,
  daily_minutes integer NOT NULL,
  timezone varchar(60) NOT NULL,
  learning_level integer NOT NULL,
  CONSTRAINT uq_user_setting_0 UNIQUE (user_id),
  CONSTRAINT fk_user_setting_user FOREIGN KEY (user_id) REFERENCES user_account(id),
  CONSTRAINT ck_user_setting_score CHECK (target_score BETWEEN 10 AND 990),
  CONSTRAINT ck_user_setting_minutes CHECK (daily_minutes BETWEEN 5 AND 240)
) ENGINE=InnoDB;

CREATE TABLE grammar_lesson (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  version bigint NOT NULL DEFAULT 0,
  code varchar(60) NOT NULL,
  title varchar(255) NOT NULL,
  level integer NOT NULL,
  sort_order integer NOT NULL,
  estimated_minutes integer NOT NULL,
  revision integer NOT NULL,
  objective text NOT NULL,
  content text NOT NULL,
  easier_explanation text NOT NULL,
  summary text NOT NULL,
  CONSTRAINT uq_grammar_lesson_0 UNIQUE (code)
) ENGINE=InnoDB;

CREATE TABLE grammar_example (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  version bigint NOT NULL DEFAULT 0,
  lesson_id bigint NOT NULL,
  sequence_no integer NOT NULL,
  sentence varchar(1000) NOT NULL,
  translation varchar(1000) NOT NULL,
  analysis text NOT NULL,
  explanation text NOT NULL,
  CONSTRAINT uq_grammar_example_0 UNIQUE (lesson_id,sequence_no),
  CONSTRAINT fk_grammar_example_lesson FOREIGN KEY (lesson_id) REFERENCES grammar_lesson(id)
) ENGINE=InnoDB;

CREATE TABLE question (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  version bigint NOT NULL DEFAULT 0,
  code varchar(60) NOT NULL,
  lesson_id bigint,
  kind varchar(20) NOT NULL,
  difficulty integer NOT NULL,
  grammar_type varchar(60) NOT NULL,
  prompt text NOT NULL,
  translation text NOT NULL,
  revision integer NOT NULL,
  active boolean NOT NULL,
  CONSTRAINT uq_question_0 UNIQUE (code),
  CONSTRAINT fk_question_lesson FOREIGN KEY (lesson_id) REFERENCES grammar_lesson(id),
  CONSTRAINT ck_question_kind CHECK (kind IN ('PRACTICE','PART5')),
  CONSTRAINT ck_question_difficulty CHECK (difficulty BETWEEN 0 AND 4)
) ENGINE=InnoDB;

CREATE TABLE question_option (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  version bigint NOT NULL DEFAULT 0,
  question_id bigint NOT NULL,
  option_key varchar(1) NOT NULL,
  content varchar(1000) NOT NULL,
  explanation text NOT NULL,
  CONSTRAINT uq_question_option_0 UNIQUE (question_id,option_key),
  CONSTRAINT uq_question_option_1 UNIQUE (question_id,id),
  CONSTRAINT fk_question_option_question FOREIGN KEY (question_id) REFERENCES question(id),
  CONSTRAINT ck_option_key CHECK (option_key IN ('A','B','C','D'))
) ENGINE=InnoDB;

CREATE TABLE question_answer (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  version bigint NOT NULL DEFAULT 0,
  question_id bigint NOT NULL,
  correct_option_id bigint NOT NULL,
  explanation text NOT NULL,
  CONSTRAINT uq_question_answer_0 UNIQUE (question_id),
  CONSTRAINT fk_question_answer_question FOREIGN KEY (question_id) REFERENCES question(id),
  CONSTRAINT fk_answer_option FOREIGN KEY (question_id,correct_option_id) REFERENCES question_option(question_id,id)
) ENGINE=InnoDB;

CREATE TABLE vocabulary (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  version bigint NOT NULL DEFAULT 0,
  code varchar(60) NOT NULL,
  word varchar(100) NOT NULL,
  part_of_speech varchar(30) NOT NULL,
  meaning varchar(255) NOT NULL,
  example varchar(1000) NOT NULL,
  translation varchar(1000) NOT NULL,
  level integer NOT NULL,
  CONSTRAINT uq_vocabulary_0 UNIQUE (code),
  CONSTRAINT uq_vocabulary_1 UNIQUE (word,part_of_speech,meaning)
) ENGINE=InnoDB;

CREATE TABLE lesson_progress (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  version bigint NOT NULL DEFAULT 0,
  user_id bigint NOT NULL,
  lesson_id bigint NOT NULL,
  percent integer NOT NULL,
  completed_at datetime(6),
  CONSTRAINT uq_lesson_progress_0 UNIQUE (user_id,lesson_id),
  CONSTRAINT fk_lesson_progress_user FOREIGN KEY (user_id) REFERENCES user_account(id),
  CONSTRAINT fk_lesson_progress_lesson FOREIGN KEY (lesson_id) REFERENCES grammar_lesson(id),
  CONSTRAINT ck_lesson_progress_percent CHECK (percent BETWEEN 0 AND 100)
) ENGINE=InnoDB;

CREATE TABLE lesson_study_event (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  version bigint NOT NULL DEFAULT 0,
  user_id bigint NOT NULL,
  lesson_id bigint NOT NULL,
  percent integer NOT NULL,
  elapsed_seconds integer NOT NULL,
  learning_date date NOT NULL,
  request_key varchar(80) NOT NULL,
  CONSTRAINT uq_lesson_study_event_0 UNIQUE (user_id,request_key),
  CONSTRAINT fk_lesson_study_event_user FOREIGN KEY (user_id) REFERENCES user_account(id),
  CONSTRAINT fk_lesson_study_event_lesson FOREIGN KEY (lesson_id) REFERENCES grammar_lesson(id),
  CONSTRAINT ck_lesson_study_event_percent CHECK (percent BETWEEN 0 AND 100)
) ENGINE=InnoDB;

CREATE TABLE level_test (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  version bigint NOT NULL DEFAULT 0,
  code varchar(60) NOT NULL,
  title varchar(255) NOT NULL,
  active boolean NOT NULL,
  CONSTRAINT uq_level_test_0 UNIQUE (code)
) ENGINE=InnoDB;

CREATE TABLE level_test_question (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  version bigint NOT NULL DEFAULT 0,
  test_id bigint NOT NULL,
  question_id bigint NOT NULL,
  sequence_no integer NOT NULL,
  CONSTRAINT uq_level_test_question_0 UNIQUE (test_id,question_id),
  CONSTRAINT uq_level_test_question_1 UNIQUE (test_id,sequence_no),
  CONSTRAINT fk_level_test_question_test FOREIGN KEY (test_id) REFERENCES level_test(id),
  CONSTRAINT fk_level_test_question_question FOREIGN KEY (question_id) REFERENCES question(id)
) ENGINE=InnoDB;

CREATE TABLE level_test_run (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  version bigint NOT NULL DEFAULT 0,
  user_id bigint NOT NULL,
  test_id bigint NOT NULL,
  status varchar(20) NOT NULL,
  completed_at datetime(6),
  recommended_level integer,
  request_key varchar(80) NOT NULL,
  CONSTRAINT uq_level_test_run_0 UNIQUE (user_id,request_key),
  CONSTRAINT fk_level_test_run_user FOREIGN KEY (user_id) REFERENCES user_account(id),
  CONSTRAINT fk_level_test_run_test FOREIGN KEY (test_id) REFERENCES level_test(id)
) ENGINE=InnoDB;

CREATE TABLE question_attempt (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  version bigint NOT NULL DEFAULT 0,
  user_id bigint NOT NULL,
  question_id bigint NOT NULL,
  selected_option_id bigint NOT NULL,
  test_run_id bigint,
  correct boolean NOT NULL,
  elapsed_seconds integer NOT NULL,
  question_revision integer NOT NULL,
  question_snapshot text NOT NULL,
  answer_snapshot text NOT NULL,
  learning_date date NOT NULL,
  request_key varchar(80) NOT NULL,
  CONSTRAINT uq_question_attempt_0 UNIQUE (user_id,request_key),
  CONSTRAINT uq_question_attempt_1 UNIQUE (test_run_id,question_id),
  CONSTRAINT fk_question_attempt_user FOREIGN KEY (user_id) REFERENCES user_account(id),
  CONSTRAINT fk_question_attempt_question FOREIGN KEY (question_id) REFERENCES question(id),
  CONSTRAINT fk_question_attempt_test_run FOREIGN KEY (test_run_id) REFERENCES level_test_run(id),
  CONSTRAINT fk_attempt_option FOREIGN KEY (question_id,selected_option_id) REFERENCES question_option(question_id,id),
  CONSTRAINT ck_attempt_seconds CHECK (elapsed_seconds BETWEEN 0 AND 86400)
) ENGINE=InnoDB;

CREATE TABLE user_vocabulary (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  version bigint NOT NULL DEFAULT 0,
  user_id bigint NOT NULL,
  vocabulary_id bigint NOT NULL,
  status varchar(20) NOT NULL,
  CONSTRAINT uq_user_vocabulary_0 UNIQUE (user_id,vocabulary_id),
  CONSTRAINT fk_user_vocabulary_user FOREIGN KEY (user_id) REFERENCES user_account(id),
  CONSTRAINT fk_user_vocabulary_vocabulary FOREIGN KEY (vocabulary_id) REFERENCES vocabulary(id)
) ENGINE=InnoDB;

CREATE TABLE word_review (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  version bigint NOT NULL DEFAULT 0,
  user_id bigint NOT NULL,
  user_vocabulary_id bigint NOT NULL,
  remembered boolean NOT NULL,
  elapsed_seconds integer NOT NULL,
  word_snapshot text NOT NULL,
  learning_date date NOT NULL,
  request_key varchar(80) NOT NULL,
  CONSTRAINT uq_word_review_0 UNIQUE (user_id,request_key),
  CONSTRAINT fk_word_review_user FOREIGN KEY (user_id) REFERENCES user_account(id),
  CONSTRAINT fk_word_review_user_vocabulary FOREIGN KEY (user_vocabulary_id) REFERENCES user_vocabulary(id)
) ENGINE=InnoDB;

CREATE TABLE wrong_note (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  version bigint NOT NULL DEFAULT 0,
  user_id bigint NOT NULL,
  question_id bigint NOT NULL,
  first_attempt_id bigint NOT NULL,
  last_attempt_id bigint NOT NULL,
  error_count integer NOT NULL,
  resolved boolean NOT NULL,
  CONSTRAINT uq_wrong_note_0 UNIQUE (user_id,question_id),
  CONSTRAINT fk_wrong_note_user FOREIGN KEY (user_id) REFERENCES user_account(id),
  CONSTRAINT fk_wrong_note_question FOREIGN KEY (question_id) REFERENCES question(id),
  CONSTRAINT fk_wrong_note_first_attempt FOREIGN KEY (first_attempt_id) REFERENCES question_attempt(id),
  CONSTRAINT fk_wrong_note_last_attempt FOREIGN KEY (last_attempt_id) REFERENCES question_attempt(id)
) ENGINE=InnoDB;

CREATE TABLE question_bookmark (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  version bigint NOT NULL DEFAULT 0,
  user_id bigint NOT NULL,
  question_id bigint NOT NULL,
  CONSTRAINT uq_question_bookmark_0 UNIQUE (user_id,question_id),
  CONSTRAINT fk_question_bookmark_user FOREIGN KEY (user_id) REFERENCES user_account(id),
  CONSTRAINT fk_question_bookmark_question FOREIGN KEY (question_id) REFERENCES question(id)
) ENGINE=InnoDB;

CREATE TABLE review_schedule (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  version bigint NOT NULL DEFAULT 0,
  user_id bigint NOT NULL,
  lesson_id bigint,
  question_id bigint,
  user_vocabulary_id bigint,
  due_at datetime(6) NOT NULL,
  streak integer NOT NULL,
  active boolean NOT NULL,
  CONSTRAINT uq_review_schedule_0 UNIQUE (user_id,lesson_id),
  CONSTRAINT uq_review_schedule_1 UNIQUE (user_id,question_id),
  CONSTRAINT uq_review_schedule_2 UNIQUE (user_id,user_vocabulary_id),
  CONSTRAINT fk_review_schedule_user FOREIGN KEY (user_id) REFERENCES user_account(id),
  CONSTRAINT fk_review_schedule_lesson FOREIGN KEY (lesson_id) REFERENCES grammar_lesson(id),
  CONSTRAINT fk_review_schedule_question FOREIGN KEY (question_id) REFERENCES question(id),
  CONSTRAINT fk_review_schedule_user_vocabulary FOREIGN KEY (user_vocabulary_id) REFERENCES user_vocabulary(id),
  CONSTRAINT ck_review_target CHECK ((CASE WHEN lesson_id IS NULL THEN 0 ELSE 1 END + CASE WHEN question_id IS NULL THEN 0 ELSE 1 END + CASE WHEN user_vocabulary_id IS NULL THEN 0 ELSE 1 END) = 1)
) ENGINE=InnoDB;

CREATE TABLE review_event (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  version bigint NOT NULL DEFAULT 0,
  user_id bigint NOT NULL,
  schedule_id bigint NOT NULL,
  successful boolean NOT NULL,
  interval_days integer NOT NULL,
  next_due_at datetime(6) NOT NULL,
  request_key varchar(80) NOT NULL,
  CONSTRAINT uq_review_event_0 UNIQUE (user_id,request_key),
  CONSTRAINT fk_review_event_user FOREIGN KEY (user_id) REFERENCES user_account(id),
  CONSTRAINT fk_review_event_schedule FOREIGN KEY (schedule_id) REFERENCES review_schedule(id)
) ENGINE=InnoDB;

CREATE TABLE learning_daily_stat (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  version bigint NOT NULL DEFAULT 0,
  user_id bigint NOT NULL,
  learning_date date NOT NULL,
  study_seconds integer NOT NULL,
  attempts integer NOT NULL,
  correct_answers integer NOT NULL,
  lesson_events integer NOT NULL,
  word_reviews integer NOT NULL,
  CONSTRAINT uq_learning_daily_stat_0 UNIQUE (user_id,learning_date),
  CONSTRAINT fk_learning_daily_stat_user FOREIGN KEY (user_id) REFERENCES user_account(id)
) ENGINE=InnoDB;

CREATE TABLE learning_goal (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  version bigint NOT NULL DEFAULT 0,
  user_id bigint NOT NULL,
  target_score integer NOT NULL,
  daily_minutes integer NOT NULL,
  starts_on date NOT NULL,
  ends_on date,
  active boolean NOT NULL,
  CONSTRAINT fk_learning_goal_user FOREIGN KEY (user_id) REFERENCES user_account(id),
  CONSTRAINT ck_learning_goal_score CHECK (target_score BETWEEN 10 AND 990),
  CONSTRAINT ck_learning_goal_minutes CHECK (daily_minutes BETWEEN 5 AND 240)
) ENGINE=InnoDB;

CREATE TABLE diagnostic_result (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  version bigint NOT NULL DEFAULT 0,
  run_id bigint NOT NULL,
  grammar_type varchar(60) NOT NULL,
  total_questions integer NOT NULL,
  correct_answers integer NOT NULL,
  recommendation text NOT NULL,
  CONSTRAINT uq_diagnostic_result_0 UNIQUE (run_id,grammar_type),
  CONSTRAINT fk_diagnostic_result_run FOREIGN KEY (run_id) REFERENCES level_test_run(id)
) ENGINE=InnoDB;

CREATE INDEX ix_lesson_order ON grammar_lesson(level,sort_order);
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
