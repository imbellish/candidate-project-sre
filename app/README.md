# app
A simple Express web server that outputs "Hello world!" as a JSON message.

## Configuration
The following characteristics are configurable in the application through
environment variables. Create a `.env` file to control the configuration.

|Variable|Required|Default|Description|
|---|:-:|---|---|
|MESSAGE|F|"Hello world!"|Friendly message|
|PORT|F|3000|Server port|

## Usage

### Run
Launch the server.

```bash
npm start
```

### Test
Test the server.

```bash
npm test
```
