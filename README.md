# hummingbird

## The Pitch

- Something just happened that a friend across the country would find hilarious, and you are burning to text him...but it's like 4am where he is; he's probably asleep.

- A good friend of yours has an interview next Tuesday, you already know you're going to be slammed at work, and you want to make sure you remember to text her and check in.

- You and your friend just saw two celebrities get in a scuffle, and maybe you just want to send your friend a commemorative text that will be delivered a year from today, time-capsule style?

Enter hummingbird. Pick a time and date, type your message, and send it. It will flit into the ether only to come humming back to its final destination at the designated date and time.

## Details About This Repo

This is the decoupled backend of the app, built in less than a week with Rails 4.2.0. The frontend repo is located [here](https://github.com/kaawang/hummingbird_frontend/).

Once downloaded, this backend requires setup with a .env file in the root directory. ENV variables are required for:

* TWILIO_ACCOUNT_SID
* TWILIO_AUTH_TOKEN
* TWILIO_NUMBER (the phone number provided by Twilio after registration)

* GOOGLE_CLIENT_ID and GOOGLE_CLIENT_SECRET for Google OAuth.