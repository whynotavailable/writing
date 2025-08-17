import { Database } from "bun:sqlite";

const database = new Database('./data.db', {
  strict: true,
});

function getVersion(): number {
  const tables = database.query(`SELECT name FROM sqlite_master WHERE type='table' AND name='config'`).all();

  if (tables.length === 0) {
    return 0;
  }

  const val = database.query(`SELECT value FROM config WHERE key = 'migration'`).all() as { value: string }[];

  if (val.length === 0) {
    throw new Error("Data broken");
  }

  return parseInt(val[0]!.value);
}

function setVersion(version: number) {
  const query = database.query(`
INSERT INTO config (key, value)
VALUES ('migration', $version)
ON CONFLICT (key) DO UPDATE SET
    value = excluded.value;
`).all({
    version: version.toString()
  })
}

let versions: (() => void)[] = [];

versions.push(() => {
  database.run(`
CREATE TABLE config (
  key TEXT NOT NULL PRIMARY KEY,
  value TEXT NOT NULL
)
`)
})

export function migrate() {
  const version = getVersion();
  if (version <= versions.length) {
    for (let i = version; i < (versions.length); i++) {
      console.log('Running ${i}')
      versions[i]!();
      setVersion(version + 1);
    }
  }
}
