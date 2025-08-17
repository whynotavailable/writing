import fs from 'fs';

const bucketSize = 6;

let sourceFileName = process.argv[2]!;

interface Article {
  title: string;
  num: number;
  catagory: string;
  path: string;
}

let contents = fs.readFileSync(sourceFileName, { encoding: 'utf-8' });

let fileList: Article[] = contents
  .split("\n")
  .map(x => x.trim())
  .filter(x => x !== "")
  .map<Article>(file => {
    let fileParts = file.split("/");
    let fileNameParts = fileParts[fileParts.length - 1]!.split('_');
    return {
      title: fileNameParts[1]!,
      num: parseInt(fileNameParts[0]!),
      catagory: fileParts[fileParts.length - 2]!,
      path: file
    }
  })
  .sort((a, b) => b.num - a.num)

let currentBucket: Article[] = [];
let index: Article[][] = [currentBucket];

for (let file of fileList) {
  if (currentBucket.length >= bucketSize) {
    currentBucket = []
    index.push(currentBucket)
  }

  currentBucket.push(file)
}

fs.writeFileSync(`${sourceFileName}.json`, JSON.stringify(index, null, '  '))
