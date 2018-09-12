const config = require('./config')

const answer = 'This is the answer'
const hash = config.web3.utils.soliditySha3(answer)
const sig = config.web3.eth.accounts.sign(hash, config.privateKey)
const signature = sig.signature
console.log()
console.log('======================local signature======================')
console.log(sig)

config.daq.methods.put(answer, signature).send()
  .on('transactionHash', (txid) => {
    console.log()
    console.log('======================transaction id======================')
    console.log(txid)
  })
  .on('receipt', (data) => {
    console.log()
    console.log('======================contract events======================')
    const sender = data.events.Sender.returnValues.sender
    const signer = data.events.Signer.returnValues.signer
    console.log(`sender: ${sender}`)
    console.log(`signer: ${signer}`)
  })
  .on('confirmation', console.log)
  .on('error', console.error)
