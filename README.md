# daq
Decentralize QA system base on Ethereum.
## Dependency
* [nodejs](https://nodejs.org/en/)
* [ganache-cli](https://github.com/trufflesuite/ganache-cli)
* [truffle](https://truffleframework.com/)
## Installation
~~~
git clone https://github.com/pplam/daq.git && cd daq && npm install
~~~
## Usage
Run `ganache-cli` first
~~~
ganache-cli -a 3
~~~
On another shell run
~~~
npm run migrate
~~~
Then set configurations in `config.json` and finally run
~~~
npm run put
~~~
