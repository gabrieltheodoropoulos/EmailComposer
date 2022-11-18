//
//  EmailComposerView.swift
//  
//  Created by Gabriel Theodoropoulos.
//  https://serialcoder.dev
//
//  Licensed under the MIT license.
//

import SwiftUI
import MessageUI

/// A UIViewControllerRepresentable type that brings the
/// MFMailComposeViewController from UIKit to SwiftUI.
struct EmailComposerView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    let emailData: EmailData
    var result: (Result<EmailComposerResult, Error>) -> Void
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let emailComposer = MFMailComposeViewController()
        emailComposer.mailComposeDelegate = context.coordinator
        emailComposer.setSubject(emailData.subject)
        emailComposer.setToRecipients(emailData.recipients)
        emailComposer.setMessageBody(emailData.body, isHTML: emailData.isBodyHTML)
        if emailData.attachments.count > 0 {
            for attachment in emailData.attachments {
                emailComposer.addAttachmentData(attachment.data, mimeType: attachment.mimeType, fileName: attachment.fileName)
            }
        }
        
        if !MFMailComposeViewController.canSendMail() {
            result(.success(.deviceCannotSendEmails))
        }
        
        return emailComposer
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
        
    /// Determine if the device can send emails or not.
    /// - Returns: true if the device can send emails, false otherwise.
    public static func canSendEmail() -> Bool {
        MFMailComposeViewController.canSendMail()
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var parent: EmailComposerView
        
        init(_ parent: EmailComposerView) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            
            if let error = error {
                parent.result(.failure(error))
                return
            }
            
            parent.result(.success(.init(rawValue: result.rawValue) ?? .unexpectedResult))
        }
    }
}
