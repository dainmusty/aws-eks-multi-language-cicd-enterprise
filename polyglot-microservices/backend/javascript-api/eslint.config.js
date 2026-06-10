module.exports = [
  {
    files: ["src/**/*.js"],
    languageOptions: {
      ecmaVersion: "latest",
      sourceType: "commonjs"
    },
    rules: {
      semi: ["error", "always"],
      quotes: ["error", "single"]
    }
  }
];