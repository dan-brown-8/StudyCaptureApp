//
//  UIFormatting.swift
//  StudyCaptureApp
//
//  Created by Dan Brown on 10/13/20.
//  Copyright © 2020 DanielBrown. All rights reserved.
//

import UIKit
/// Call this class to format a button for you
class FormatButton {
    
    /// Takes a button as a parameter, makes it round, then returns the rounded button
    static func makeRound(button: UIButton, cornerRadius: CGFloat) {
        button.layer.cornerRadius = cornerRadius
        button.clipsToBounds = true
    }
}
