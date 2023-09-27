const sqlite3 = require('sqlite3').verbose();
const db = new sqlite3.Database('TravelMate.db');

db.serialize(() => {
db.run(`
  CREATE TABLE IF NOT EXISTS posts(
    postId INTEGER PRIMARY KEY,
    location TEXT,
    description TEXT,
    duration TEXT,
    category TEXT,
    budget DOUBLE,
    uid TEXT
  );
`);

db.run(`
CREATE TABLE IF NOT EXISTS seasons (
  season_id INTEGER PRIMARY KEY,
  season_name TEXT,
  postId INTEGER REFERENCES posts
);
`);

db.run(`
CREATE TABLE IF NOT EXISTS itinerary (
  itiId INTEGER PRIMARY KEY,
  postId INTEGER REFERENCES posts,
  duration TEXT,
  location TEXT,
  uid TEXT
);
`);

//db.run(`
//CREATE TABLE IF NOT EXISTS place (
//
//pid integer primary key,
//pname TEXT,
//time TEXT,
//itid integer references itinerary);
//)
//`);
db.run(`
CREATE TABLE IF NOT EXISTS times (
  postId INTEGER REFERENCES posts,
  dayNum INTEGER,
  time Text
);
`);
db.run(`
CREATE TABLE IF NOT EXISTS places (
  postId INTEGER REFERENCES posts,
  dayNum INTEGER,
  place Text
);
`);

//db.run(`
//      CREATE TABLE users (
//        id INTEGER PRIMARY KEY,
//        username TEXT,
//        password TEXT,
//        email TEXT,
//        phone_num TEXT,
//        country TEXT,
//        uid TEXT,
//        followers TEXT,
//        following TEXT
//      )
//`);
//db.run(
//`
//CREATE TABLE IF NOT EXISTS followers (
//  id INTEGER PRIMARY KEY,
//  follower_uid TEXT,
//  following_uid TEXT,
//  FOREIGN KEY (follower_uid) REFERENCES users (uid),
//  FOREIGN KEY (following_uid) REFERENCES users (uid)
//);
//`);

//db.run(
//`
//CREATE TABLE IF NOT EXISTS following (
//  id INTEGER PRIMARY KEY,
//  follower_uid TEXT,
//  following_uid TEXT,
//  FOREIGN KEY (follower_uid) REFERENCES users (uid),
//  FOREIGN KEY (following_uid) REFERENCES users (uid)
//);
//`);




});

module.exports = db;


// description TEXT,
// season TEXT,
// duration TEXT,
// category TEXT,
// budget INTEGER