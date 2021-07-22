# EmailComposer

Compose and send emails in SwiftUI using a view modifier.

![EmailComposer code snippet](https://serialcoder.dev/misc/github_images/emailComposer.png)

## About EmailComposer

EmailComposer library makes it pretty easy to present the system provided controller for composing emails in SwiftUI based iOS applications. All it takes is to use a **view modifier**, providing a few arguments. The rest are handled automatically.


### A Useful Note

The Swift package in this repository is meant to be used in Xcode 13 and above. If you are working in Xcode 12 and want to integrate EmailComposer in your project, then take a look at [this repository](https://github.com/gabrieltheodoropoulos/EmailComposer-Xcode12.git) that contains a modified package compatible to Xcode 12. The difference between the two is the version of the used Swift tools; this one uses Swift tools version 5.5 in order to take advantage of the new documentation features and DocC archives that are new to Xcode 13. 

## Integration

Copy this repository's URL, and in Xcode 13 and above, go to *File > Add Packages...* menu and paste the URL to the search bar of the window that shows up.

Follow the on-screen steps to finish adding the package. Do not forget to:

- Add EmailComposer library to the *Frameworks, Libraries, and Embedded Content* section in the General tab of your app's target.
- Import it in any source file you are going to use it:

```swift
import EmailComposer
```

## Documentation

[This short guide](https://github.com/gabrieltheodoropoulos/EmailComposer/wiki) demonstrates how to use EmailComposer library.

Also, documentation for this library has been generated using the DocC compiler in Xcode 13. You may [download a DocC archive](https://serialcoder.dev/downloads/documentation/emailcomposer-library/EmailComposer.doccarchive.zip) (.doccarchive) and open it with Developer Documentation in Xcode (**Note**: Xcode 13 and above is required).

## Reading Material

There is a text tutorial to read about how to implement email composer in SwiftUI on [SerialCoder.dev](https://serialcoder.dev/text-tutorials/swiftui/composing-emails-in-swiftui-using-a-view-modifier/), and on [Medium](https://gabth.medium.com/composing-emails-in-swiftui-using-a-view-modifier-a764a981080a).

## Author

Gabriel Theodoropoulos, Copyright © 2021 - Explore more content and material at [SerialCoder.dev](https://serialcoder.dev).

*Legal Note:
It is allowed to use EmailComposer library in both personal and commercial projects, as well as to modify it as neccesary. However, it is not allowed to sell it, or claim ownership.*

## License

EmailComposer is licensed under the MIT license.
