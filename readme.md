# HoopBreak -- Find Pickup Games
Chill, take a break from your work, and play some pickup basketball! Whether you are a competitive hooper who wants to play intense, organized pickup games to improve your skills or a casual who is looking to have fun and meet new ballers in your area, Hoop Break has something for you. 

## Our Stack
The language we used to build this project was Apple's Swift programming language. Aside from Swift, we also used Firebase's asynchronous database to store user profile and chat information, court information, and game logs. To monetize the app, we also implemented non-obtrusive apps, using Google Analytics, which we built in the form of occasional pop-up and video ads. We also designed a [website] (www.hoopbreakllc.com) in HTML, CSS, and Node.js to market the app and get it featured on local newspapers like NBC4Washington and LocalDMV.

## Why we built the app
Hoopbreak offers a promising solution to basketball game organizing. It is an intuitive and responsive organizing tool out there for planning out pickup games on nearby courts and even enables you to meet new basketball players, so you can extend your hooping circle. In an age where the media, political and religious forces, and other institutions end up dividing us, Hoop Break intends to do the exact opposite. Our goal is not only to allow users to easily join and schedule games, but to also help them forge meaningful relationships and learn life skills through pickup basketball.

## Challenges we ran into
Every app has its own set of challenges. Here, the two biggest ones were dealing with 1) asychronous database calls and 2) creating storyboards for our screens. We dealt with problem one by reading up on how to make asynchronous calls in Swift, and we ended up using promises to execute synchronize code as soon as the asynchronous code finished running. This was super useful for popping up ads and fetching data for certain screens from a database. The second problem was also solved by watching YouTube tutorials (CodeWithChris is a fantastic one) that walked us step-by-step on how to create screens as storyboards and update information on the storyboards dynamically through code. 

## What's next for HoopBreak
We hope to release companion apps for other sports including soccer and football. In addition, we also plan to release new features to the app like a leaderboard system to rank the best teams in the area and a messaging section of the app to text fellow hoopers.

