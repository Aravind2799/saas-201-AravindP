# E2E Test Project

Collection of 50p tests for Milestone 2

Please replace the index.html under src folder with your code

Please ensure that an index.html is present. Also, the tests have been written with the given mocks and filenames as the pattern. Any deviations will result in test failures

Further,

1. For linking between pages, you need to use anchor tags with relative href. 

	<a href='index.html'> Go back <\a>

2. It's mandatory to use form concepts for building the request forms

## Installation

1. install nvm
2. Run the following command `nvm install 10.13.0`
3. run `npm install` to install dependencies
4. `npm test` -> To run the tests


## Available Automation Commands
- `npm test` - run tests in command-line
- `npm run test:debug` - run tests in command-line and in browser


## Note
You can pass additional arguments to pass to the browser instance by using env variable `PUPPETEER_LAUNCHER_ARGS` like:
```
npx cross-env PUPPETEER_RUN_IN_BROWSER=true PUPPETEER_LAUNCHER_ARGS="--start-maximized --ignore-certificate-errors" jest
```
[List of Chromium Command Line Switches](https://peter.sh/experiments/chromium-command-line-switches/)

Use `PUPPETEER_DEVTOOLS` env variable to enable DevTools