//
//  EmailData.swift
//  
//  Created by Gabriel Theodoropoulos.
//  https://serialcoder.dev
//
//  Licensed under the MIT license.
//

import Foundation

/// A custom type to provide predefined values that will
/// prefill the email fields.
public struct EmailData {
    /// Email subject.
    ///
    /// Default valus is an empty string.
    public var subject: String = ""
    
    /// The potential recipients of the email.
    public var recipients: [String]?
    
    /// The email body.
    ///
    /// Default value is an empty string.
    public var body: String = ""
    
    /// A boolean value indicating whether the email body provided with the ``EmailData/body``
    /// property is HTML or plain text.
    ///
    /// Default value is `false`.
    public var isBodyHTML = false
    
    /// An array of ``EmailData/AttachmentData`` objects for adding attachments to the email.
    public var attachments = [AttachmentData]()
    
    /// A custom type to keep attachment data for the emails that users will send.
    ///
    /// Provide instances of this type to the ``EmailData/attachments`` array
    /// of your ``EmailData`` instance.
    public struct AttachmentData {
        /// The attachment data.
        public var data: Data
        
        /// The attachment mime type.
        public var mimeType: String
        
        /// The attachement file name.
        public var fileName: String
        
        /// Initialize an ``EmailData/AttachmentData`` instance for an ``EmailData`` object
        /// by providing the actual data, the mime type, and a file name.
        public init(data: Data, mimeType: String, fileName: String) {
            self.data = data
            self.mimeType = mimeType
            self.fileName = fileName
        }
    }
    
    /// Initialize an EmailData instance.
    ///
    /// It's not necessary to provide values to all possible arguments. Do so only for those actually needed.
    ///
    ///   ```swift
    ///     let emailData = EmailData(subject: "Hi there!", recipients: ["some@recipient.xyz"])
    ///   ```
    ///
    /// - Parameters:
    ///   - subject: Email subject. An empty string by default.
    ///   - recipients: The potential recipients of the email. It's `nil` by default.
    ///   - body: The email body. An empty string by default.
    ///   - isBodyHTML: A boolean value indicating whether the body provided with the `body`
    ///   property is HTML or plain text. It's `false` by default.
    ///   - attachments: An array of ``EmailData/AttachmentData`` objects for adding attachments to the email.
    ///   The array is empty by default.
    ///
    public init(subject: String = "", recipients: [String]? = nil, body: String = "", isBodyHTML: Bool = false, attachments: [AttachmentData] = .init()) {
        self.subject = subject
        self.recipients = recipients
        self.body = body
        self.isBodyHTML = isBodyHTML
        self.attachments = attachments
    }
    
}
