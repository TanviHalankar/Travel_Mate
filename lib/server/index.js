const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const db = require('./db');
const multer = require('multer');
const path = require('path');


const app = express();
app.use(bodyParser.json());
app.use(cors());

// Define routes for CRUD operations
const PORT = process.env.PORT || 9000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});


//// Configure Multer for file uploads
//const storage = multer.diskStorage({
//  destination: (req, file, cb) => {
//    cb(null, 'uploads/'); // Set the destination folder for uploaded files
//  },
//  filename: (req, file, cb) => {
//    cb(null, Date.now() + path.extname(file.originalname)); // Generate a unique filename
//  },
//});
//
//const upload = multer({ storage });
//
//
//// Endpoint for profile picture upload
//app.post('/users/profile-picture', upload.single('profilePicture'), (req, res) => {
//  if (!req.file) {
//    return res.status(400).json({ error: 'No file uploaded' });
//  }
//
//  // Process the uploaded file, save the URL in the database, and return the URL
//  const profilePictureUrl = req.file.path;
//  res.json({ profilePictureUrl });
//});
//
//// Endpoint for updating user profile (including profile picture)
//app.put('/users/profile/:id', (req, res) => {
//  const userId = req.params.id;
//  const { username, email, phone_num, country, profilePictureUrl } = req.body;
//
//  // Update user data in the database
//  db.run(
//    'UPDATE users SET username = ?, email = ?, phone_num = ?, country = ?, profile_picture = ? WHERE id = ?',
//    [username, email, phone_num, country, profilePictureUrl, userId],
//    (err) => {
//      if (err) {
//        return res.status(500).json({ error: err.message });
//      }
//      res.json({ message: 'Profile updated successfully' });
//    }
//  );
//});


//// Endpoint for user registration (without profile picture)
//app.post('/users', (req, res) => {
//  const { username, password,email, phone_num, country,uid} = req.body;
//
//  // Insert user data into the database
//  db.run(
//    'INSERT INTO users (username, password,email, phone_num, country,uid) VALUES (?, ?, ?, ?,?,?)',
//    [username, password,email, phone_num, country,uid],
//    function (err) {
//      if (err) {
//        return res.status(500).json({ error: err.message });
//      }
//      res.json({ id: this.lastID });
//    }
//  );
//});

//Create a post
//app.post('/posts', (req, res) => {
// console.log('Received POST request:', req.body);
//  const { location,description,duration,category,budget,uid} = req.body;
//  db.run('INSERT INTO posts (location,description,duration,category,budget,uid) VALUES (?,?,?,?,?,?)', [location,description,duration,category,budget,uid], function (err) {
//    //,description,season,duration,category,budget
//    //,?,?,?,?,?,?
//    if (err) {
//      return res.status(500).json({ error: err.message });
//    }
//    res.json({ id: this.lastID });
//  });
//});

//Create a post
app.post('/members', (req, res) => {
 console.log('Received members request:', req.body);
  const { tripId,ownerId,memberId,status,userName,fullName,age,phnum,residence,gender} = req.body;
  db.run('INSERT INTO members (tripId,ownerId,memberId,status,userName,fullName,age,phnum,residence,gender) VALUES (?,?,?,?,?,?,?,?,?,?)', [tripId,ownerId,memberId,status,userName,fullName,age,phnum,residence,gender], function (err) {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json({ id: this.lastID });
  });
});

// Set up Multer storage
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/'); // Save the uploaded files to the 'uploads' directory
  },
  filename: function (req, file, cb) {
    const ext = path.extname(file.originalname);
    cb(null, Date.now() + ext); // Rename the file to avoid overwriting
  },
});

