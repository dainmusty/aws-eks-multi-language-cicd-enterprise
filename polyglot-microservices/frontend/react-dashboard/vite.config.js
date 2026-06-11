import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  test: {
    globals: true,              // <-- enables global expect/test/describe
    environment: "jsdom",       // <-- simulates browser DOM
    setupFiles: "./src/setupTests.js"
  }
});
