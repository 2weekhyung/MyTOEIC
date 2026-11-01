-- Add RC Part 6/7 without rewriting V1/V2 or deleting any learning records.
-- DROP CONSTRAINT changes only the allowed question kinds (MySQL >= 8.0.19).
ALTER TABLE question DROP CONSTRAINT ck_question_kind;
ALTER TABLE question ADD CONSTRAINT ck_question_kind CHECK (kind IN ('PRACTICE','PART5','PART6','PART7'));

CREATE TABLE reading_set (
 id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
 created_at datetime(6) NOT NULL,
 updated_at datetime(6) NOT NULL,
 version bigint NOT NULL DEFAULT 0,
 code varchar(60) NOT NULL,
 kind varchar(20) NOT NULL,
 title varchar(255) NOT NULL,
 difficulty integer NOT NULL,
 directions text NOT NULL,
 CONSTRAINT uq_reading_set_code UNIQUE(code),
 CONSTRAINT ck_reading_set_kind CHECK (kind IN ('PART6','PART7')),
 CONSTRAINT ck_reading_set_difficulty CHECK (difficulty BETWEEN 0 AND 4)
) ENGINE=InnoDB;

CREATE TABLE reading_passage (
 id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
 created_at datetime(6) NOT NULL,
 updated_at datetime(6) NOT NULL,
 version bigint NOT NULL DEFAULT 0,
 reading_set_id bigint NOT NULL,
 sequence_no integer NOT NULL,
 title varchar(255) NOT NULL,
 format varchar(30) NOT NULL,
 body text NOT NULL,
 translation text NOT NULL,
 CONSTRAINT uq_reading_passage_position UNIQUE(reading_set_id,sequence_no),
 CONSTRAINT fk_reading_passage_set FOREIGN KEY(reading_set_id) REFERENCES reading_set(id),
 CONSTRAINT ck_reading_passage_position CHECK (sequence_no BETWEEN 1 AND 3)
) ENGINE=InnoDB;

CREATE TABLE reading_set_question (
 id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
 created_at datetime(6) NOT NULL,
 updated_at datetime(6) NOT NULL,
 version bigint NOT NULL DEFAULT 0,
 reading_set_id bigint NOT NULL,
 question_id bigint NOT NULL,
 sequence_no integer NOT NULL,
 CONSTRAINT uq_reading_question UNIQUE(question_id),
 CONSTRAINT uq_reading_question_position UNIQUE(reading_set_id,sequence_no),
 CONSTRAINT fk_reading_question_set FOREIGN KEY(reading_set_id) REFERENCES reading_set(id),
 CONSTRAINT fk_reading_question_question FOREIGN KEY(question_id) REFERENCES question(id),
 CONSTRAINT ck_reading_question_position CHECK (sequence_no > 0)
) ENGINE=InnoDB;

CREATE INDEX ix_reading_set_filter ON reading_set(kind,difficulty,id);