const upload = multer({ storage: storage });
//Add Users(with profilePic)
app.post('/users', upload.single('profilePic'), (req, res) => {
  console.log('Received Users request:', req.body);

  const { username, password,email, phone_num, country,uid} = req.body;

  // Assuming 'image' is the name attribute of the file input in your form
  const imagePath = req.file.path;

  db.run(
    'INSERT INTO users (username, password,email, phone_num, country,uid,profilePic) VALUES (?,?,?,?,?,?,?)',
    [username, password,email, phone_num, country,uid,imagePath],
    function (err) {
      if (err) {
        return res.status(500).json({ error: err.message });
      }
      res.json({ id: this.lastID });
    }
  );
});
// Add Trips
app.post('/trips', upload.single('coverPhoto'), (req, res) => {
  console.log('Received Trips request:', req.body);

  const { title, desc, startDate, endDate, age1, age2, ownerId ,ownerPhn} = req.body;

  // Assuming 'image' is the name attribute of the file input in your form
  const imagePath = req.file.path;

  db.run(
    'INSERT INTO trips (title, desc, startDate, endDate, age1, age2, ownerId, ownerPhn,coverPhoto) VALUES (?,?,?,?,?,?,?,?,?)',
    [title, desc, startDate, endDate, age1, age2, ownerId,ownerPhn,imagePath],
    function (err) {
      if (err) {
        return res.status(500).json({ error: err.message });
      }
      res.json({ id: this.lastID });
    }
  );
});

//Add posts
app.post('/posts', upload.single('postCover'), (req, res) => {
  console.log('Received Posts request:', req.body);

  const {location,description,duration,category,budget,uid} = req.body;

  // Assuming 'image' is the name attribute of the file input in your form
  const imagePath = req.file.path;

  db.run(
    'INSERT INTO posts (location,description,duration,category,budget,uid,postCover) VALUES (?,?,?,?,?,?,?)',
    [location,description,duration,category,budget,uid,imagePath],
    function (err) {
      if (err) {
        return res.status(500).json({ error: err.message });
      }
      res.json({ id: this.lastID });
    }
  );
});

// Retrieve Trips
app.get('/trips', (req, res) => {
  db.all('SELECT * FROM trips', (err, rows) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json(rows);
  });
});

// Retrieve a single trip by ID
app.get('/trips/:tripId', (req, res) => {
  const tripId = req.params.tripId;
  db.get('SELECT * FROM trips WHERE tripId = ?', [tripId], (err, row) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json(row);
  });
});

// Retrieve all members by tripId
app.get('/members/:tripId', (req, res) => {
  const tripId = req.params.tripId;
  db.all('SELECT * FROM members WHERE tripId = ?', [tripId], (err, rows) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json(rows);
  });
});

// Retrieve  member by tripId and memberId
app.get('/members/:tripId/:memberId', (req, res) => {
  const { memberId, tripId } = req.params;
  db.get('SELECT * FROM members WHERE tripId = ? and memberId = ?', [tripId, memberId], (err, row) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json(row);
  });
});

 // Update member status by ID
 app.put('/members/:memberId/:tripId', (req, res) => {
   const { memberId,tripId } = req.params;
   const { status } = req.body;
   db.run('UPDATE members SET status = ? WHERE memberId = ? and tripId=? ', [status, memberId,tripId], function (err) {
     if (err) {
       return res.status(500).json({ error: err.message });
     }
     res.json({ changes: this.changes });
   });
 });
