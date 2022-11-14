const functions = require("firebase-functions");
const stripe = require("stripe")("sk_test_TqX0Y9mcG2no0LKyG7lpuhmd00gcglhtbc");

const endpointSecret = "whsec_OOuIVyOwRjGcGbw6VgggTdDu0yHOlorZ";

exports.webhook = functions.https.onRequest((request, response) => {
  let event = request.body;
  // Only verify the event if you have an endpoint secret defined.
  // Otherwise use the basic event deserialized with JSON.parse
  if (endpointSecret) {
    // Get the signature sent by Stripe
    const signature = request.headers["stripe-signature"];
    try {
      event = stripe.webhooks.constructEvent(
          request.rawBody,
          signature,
          endpointSecret
      );
    } catch (err) {
      console.log("⚠️  Webhook signature verification failed.", err.message);
      return response.send(err.message);
    }
  }

  // Handle the event
  switch (event.type) {
    case "customer.subscription.created": {
      const data =event.data.object;
      console.log(data.amount);
      response.send(data.status);
      break;
    }
    // handle subscription update
    case "customer.subscription.updated": {
      const data =event.data.object;
      console.log(data.amount);
      response.send(data.status);
      break;
    }
    default:
      // Unexpected event type
      console.log("Unhandled event type ${event.type}.");
  }

  // Return a 200 response to acknowledge receipt of the event
  response.send(event.type);
});
