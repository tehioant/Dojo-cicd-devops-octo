/** @type {import('ts-jest').JestConfigWithTsJest} */
module.exports = {
  coverageDirectory: './coverage',
  collectCoverageFrom: ['test/**/*.ts', 'test/**/*.tsx'],
  preset: 'ts-jest',
  testEnvironment: 'node',
  modulePaths: ['<rootDir>/test', 'node_modules'],
  roots: ['DojoCicdSkool/test'],
  transform: {
    '^.+\\.tsx?$': 'ts-jest'
  },
  testRegex: '(/__tests__/.*|\\.(test|spec))\\.(ts|tsx)$',
  coverageReporters: ['json', 'lcov', 'text'],
  //coveragePathIgnorePatterns: ['.*/src/.*\\.d\\.ts', '.*/src/testUtil/.*'],
  testResultsProcessor: 'jest-sonar-reporter',

  coverageThreshold: {
    global: {
      statements: 80,
      branches: 80,
      functions: 80,
      lines: 80
    }
  }
};