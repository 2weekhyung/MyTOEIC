// Amendments to the immutable V2 content. Keep earlier seed sources and migrations unchanged.
export const vocabularyCorrections = [
  { code: 'basic-092', field: 'meaning', before: '대답하다', after: '대답하다, (전화를) 받다', reason: '예문 answer the phone에서 사용한 의미를 단어 뜻에도 함께 표시합니다.' },
  { code: 'basic-161', field: 'translation', before: '음식은 좋다.', after: '음식이 맛있다.', reason: 'The food is good.의 자연스러운 식사 상황 해석을 제공합니다.' },
];
export const questionCorrection = {
  code: 'part5-045', before: 'kindly', after: 'kindliness',
  explanation: '친절함이라는 명사예요. 이 문장에서는 직원의 성질을 나타내는 형용사 kind가 필요해요.',
  reason: 'kindly는 부사뿐 아니라 형용사로도 쓰이므로 단일 정답 학습 문제의 오답 선택지에서 제외합니다.',
};
