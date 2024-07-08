# Week 4-5: User Interaction and Menu, Routes, and Navigation

**Name:** Gabrielle Pelletero <br/>
**Section:** U-2L <br/>
**Student number:** 2022 - 10580 <br/>

## Code Description

Describe what your code does here
The code is a mobile slam book using different input widgets asking for name (text field), nickname (text field), age (text field), relationship status (switch), happiness level (slider), superpower (dropdown), favorite motto (radio), summary of form values. There is also the navigation of pages and there is a drawer to both the slambook page and friends page.

## Things you did in the code

Describe what you did here
First, I tried to separate the widgets and classes needed for a specific page. I did the routing in the main, the entries from the form in the first page friends then the form widget in the second page slambook. In the first page, I have a constructor that takes a a list of the entries as a required parameter, holding entries displayed in a listview. Inside the build method is the scaffold, column widget, and elevated button going to the second page. The page also contains a drawer method which reates a custom navigation drawer with a header. In the second page, it has a build method containing the appbar, drawer and body. It has a form smaple widget which contains form validation and submission and the UI.

## Challenges encountered

Describe your challenges here
I was having trouble mainly on the routing part of the exercise. I had trouble sending data from one screen to another due to a lot of components involved. At first, I was having trouble implementing the slider and radio class but figured it out soon. I was also having trouble resetting the form because at first, the name and nickname input fields doesnt reset.

## References

- https://api.flutter.dev/flutter/material/Slider-class.html
- https://api.flutter.dev/flutter/material/Radio-class.html
- https://stackoverflow.com/questions/49577781/how-to-create-number-input-field-in-flutter
- https://imagecolorpicker.com/color-code/2596be
- https://www.geeksforgeeks.org/flutter-send-data-to-screen/
- https://docs.flutter.dev/cookbook/navigation/passing-data
- https://stackoverflow.com/questions/53861302/passing-data-between-screens-in-flutter
- https://medium.com/@lazy_mind/how-to-pass-a-data-between-screens-in-flutter-from-basic-to-advance-in-dart-9f69f0ee998e
- https://www.geeksforgeeks.org/flutter-pass-data-one-screen-to-another-screen/
- https://stackoverflow.com/questions/66582415/change-the-color-of-a-switch-formbuilderswitch-flutter -https://www.edureka.co/community/235089/how-to-change-textfield-underline-color#:~:text=You%20can%20change%20the%20color,BorderSide%20with%20the%20desired%20color.
