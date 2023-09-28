const fs = require('fs');
const readline = require('readline')

async function extractTests() {

    //by default we specify that all tests should run
    let testsFile = __dirname + '/compsToRun.txt';
    await fs.promises.writeFile(testsFile, 'all');

    const lines = readline.createInterface({
        input: fs.createReadStream(__dirname + '/components.txt'),
        crlfDelay: Infinity
    });

    for await (const line of lines) {
        //special delimeter for apex tests
        console.log(line.split("/").pop());
        let fileName = line.split("/").pop().split(".")[0];
        //remove after dot 

        await fs.promises.writeFile(testsFile, fileName);
        await fs.promises.appendFile(fileName, '\n');
    }

}

extractTests();