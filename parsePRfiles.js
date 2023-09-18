const fs = require('fs');
const readFile = require('readline')

async function extractTests() {

    //by default we specify that all tests should run
    let testsFile = __dirname + '/compsToRun.txt';
    fs.promises.writeFile(testsFile, 'all');

    const lines = readFile.createInterface({
        input: fs.createReadStream(__dirname + '/components.txt'),
        crlfDelay: Infinity
    });
    console.log(lines)

    //special delimeter for apex tests
    let f = lines.split('###')
    for (let f1 of f) {
        console.log(f1)
        fs.promises.writeFile(testsFile, f1);
        fs.promises.appendFile(testsFile, '\n');
    }

    //remove after dot 




}

extractTests();