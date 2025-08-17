import path from 'path'

let sourceFileName = process.argv[2]!;

let indexName = path.basename(sourceFileName).replace(path.extname(sourceFileName), "");

console.log(indexName)
