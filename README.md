# StudyCaptureApp
Photo capture and processing app

**README:**

**WARNING**
This app only works on physical devices. It will not function properly on an iPhone simulator since the simulator is unable to take photos.

**How it Works**
- Type in an alphanumeric subject ID.
- Press the camera icon in the top right corner and take a selfie.
- The app will check to make sure that the photo contains one face, then it will apply a CIUnsharpMask filter and 'burn' the subject ID into the bottom 
right corner of the image.
- Choose to either save or retake the photo.

**Architecture:**
- I used MVC since that is what I am most experienced with and considering the time restriction it made the most sense. 
- I made an effort to separate reusable classes/functions from the ViewController whenever possible to try and avoid the common “Massive View Controller” issue.
- Folder structure: 1. Controllers 2. Views (Storyboards, UIViews) 3. Models 4. Tools (Formatting, common UI functions, image processing, etc)

**If I had more time or if this were for production:**
- Written automated tests.
- Tested on more than one physical device.
- I would’ve added size classes for iPad screen sizes and possibly the iPhone SE screen size. The app currently works on those devices but it’s not optimal.
- A personalized app icon.

**Other Ideas:**
- More specific face detection features (smiling, eyes are visible, etc)

Icons by https://icons8.com 
