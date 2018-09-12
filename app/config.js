const Web3 = require('web3')
const definition = require('../build/contracts/Daq.json')
const config = require('../config.json')

const abi = definition.abi
const contractAddress = config.contractAddress || definition.networks[Object.keys(definition.networks)[0]].address

const web3 = new Web3(config.endpoint || Web3.givenProvider || 'ws://localhost:8545')
const daq = new web3.eth.Contract(abi, contractAddress, {from: config.sender, gas: '2000000'})

config.daq = daq
config.web3 = web3

module.exports = config
