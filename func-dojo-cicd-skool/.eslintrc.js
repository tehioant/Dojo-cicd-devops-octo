// `.eslintrc.js
module.exports = {
    parser: '@typescript-eslint/parser', // Parse TypeScript
    parserOptions: {
        project: './tsconfig.json',
        jsx: false // True for React
    },

    rules: {
        /* disable or configure individual rules */
    },

  plugins: [
    "@typescript-eslint"
  ],
    // Use the rules from these plugins
    extends: [
        'plugin:@typescript-eslint/recommended',
        'airbnb',
      'plugin:prettier/recommended',
      'plugin:sonarjs/recommended',
      'prettier',
      // 'plugin:react/recommended' // If we need React
    ]
};