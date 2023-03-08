let ndefLibrary = require('./node_modules/ndef-lib/dist/ndef-lib');
const fs = require('node:fs');

// Create NDEF Message
var ndefMessage = new ndefLibrary.NdefMessage();

// Create NDEF Text Record
var ndefTextRecord = new ndefLibrary.NdefTextRecord();
// Set Uri in record
ndefTextRecord.setText("No need for paper");


// Create NDEF Uri Record
var ndefUriRecord = new ndefLibrary.NdefUriRecord();
// Set Uri in record
ndefUriRecord.setUri("https://www.nonereceipt.com");


// Add records to message
ndefMessage.push(ndefUriRecord);
ndefMessage.push(ndefTextRecord);


// Get byte array for NFC tag
var ndefByteArray = ndefMessage.toByteArray();

console.log('NDEF message:');
console.log(ndefMessage);
console.log('Byte array:');
console.log(ndefByteArray);

// create buffer from byte array
const data = Buffer.from(ndefByteArray);


// write to binary file
fs.writeFile('raspi/ndef.bin', data, (err) => {
  if (err) throw err;
  console.log('Bytes written to file!');
});

// Write byte array to file
//fs.writeFileSync('ndef_message.bin', ndefByteArray);
//console.log('NDEF message written to ndef_message.bin');