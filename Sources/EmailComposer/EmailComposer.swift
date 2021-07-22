//
//  EmailComposer.swift
//
//  Created by Gabriel Theodoropoulos.
//  https://serialcoder.dev
//
//  Licensed under the MIT license.
//

import SwiftUI

/// The EmailComposer view modifier that presents the
/// email composer in a modal sheet.
///
/// If the device cannot send emails, it can
/// present either a default, or a custom view instead. To avoid
/// presenting anything when the device is unable to send emails,
/// then provide an EmptyView.
///
/// This struct is internal to EmailComposer library. To use it,
/// call any of the available `emailComposer` methods available in the
/// View extension.
struct EmailComposer<ContentView: View>: ViewModifier {
    @Binding var isPresented: Bool
    var emailData: EmailData?
    var onDismiss: (() -> Void)?
    var result: ((Result<EmailComposerResult, Error>) -> Void)?
    var deviceCannotSendEmailsView: DeviceCannotSendEmailsView<ContentView>
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented, onDismiss: onDismiss) {
                if EmailComposerView.canSendEmail() {
                    EmailComposerView(emailData: emailData ?? EmailData()) { result in
                        self.result?(result)
                    }
                } else {
                    deviceCannotSendEmailsView
                }
            }
    }
}


extension View {
    /// Present the email composer to prepare and send emails.
    ///
    /// - Parameters:
    ///   - isPresented: The binding value of a Bool state property that indicates whether the email composer should be presented or not.
    ///   - emailData: An `EmailData` instance with any predefined values to prefill the email with. `nil` by default.
    ///   - onDismiss: An optional closure to perform any actions upon the dismissal of the email composer. It's `nil` by default.
    ///   - result: The email composing results. On success, it contains an `EmailComposerResult` value, otherwise an `Error` object. `nil` by default.
    ///   - deviceCannotSendEmailsView: A `DeviceCannotSendEmailsView` instance that accepts a custom SwiftUI view (or an empty view) that will be displayed if the device cannot send emails. A text with a dismiss button will be presented by default if you omit providing a custom view.
    public func emailComposer<ContentView: View>(isPresented: Binding<Bool>,
                                                 emailData: EmailData? = nil,
                                                 onDismiss: (() -> Void)? = nil,
                                                 result: ((Result<EmailComposerResult, Error>) -> Void)? = nil,
                                                 deviceCannotSendEmailsView: DeviceCannotSendEmailsView<ContentView>) -> some View {
        self.modifier(EmailComposer(isPresented: isPresented,
                                    emailData: emailData,
                                    onDismiss: onDismiss,
                                    result: result,
                                    deviceCannotSendEmailsView: deviceCannotSendEmailsView))
    }
    
    
    /// Present the email composer to prepare and send emails.
    ///
    /// - Parameters:
    ///   - isPresented: The binding value of a Bool state property that indicates whether the email composer should be presented or not.
    ///   - emailData: An `EmailData` instance with any predefined values to prefill the email with. `nil` by default.
    ///   - onDismiss: An optional closure to perform any actions upon the dismissal of the email composer. It's `nil` by default.
    ///   - result: The email composing results. On success, it contains an `EmailComposerResult` value, otherwise an `Error` object. `nil` by default.
    public func emailComposer(isPresented: Binding<Bool>,
                              emailData: EmailData? = nil,
                              onDismiss: (() -> Void)? = nil,
                              result: ((Result<EmailComposerResult, Error>) -> Void)? = nil) -> some View {
        self.modifier(
            EmailComposer(
                isPresented: isPresented,
                emailData: emailData,
                onDismiss: onDismiss,
                result: result,
                deviceCannotSendEmailsView:
                    DeviceCannotSendEmailsView(content: { DeviceCannotSendEmailsDefaultView() })
            )
        )
    }
}
