//
//  Borders.swift
//  StudyCaptureApp
//
//  Created by Dan Brown on 10/13/20.
//  Copyright © 2020 DanielBrown. All rights reserved.
//

import UIKit

class Borders {
    
    //Function that allows you to assign a border to a text field
    static func createThinBorders(textFieldName: UITextField) {
        textFieldName.layer.borderWidth = 0.3
        textFieldName.layer.borderColor = UIColor.black.cgColor
    }
    
    static func createThinBorders(imageName: UIImageView) {
        imageName.layer.borderWidth = 0.3
        imageName.layer.borderColor = UIColor.black.cgColor
    }
    
    static func createThinBorders(buttonName: UIButton) {
        buttonName.layer.borderWidth = 0.3
        buttonName.layer.borderColor = UIColor.black.cgColor
    }
}
