//
//  EmailComposerUnableDeviceViews.swift
//  
//  Created by Gabriel Theodoropoulos.
//  https://serialcoder.dev
//
//  Licensed under the MIT license.
//

import SwiftUI

/// A generic view to provide custom content to display
/// when the device cannot send emails and the composer
/// controller cannot be presented.
public struct DeviceCannotSendEmailsView<Content: View>: View {
    let content: Content
        
    /// Provide a custom SwiftUI view to display when the device is unable
    /// to present the email composer and send emails.
    /// - Parameter content: A closure to provide a custom SwiftUI view.
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        content
    }
}


/// A default view to present when the device cannot send emails.
///
/// To provide an alternative view create a DeviceCannotSendEmailsView instance
/// and pass it to the `.emailComposer` modifier.
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
