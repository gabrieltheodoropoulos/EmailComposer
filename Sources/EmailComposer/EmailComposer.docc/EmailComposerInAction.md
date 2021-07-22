# EmailComposer in Action

A quick walkthrough on how to use EmailComposer in SwiftUI.

## Overview

This article is a quick guide on everything you need to know in order to use EmailComposer library. Read on to find out how to:

- Present the email composer
- Handle the email composing results
- Provide default email data
- Provide a custom view to display in case the device is unable to send emails
- Perform actions on dismiss

## Getting Started

The simplest way to use EmailComposer is demonstrated in the following code example:

```swift
struct ContentView: View {
    @State private var showEmailComposer = false
    
    var body: some View {
        Button("Send email") {
            showEmailComposer = true
        }
        .emailComposer(isPresented: $showEmailComposer)
    }
}
```

The `emailComposer(isPresented:)` view modifier will present the system provided email composer controller modally. There are more arguments that you can optionally provide, however `isPresented` is the only required argument.

Note that in case the device cannot send emails, then the above will present a default view with a predefined message instead of the email composer. To display a custom content, or to avoid displaying anything, see the *Not All Devices Can Send Emails* section.

Here is another example that makes full use of the `emailComposer` view modifier, providing all optional arguments:

```swift
Button("Send email") { ... }
.emailComposer(isPresented: $showEmailComposer, emailData: emailData, onDismiss: {
    // Perform actions on dismiss...
}, result: { result in
    // Handle email composing result...
}, deviceCannotSendEmailsView: DeviceCannotSendEmailsView(content: {
    // A custom view to display if the device cannot send emails...
}))
```

The following sections contain more details about everything shown above.

## Dealing With Email Composing Results

To handle the email composing results, provide a closure as argument to the `result` optional parameter. The closure's argument is a `Result<EmailComposerResult, Error>` value. See the discussion about the ``EmailComposerResult`` symbol for more information about the possible values on success.

Here is an example of determining the result:

```swift
Button("Send email") {
    showEmailComposer = true
}
.emailComposer(isPresented: $showEmailComposer) { result in
    switch result {
        case .success(let value):
            if value == .deviceCannotSendEmails {
                print("Device cannot send emails.")
            }
            print(value.description)
        
        case .failure(let error):
            print(error.localizedDescription)
    }
}
```

The ``EmailComposerResult/deviceCannotSendEmails`` value is treated separately above in order to highlight that the case of a device unable to send emails is among all possible cases of a successful result. The other cases are: *sent*, *saved*, *cancelled*, and *failed*. For each one there is a textual description provided.

## Passing Predefined Email Data

It's often necessary to provide predefined values or data to the email that users will compose and send. For example, you may want a default subject or a specific recipient to prefill the respective fields in the email.

To do so, pass an ``EmailData`` instance to the `emailComposer` method. It's often handy to create that instance before passing it to the view modifier, providing one or more values and data you wish. In the next example, an `EmailData` instance is initialized in the view, containing the email's subject and a recipient:

```swift
struct ContentView: View {
    ...
    
    let emailData = EmailData(subject: "Hi there!",
                              recipients: ["some@recipient.xyz"])
    
    var body: some View {
        Button("Send email") { ... }
        .emailComposer(isPresented: $showEmailComposer,
                       emailData: emailData)
    }
}
```

Take a look at the ``EmailData`` type to find out more.

## Not All Devices Can Send Emails

A device might be capable of sending emails, but it might not as well. Normally, this case should be treated properly and not to be left unhandled, otherwise the app will be crashing every time users try to write an email. However, `EmailComposer` ensures that this is not going to happen.

More particularly, `EmailComposer` checks internally if the device can actually send emails or not, and triggers the presentation of the email composer if only the device is capable of sending emails. In the opposite case, there are two things that occur:

1. If you handle the email composing results, then you should expect to get the ``EmailComposerResult/deviceCannotSendEmails`` as the returned value.
2. Instead of the email composer controller, a *default view is displayed* in order to notify the user. That view contains a Text view with a related message, and a button in order to dismiss the modal sheet.

That default view is the following:

```swift
struct DeviceCannotSendEmailsDefaultView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack {
            Text("Unable to send emails from this device.")
                .padding(.bottom, 20)
                .multilineTextAlignment(.center)
            Button("Dismiss") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
```

Even though the above view will perfectly work, consider it as a *placeholder*. You are adviced to provide a customized, and probably localized view instead in order to fit to the look and feel of your app.

To achieve that, in the `emailComposer` view modifier pass an instance of the ``DeviceCannotSendEmailsView`` view. Supply any SwiftUI view or a combination of primitive views as the content you want to display in case the device cannot send emails.

```swift
Button("Send email") { ... }
.emailComposer(isPresented: $showEmailComposer,
               deviceCannotSendEmailsView: DeviceCannotSendEmailsView(content: {
    // Your custom view here...
}))
```

If you don't want to display anything, then do as above once again, but this time provide an `EmptyView` as the content of the `DeviceCannotSendEmailsView` view.

```swift
Button("Send email") { ... }
.emailComposer(isPresented: $showEmailComposer,
               deviceCannotSendEmailsView: DeviceCannotSendEmailsView(content: {
    EmptyView()
}))
```

Notice that it's your duty to dismiss the email composer, no matter if you provide a custom view or an empty view as content to the `DeviceCannotSendEmailsView` view. That's why it's important to handle the ``EmailComposerResult/deviceCannotSendEmails`` result.

## Perform Actions On Dismiss

Email composer is presented in a modal sheet, and sheets in SwiftUI have an optional closure to perform further actions upon dismissal. The `onDismiss` argument lets you do exactly that in the `emailComposer` modifier when the email composer gets dismissed.

```swift
.emailComposer(isPresented: $showEmailComposer,
               onDismiss: {
    // Do something when the email composer sheet is dismissed...
})
```
