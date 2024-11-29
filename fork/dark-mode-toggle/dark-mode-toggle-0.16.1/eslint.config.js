// eslint.config.js
module.exports = [
  {
    languageOptions: {
      ecmaVersion: 8,
      sourceType: 'module',
    },
    rules: {
      'require-jsdoc': 'off',
      'max-len': [
        'error',
        {
          ignoreTemplateLiterals: true,
        },
      ],
    },
  },
];
