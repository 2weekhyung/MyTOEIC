export interface Page<T> {
  content: T[];
  page: number;
  size: number;
  totalElements: number;
  totalPages: number;
}
export interface Lesson {
  id: number;
  code: string;
  title: string;
  level: number;
  minutes: number;
  objective: string;
}
export interface Progress {
  lessonId: number;
  percent: number;
  completedAt: string | null;
}
export interface Example {
  sentence: string;
  translation: string;
  analysis: string;
  explanation: string;
}
export interface LessonDetail {
  lesson: Lesson;
  content: string;
  easierExplanation: string;
  summary: string;
  examples: Example[];
  practice: Question[];
}
export interface Passage {
  id: number;
  sequenceNo: number;
  title: string;
  format: string;
  body: string;
}
export interface Question {
  id: number;
  code: string;
  kind: string;
  difficulty: number;
  grammarType: string;
  prompt: string;
  options: { id: number; key: string; content: string }[];
  reading: {
    setId: number;
    code: string;
    title: string;
    directions: string;
    questionNumber: number;
    passages: Passage[];
  } | null;
}
export interface Answer {
  correctOptionId: number;
  translation: string;
  explanation: string;
  optionExplanations: Record<string, string>;
  passageTranslations:
    { id: number; title: string; translation: string }[] | null;
}
export interface Attempt {
  id: number;
  correct: boolean;
  question: Question;
  answer: Answer;
  elapsedSeconds: number;
  createdAt: string;
}
export interface ReadingSet {
  id: number;
  code: string;
  kind: string;
  title: string;
  difficulty: number;
  passageCount: number;
  questionCount: number;
}
export interface ReadingDetail {
  readingSet: ReadingSet;
  passages: Passage[];
  questions: Question[];
}
export interface Word {
  id: number;
  word: string;
  partOfSpeech: string;
  meaning: string;
  example: string;
  translation: string;
  level: number;
}
export interface Notebook {
  id: number;
  status: string;
  word: Word;
}
export interface WrongNote {
  id: number;
  questionId: number;
  prompt: string;
  errorCount: number;
  resolved: boolean;
  firstAttemptId: number;
  lastAttemptId: number;
}
export interface Schedule {
  id: number;
  type: "LESSON" | "QUESTION" | "WORD";
  targetId: number;
  title: string;
  dueAt: string;
  streak: number;
}
export interface Category {
  grammarType: string;
  attempts: number;
  correct: number;
  accuracy: number;
}
export interface Day {
  date: string;
  studySeconds: number;
  attempts: number;
  correctAnswers: number;
  lessonEvents: number;
  wordReviews: number;
}
export interface Dashboard {
  today: string;
  targetScore: number;
  dailyMinutes: number;
  level: number;
  studyDays: number;
  streak: number;
  weeklySeconds: number;
  todayGoalRate: number;
  days: Day[];
  categories: Category[];
  recommendations: {
    grammarType: string;
    action: string;
    explanation: string;
  }[];
}
export interface Settings {
  targetScore: number;
  dailyMinutes: number;
  timezone: string;
  learningLevel: number;
}
export interface Goal {
  id: number;
  targetScore: number;
  dailyMinutes: number;
  startsOn: string;
  endsOn: string | null;
  active: boolean;
}
export interface PartStat {
  kind: string;
  attempts: number;
  correct: number;
  accuracy: number;
}
export interface Test {
  id: number;
  title: string;
  questionCount: number;
}
export interface TestRun {
  id: number;
  status: string;
  recommendedLevel: number | null;
  questions: Question[];
  results: {
    grammarType: string;
    total: number;
    correct: number;
    recommendation: string;
  }[];
  attempts: Attempt[];
}
