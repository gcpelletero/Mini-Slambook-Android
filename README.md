# final mini project

**Name:** Gabrielle Pelletero <br/>
**Section:** U-2L <br/>
**Student number:** 2022 - 10580 <br/>

## Code Description

The user will be greeted with a log in page wherein it will ask the user for authentication. If they dont have an accout yet, they can sign up in the sign up page. The code contains a slambook page that allow users to record details of their friends. Then there is the friend list which displays each friend of the user who filled the slambook. The data will now be saved to the firestore database. Each friend is a clickable button which displays their details. The code implements features of adding a slambook entry, edit a slambook entry, and delete a slambook entry. Moreover, the user will be able to add a profile picture to the specific friend wither from their gallery or they take a picture. Each friend can also generte their own QR code containing their own details. This can be scanned by a QR scanner. The user will be able to scan someone elses QR code and add that friend to their personl friend list.

## Things you did in the code

I used my exercise 7 in the lab and continue from there. My program was almost complete, all I had to do was add some features. First, I added authentication for the app. The authentication involves on asking the user for their username and password. I just used the template in the lab example code and modified it to ask for username instead of an email. In the signup page, the user will be asked by their email and that email will be assigned to their username that they made thats why theyll be able to log in using their username only. For the sign up page, I also modified the lab example template and added more information needed for the users and from there, it will be recorded to the firestore database. I based my design on the authentication form on the internet especially how the text inputs and buttons are designed. In the drawer part, I addded a greeting together with the name of the user who is logged in. In the friends page, I used a sliverappbar for the appbar to look different from the usual. It will now scroll without changing its color and I am able to edit it height. In the friend details page, I adjusted the details of a friend to be displayed in a container neatly then in the bottom of the screen, there is a bottom navigation bar wherein it conatins all the buttons for taking a picture or gallery for the profile picture, to generate QR code , and edit details of the friend. I added a cover photo behind the profile picture by adding another container with no clip behavior. On generating a QR code, I used the packages qr_flutter and qr_code_scanner. In the slambook page, I just adjusted on how the text input fields are displayed. I copied the design of the text input fields from the sign up page input fields then there is a flaoting button that they can scan a QR code.

## Challenges encountered

I was having trouble on the authentication sepcifically the part on how can the user log in using their username. I was also having trouble how to add more details that is needed for the user to sign up. I was having trouble on the QR code beacuse I really didnt have any clue on how to implement it. In editing the details of the user, the dropdown superpower keeps going over the pixels and it took me long to adjust it for it to not overflow. I was having trouble for the app to run in the android phone because at first it doesnt recognize the package name. I added an app in the firebase to match the package name. I thought that was the end of it but considering I used a lot of packages, some of the packages did not match their versions with each other. Thus, I had to edit the gradle files, setting files the google-services file for it to be able to run in the phone.

## References

- https://stackoverflow.com/questions/35120939/username-authentication-instead-of-email/35121112#35121112
- https://docs.github.com/en/get-started/getting-started-with-git/managing-remote-repositories
- https://gist.github.com/gunjanpatel/18f9e4d1eb609597c50c2118e416e6a6
- https://stackoverflow.com/questions/59816770/what-is-the-difference-between-pushreplacementnamed-and-popandpushnamed-in-flutt
- https://medium.com/@bosctechlabs/what-is-the-difference-between-pushreplacementnamed-and-popandpushnamed-in-flutter-1bdc971e86ce
- https://kotlinlang.org/docs/releases.html#release-details
- https://github.com/flutter/flutter/issues/137886#issuecomment-1815733887
- https://www.geeksforgeeks.org/flutter-upload-images-on-firestore-storage/
- https://stackoverflow.com/questions/71077073/the-problem-occurs-after-the-flutter-sdk-is-updated-how-can-i-fix-it
- https://firebase.google.com/docs/android/setup?hl=en&authuser=0&_gl=1*1qqacms*_ga*MTk2MDYzNDk5MS4xNzIwNjU2OTM0*_ga_CW55HF8NVT*MTcyMTQ1MzIxNC4yOS4xLjE3MjE0NTM4MDcuNjAuMC4w#analytics-enabled
- https://stackoverflow.com/questions/76886165/the-argument-type-qrimage-cant-be-assigned-to-the-parameter-type-widget
- https://blog.flutterflow.io/qr-code-generator/
- https://stackoverflow.com/questions/55910065/logging-out-of-flutter-app-doesnt-go-back-to-login-page
- https://github.com/brownboycodes/HADWIN/blob/master/media/promotional/hadwin-screenshot-with-skin-set-1.png
- https://stackoverflow.com/questions/72379271/flutter-material3-disable-appbar-color-change-on-scroll
- https://app.flutterflow.io/project/template2-paobtp?tab=pageSelector&page=HomePage

## installation guide
1. clone the project repository into local device and enter its directory using the 'cd <repo name> command'
2. run the command 'flutter pub get' to install all the dependencies used in the app
3. To run it in an android phone, set the android phone to developer mode and allow USB debugging
4. Then, run the command 'flutter run'

## how to use the app
1. for first time user, register by filling out all the necessary details
2. to add a friend manually using the slambook, go to the slambook using the drawer and fill out the form
3. to add a friend automatically in your friend list using their QR code, click the floating button to navigate to the QR scanner then scan
4. the friends are all listed in the friends button
5. to edit details of a specific friend, just click their name in the friends page then click the edit details button in the bottom navigation bar
