'use strict';
// Makes an existing account an admin. Run it on the computer where Outfitora runs: MAKE-ADMIN.bat
const readline = require('readline');
const db = require('./db');

function makeAdmin(email) {
  const e = String(email || '').trim().toLowerCase();
  if (!e) { console.log('No email was given.'); return 1; }
  const u = db.prepare('SELECT id, name FROM users WHERE email=?').get(e);
  if (!u) { console.log(`There is no account with the email ${e} yet.\nFirst sign up on the website with that email, then run this again.`); return 1; }
  db.prepare("UPDATE users SET role='admin' WHERE id=?").run(u.id);
  console.log(`Done. ${u.name} (${e}) is now an admin.\nLog out and log in again. You will see "Admin" in the left menu.`);
  return 0;
}

if (process.argv[2]) process.exit(makeAdmin(process.argv[2]));
const rl = readline.createInterface({ input: process.stdin, output: process.stdout });
rl.question('Type the email of the account that should be admin: ', (a) => { rl.close(); process.exit(makeAdmin(a)); });