// Delete member by ID
app.delete('/members/:memberId/:tripId', async (req, res) => {
  try {
    const { memberId, tripId } = req.params;

    // Ensure memberId and tripId are valid before proceeding with the deletion

    const result = await db.run('DELETE FROM members WHERE memberId = ? AND tripId = ?', [memberId, tripId]);

    if (result.changes > 0) {
      res.json({ deleted: true });
    } else {
      res.status(404).json({ error: 'Member not found' });
    }
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.use('/uploads', express.static(path.join(__dirname, 'uploads')));
////Add Trips
//app.post('/trips', (req, res) => {
// console.log('Received Trips request:', req.body);
//  const {title, desc, startDate, endDate,age1,age2,ownerId} = req.body;
//  db.run('INSERT INTO trips (title, desc, startDate, endDate,age1,age2,ownerId) VALUES (?,?,?,?,?,?,?)', [title, desc, startDate, endDate,age1,age2,ownerId], function (err) {
//    //,description,season,duration,category,budget
//    //,?,?,?,?,?,?
//    if (err) {
//      return res.status(500).json({ error: err.message });
//    }
//    res.json({ id: this.lastID });
//  });
//});
// Add a season
app.post('/seasons', (req, res) => {
console.log('Received Season request:', req.body);
  const { season_name,postId} = req.body;
  db.run('INSERT INTO seasons (season_name,postId) VALUES (?,?)', [season_name,postId], function (err) {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json({ id: this.lastID });
  });
});


//Add itinerary
app.post('/itinerary', (req, res) => {
console.log('Received Itinerary request:', req.body);
  const { postId,location,duration,uid} = req.body;
  db.run('INSERT INTO itinerary (postId,location,duration,uid) VALUES (?,?,?,?)', [postId,location,duration,uid], function (err) {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json({ id: this.lastID });
  });
});

////Add places
//app.post('/place3', (req, res) => {
//console.log('Received Places request:', req.body);
//  const {pid,pname,time,itid} = req.body;
//  db.run('INSERT INTO place (pid,pname,time,itid) VALUES (?,?,?,?)', [pid,pname,time,itid], function (err) {
//    if (err) {
//      return res.status(500).json({ error: err.message });
//    }
//    res.json({ id: this.lastID });
//  });
//});

//Add times
app.post('/places', (req, res) => {
console.log('Received places request:', req.body);
  const { postId,dayNum,place} = req.body;
  db.run('INSERT INTO places (postId,dayNum,place) VALUES (?,?,?)', [postId,dayNum,place], function (err) {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json({ id: this.lastID });
  });
});

//Add times
app.post('/times', (req, res) => {
console.log('Received times request:', req.body);
  const { postId,dayNum,time} = req.body;
  db.run('INSERT INTO times (postId,dayNum,time) VALUES (?,?,?)', [postId,dayNum,time], function (err) {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json({ id: this.lastID });
  });
});

//Get Post details
app.get('/posts', (req, res) => {
  // Query the database to retrieve a list of posts
  db.all('SELECT * FROM posts', (err, rows) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    // If successful, send the list of posts as a JSON response
    res.json(rows);
  });
});

 // trending
// Fetch posts with the highest likes
app.get('/posts/trending', (req, res) => {
  db.all('SELECT * FROM posts ORDER BY likes DESC', (err, rows) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json(rows);
  });
});

 // Show posts by uid
app.get('/posts/:uid', (req, res) => {
  console.log('Received posts by uid request:', req.params.uid);
  const uid = req.params.uid;
  db.all('SELECT * FROM posts WHERE uid = ?', [uid], (err, rows) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json(rows);
  });
});

 // Show posts by id
app.get('/posts/postId/:postId', (req, res) => {
  console.log('Received post by postId request:', req.params.postId);
  const postId = req.params.postId;
  db.all('SELECT * FROM posts WHERE postId = ?', [postId], (err, rows) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json(rows);
  });
});

//get profile pic of post
app.get('/users/profilePic/:postId', (req, res) => {
  console.log('Received profile pic of post request:', req.params.postId);
  const postId = req.params.postId;
  db.all('select profilePic from users where uid=(select uid from posts where postId= ?)', [postId], (err, rows) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json(rows);
  });
});

 // Show posts by category
app.get('/posts/category/:category', (req, res) => {
  console.log('Received posts by category request:', req.params.category);
  const category = req.params.category;
  db.all('SELECT * FROM posts WHERE category = ?', [category], (err, rows) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json(rows);
  });
});

 // Show trips by name
app.get('/trips/title/:title', (req, res) => {
  console.log('Received trips by title request:', req.params.title);
  const title = req.params.title;
  db.all('SELECT * FROM trips WHERE title = ?', [title], (err, rows) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json(rows);
  });
});


 // Show posts by uid
