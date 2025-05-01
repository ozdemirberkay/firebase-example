const {onCall} = require("firebase-functions/v2/https");

exports.echoMessage = onCall((request) => {
  const message = request.data.message;

  const reply = message ? `Hello ${message}` : "Hello";
  return {received: reply};
});
