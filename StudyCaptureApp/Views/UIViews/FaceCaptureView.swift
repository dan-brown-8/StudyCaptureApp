//
//  FaceCaptureView.swift
//  StudyCaptureApp
//
//  Created by Dan Brown on 10/11/20.
//  Copyright © 2020 DanielBrown. All rights reserved.
//

import Foundation
import UIKit

class FaceCaptureView: UIView, UITextFieldDelegate {
    
    @IBOutlet weak var subjectIdTextField: UITextField!
    @IBOutlet weak var retakeButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var processedImage: UIImageView!
    @IBOutlet weak var embeddedId: UILabel!
    @IBOutlet weak var loadingSpinnerView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        subjectIdTextField.delegate = self
        loadingSpinnerView.hidesWhenStopped = true
    }
    
    /// Closes keyboard when 'Return' is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    
    /// Starts the animation of the spinner
    func startAnimatingSpinner() {
        loadingSpinnerView.startAnimating()
        saveButton.isEnabled = false
        retakeButton.isEnabled = false
    }
       
    /// Stops the animation of the spinner
    func stopAnimatingSpinner() {
        loadingSpinnerView.stopAnimating()
        saveButton.isEnabled = true
        retakeButton.isEnabled = true
    }
}
