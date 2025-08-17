import path from 'path'
import fs from 'fs'
import type { Article } from './process-index';

let sourceFileName = process.argv[2]!;

let indexName = path.basename(sourceFileName).replace(path.extname(sourceFileName), "");

let index: Article[] = JSON.parse(fs.readFileSync(sourceFileName, 'utf-8'))

for (let i = 0; i < index.length; i++) {
  let pageName = ``;

  if (i === 0) {
    pageName = indexName;
  } else {
    pageName = `${indexName}_${i}`;
  }

  if (pageName === 'main') {
    pageName = 'index';
  }

  fs.writeFileSync(`./docs/${pageName}.html`, 'hi', 'utf-8');
}
