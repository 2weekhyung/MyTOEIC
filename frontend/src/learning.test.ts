import { describe, expect, it } from "vitest";
import fs from "node:fs";
import { wordChoices } from "./pages/Words";
import { grammarName, practiceLink } from "./ui";
import type { Word } from "./types";
const words: Word[] = fs
  .readFileSync(new URL("../../content/words.tsv", import.meta.url), "utf8")
  .trim()
  .split(/\r?\n/)
  .map((line, i) => {
    const [word, partOfSpeech, meaning, example, translation] =
      line.split("\t");
    return {
      id: i + 1,
      word,
      partOfSpeech,
      meaning,
      example,
      translation,
      level: i < 100 ? 0 : 1,
    };
  });
describe("authored vocabulary practice", () => {
  it("offers four distinct meanings with exactly one correct answer for every one of the actual 200 words", () => {
    expect(words).toHaveLength(200);
    for (const word of words) {
      const choices = wordChoices(word, words);
      expect(choices).toHaveLength(4);
      expect(new Set(choices).size).toBe(4);
      expect(choices.filter((c) => c === word.meaning)).toHaveLength(1);
    }
  });
  it("keeps practice choices stable across renders and distributes the correct position", () => {
    const positions = new Set<number>();
    for (const word of words) {
      const choices = wordChoices(word, words);
      expect(wordChoices(word, words)).toEqual(choices);
      positions.add(choices.indexOf(word.meaning));
    }
    expect(positions.size).toBe(4);
  });
  it("links weak RC types to the matching part rather than an empty Part 5 filter", () => {
    expect(practiceLink("reading-cross-document")).toBe("/practice?kind=PART7");
    expect(practiceLink("text-connector")).toBe("/practice?kind=PART6");
    expect(practiceLink("be")).toContain("grammar=be");
    expect(grammarName("reading-cross-document")).toBe("여러 문서 연결하기");
  });
});
