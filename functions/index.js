const functions = require("firebase-functions");

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
exports.success = functions.https.onRequest((request, response) => {
  response.send(request.body);
});


exports.fail = functions.https.onRequest((request, response) => {
  response.send(request.body);
});
