-- Content quality amendments. Preserve row IDs, every user event, and attempt snapshots.
-- Replaying this migration does not increment versions again after the amendment.
UPDATE vocabulary SET meaning='대답하다, (전화를) 받다',updated_at=CURRENT_TIMESTAMP,version=version+1 WHERE code='basic-092' AND meaning='대답하다';
UPDATE vocabulary SET translation='음식이 맛있다.',updated_at=CURRENT_TIMESTAMP,version=version+1 WHERE code='basic-161' AND translation='음식은 좋다.';
UPDATE question_option SET content='kindliness',explanation='친절함이라는 명사예요. 이 문장에서는 직원의 성질을 나타내는 형용사 kind가 필요해요.',updated_at=CURRENT_TIMESTAMP,version=version+1 WHERE question_id=(SELECT id FROM question WHERE code='part5-045') AND content='kindly';
UPDATE question SET revision=2,updated_at=CURRENT_TIMESTAMP,version=version+1 WHERE code='part5-045' AND revision=1;