app.get('/users/:uid', (req, res) => {
  console.log('Received users by uid request:', req.params.uid);
  const uid = req.params.uid;
  db.all('SELECT * FROM users WHERE uid = ?', [uid], (err, rows) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json(rows);
  });
});

app.get('/seasons', (req, res) => {
console.log('Received seasons');
  const postId = req.query.postId; // Get the postId from the query parameter
  // Query the database to retrieve a list of seasons associated with the given postId
  db.all('SELECT * FROM seasons WHERE postId = ?', [postId], (err, rows) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    // If successful, send the list of seasons as a JSON response
    res.json(rows);
  });
});

app.get('/itinerary', (req, res) => {
console.log('Received iti');
  const postId = req.query.postId; // Get the postId from the query parameter
  // Query the database to retrieve a list of seasons associated with the given postId
  db.all('SELECT * FROM itinerary WHERE postId = ?', [postId], (err, rows) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    // If successful, send the list of seasons as a JSON response
    res.json(rows);
  });
});

app.get('/places', (req, res) => {
console.log('Received places');
  const postId = req.query.postId; // Get the postId from the query parameter
  db.all('SELECT * from places where postId = ?', [postId], (err, rows) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json(rows);
  });
});

app.get('/times', (req, res) => {
console.log('Received times');
  const postId = req.query.postId; // Get the postId from the query parameter
  db.all('SELECT * from times WHERE postId = ?', [postId], (err, rows) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json(rows);
  });
});

// Endpoint to follow a user
app.post('/follow', (req, res) => {
  const { id, follower_uid, following_uid } = req.body;

  // Retrieve current followers list for the user
  db.get('SELECT followers FROM users WHERE uid = ?', [following_uid], (err, row) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }

    // Deserialize the JSON or CSV string to a JavaScript array
    const followersArray = JSON.parse(row.followers || '[]');

    // Add the new follower UID to the array if it's not already there
    if (!followersArray.includes(follower_uid)) {
      followersArray.push(follower_uid);

      // Serialize the updated array back to JSON format
      const updatedFollowers = JSON.stringify(followersArray);

      // Update the followers column in the database
      db.run('UPDATE users SET followers = ? WHERE uid = ?', [updatedFollowers, following_uid], (err) => {
        if (err) {
          return res.status(500).json({ error: err.message });
        }

        res.json({ message: 'Successfully followed user' });
      });
    } else {
      res.json({ message: 'Already following this user' });
    }
  });
});

// Endpoint to unfollow a user
app.post('/unfollow', (req, res) => {
  const { id, follower_uid, following_uid } = req.body;

  // Retrieve current followers list for the user
  db.get('SELECT followers FROM users WHERE uid = ?', [following_uid], (err, row) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }

    // Deserialize the JSON or CSV string to a JavaScript array
    const followersArray = JSON.parse(row.followers || '[]');

    // Remove the follower UID from the array if it's there
    const updatedFollowers = followersArray.filter((uid) => uid !== follower_uid);

    // Serialize the updated array back to JSON format
    const updatedFollowersJson = JSON.stringify(updatedFollowers);

    // Update the followers column in the database
    db.run('UPDATE users SET followers = ? WHERE uid = ?', [updatedFollowersJson, following_uid], (err) => {
      if (err) {
        return res.status(500).json({ error: err.message });
      }

      res.json({ message: 'Successfully unfollowed user' });
    });
  });
});

//like post
app.post('/posts/like/:postId', (req, res) => {
  const postId = req.params.postId;
  db.run('UPDATE posts SET likes = likes + 1 WHERE postId = ?', [postId], (err) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json({ message: 'Post liked successfully' });
  });
});

//unlike post
app.post('/posts/unlike/:postId', (req, res) => {
  const postId = req.params.postId;
  db.run('UPDATE posts SET likes = likes - 1 WHERE postId = ?', [postId], (err) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json({ message: 'Post unliked successfully' });
  });
});


