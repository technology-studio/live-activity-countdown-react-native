module.exports = (async function config() {
  const txoPackageConfigList = await import('eslint-config-txo-package-react')
  return [
    ...txoPackageConfigList.configList,
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
})()
