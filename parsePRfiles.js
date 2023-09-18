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
        let f = line.split('###')
        for (let f1 of f) {
            await fs.promises.writeFile(testsFile, f);
            await fs.promises.appendFile(f, '\n');
        }
        console.log(line.split("/").pop().split(".")[0]);
        let fileName = line.split("/").pop().split(".")[0];
        //remove after dot 


    }

}

extractTests();