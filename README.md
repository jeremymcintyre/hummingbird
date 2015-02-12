# hummingbird

## The Original Pitch

Something just happened that your friend across the country would So appreciate, and you are burning to text them...but it's like 4am where he is; he's probably asleep. A good friend of yours has an interview next Tuesday, you're already know you're going to be slammed at work, and you want to make sure you remember to text her and check in. You and your friend just saw two celebrities get in a scuffle, and who knows, maybe you just want to send your friend a text that will be delivered a year from today, time capsule style? "That was craaaazyyy!"

Let's face it. You're a busy, modern, hardworking person, but you want to do all these things, why? Cause you care.

Enter hummingbird. Pick a time and date, type your message, and send it. It will flit into the ether only to come humming back to its final destination at the designated date and time.

## Mission (for MVP)

To build a fun, usable app that does one thing and does it well.
We will aim to get our MVP working first, before attacking any further features.


## Values
- Constant and open communication
- Learning while we work
- Design choices based on code quality over trendiness

## Agreements
- We will be here for core hours pairing together
- Standups: 9am, 2pm, and 6pm (initial schedule)
- Afterhours is for diving deeper, ironing out sticking points, and preventing burnout

## User Stories
A user can use their phone (their phone number) to send a text message that will be delivered at the specified date and time.


### Stretch user stories
- oAuth with google - get contact numbers
- can send a voice message
- can send images
- a user can cancel a message (?)
- optional timestamp
- recurring/automated text messages


## Git workflow
Initially, each machine pulls from the remote master.
- When beginning a new feature, checkout a new branch. Work only on files related to this feature.
`git checkout -b yourbranchname`
- Make commits on the feature branch locally until the feature is done. Use imperative and be descriptive; use semicolons to separate thoughts. Commit often.

`git status`

`git add filename`

`git commit`

- When a convenient place is reached to push, push to feature branch

`git push -u origin yourbranchname`

- When finished with a feature, push to make sure remote feature branch has all commits

`git push`

- Pull request in GUI
- Once the pull request is OK'd, someone needs to merge it on their own machine, first making sure their own local master is up to date

`git checkout master`

`git pull`

`git pull origin thefeaturebranchtobemerged`

`git push`

- Now the remote master is up-to-date. Everyone pulls from remote master to local master, then checks out their feature branch and pulls from origin/master, and continues working.

`git checkout master`

`git pull`

`git checkout thebranchyouareworkingon`

`git pull origin master`

## Technologies