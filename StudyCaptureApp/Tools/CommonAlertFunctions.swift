//
//  CommonAlertFunctions.swift
//  StudyCaptureApp
//
//  Created by Dan Brown on 10/13/20.
//  Copyright © 2020 DanielBrown. All rights reserved.
//

import Foundation
import UIKit

class CommonAlertFunctions {
    
    /// Present an alert using a title and messsage
    static func showAlertWith(title: String, message: String, vc: UIViewController) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        vc.present(ac, animated: true)
    }
}