//app.post('/follow', (req, res) => {
//  const { followerUid, followingUid } = req.body;
//
//  db.run('INSERT INTO followers (follower_uid, following_uid) VALUES (?, ?)', [followerUid, followingUid], (err) => {
//    if (err) {
//      return res.status(500).json({ error: err.message });
//    }
//    res.json({ message: 'User followed successfully' });
//  });
//});
//
//
//app.post('/unfollow', (req, res) => {
//  const { followerUid, followingUid } = req.body;
//
//  db.run('DELETE FROM followers WHERE follower_uid = ? AND following_uid = ?', [followerUid, followingUid], (err) => {
//    if (err) {
//      return res.status(500).json({ error: err.message });
//    }
//    res.json({ message: 'User unfollowed successfully' });
//  });
//});
//
//app.get('/followers/:uid', (req, res) => {
//  const uid = req.params.uid;
//
//  db.all('SELECT follower_uid FROM followers WHERE following_uid = ?', [uid], (err, rows) => {
//    if (err) {
//      return res.status(500).json({ error: err.message });
//    }
//    const followers = rows.map((row) => row.follower_uid);
//    res.json({ followers });
//  });
//});
//
//
//app.get('/following/:uid', (req, res) => {
//  const uid = req.params.uid;
//
//  db.all('SELECT following_uid FROM following WHERE follower_uid = ?', [uid], (err, rows) => {
//    if (err) {
//      return res.status(500).json({ error: err.message });
//    }
//    const following = rows.map((row) => row.following_uid);
//    res.json({ following });
//  });
//});


//app.get('/itinerary/:uid', (req, res) => {
//  console.log('Received itinerary by uid request:', req.params.uid);
//  const uid = req.params.uid;
//  db.all('SELECT * FROM itinerary WHERE uid = ?', [uid], (err, rows) => {
//    if (err) {
//      return res.status(500).json({ error: err.message });
//    }
//    res.json(rows);
//  });
//});
//
//app.get('/places/:uid', (req, res) => {
//  console.log('Received places by uid request:', req.params.uid);
//  const uid = req.params.uid;
//  db.all('Select * from places where uid=?;', [uid], (err, rows) => {
//    if (err) {
//      return res.status(500).json({ error: err.message });
//    }
//    res.json(rows);
//  });
//});

// Read all items
//app.post('/post', (req, res) => {
//  console.log('Received POST request:', req.body);
//  const { location, description, season, duration, category, budget } = req.body;
//
//  // Check if the season exists in the seasons table
//  db.get('SELECT id FROM seasons WHERE season_name = ?', [season], (err, seasonRow) => {
//    if (err) {
//      return res.status(500).json({ error: err.message });
//    }
//
//    if (!seasonRow) {
//      // If the season doesn't exist, return an error
//      return res.status(400).json({ error: 'Season not found' });
//    }
//
//    // Season exists, retrieve its id
//    const season_id = seasonRow.id;
//
//    // Insert the post with the retrieved season_id
//    db.run(
//      'INSERT INTO post (location, description, season, duration, category, budget, season_id) VALUES (?, ?, ?, ?, ?, ?, ?)',
//      [location, description, season, duration, category, budget, season_id],
//      function (err) {
//        if (err) {
//          return res.status(500).json({ error: err.message });
//        }
//        res.json({ id: this.lastID });
//      }
//    );
//  });
//});


// // Update an item by ID
// app.put('/items/:id', (req, res) => {
//   const { id } = req.params;
//   const { name } = req.body;
//   db.run('UPDATE items SET name = ? WHERE id = ?', [name, id], function (err) {
//     if (err) {
//       return res.status(500).json({ error: err.message });
//     }
//     res.json({ changes: this.changes });
//   });
// });

// // Delete an item by ID
// app.delete('/items/:id', (req, res) => {
//   const { id } = req.params;
//   db.run('DELETE FROM items WHERE id = ?', [id], function (err) {
//     if (err) {
//       return res.status(500).json({ error: err.message });
//     }
//     res.json({ deleted: this.changes });
//   });
// });

