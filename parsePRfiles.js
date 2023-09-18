const fs = require('fs');
const readline = require('readline')

async function extractTests1() {

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
        for await (let f1 of f) {
            console.log(f1)

            if (f1.includes('/')) {
                f1 = f1.slice(str.lastIndexOf('/') + 1).split('.')[0];
            } else {
                f1 = f1.split('.')[0]
            }
            console.log(f1)

            await fs.promises.writeFile(testsFile, f1);
            await fs.promises.appendFile(testsFile, '\n');
        }

        //remove after dot 


    }

}

extractTests1();