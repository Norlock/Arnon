// Snowpack Configuration File
// See all supported options: https://www.snowpack.dev/reference/configuration

/** @type {import("snowpack").SnowpackUserConfig } */
module.exports = {
  mount: {
    src: "/dist",
    public: "/"
  },
  plugins: [
    'snowpack-plugin-elm',
    '@snowpack/plugin-sass'
  ],
  packageOptions: {
    /* ... */
  },
  devOptions: {
    /* ... */
  },
  buildOptions: {
    /* ... */
  },
  routes: [
    { match: "routes", src: ".*", dest: "/index.html" }
  ]
};
