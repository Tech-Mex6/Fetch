//
//  UIApplication.swift
//  Fetch
//
//  Created by meekam okeke on 7/15/24.
//

import Foundation
import SwiftUI
/// This extension adds a utility function to the `UIApplication` class to simplify ending text field editing across the entire application.
extension UIApplication {
    //MARK: - End Editing
    /// - Type: `Void`
    /// - Parameters: None
    /// - Description: This method sends an action to resign the first responder status from any responder object that is currently the first responder in the application.
    /// Essentially, this is used to dismiss the keyboard or end text editing for the current text input view.
    /// - Returns: None
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
