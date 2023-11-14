const txoConfig = require('eslint-config-txo-typescript')

/** @type {import('eslint').Linter.FlatConfig[]} */
const config = [
  ...txoConfig.default,
  {
    ignores: [
      'babel.config.js',
      'example/babel.config.js',
      'example/index.js',
      'example/metro.config.js',
      'example/node_modules',
      'example/react-native.config.js',
      'scripts',
    ],
  },
  {
    files: ['example/src/**/*.ts', 'example/src/**/*.tsx'],
    languageOptions: {
      parserOptions: {
        project: './example/tsconfig.json',
      },
    },
  },
]

module.exports = config
