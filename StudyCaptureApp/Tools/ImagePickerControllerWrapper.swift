//
//  ImagePickerControllerWrapper.swift
//  StudyCaptureApp
//
//  Created by Dan Brown on 10/11/20.
//  Copyright © 2020 DanielBrown. All rights reserved.
//

import Foundation
import UIKit

class ImagePickerControllerWrapper {
    class func imagePicker(vc: UIViewController, imagePicker: UIImagePickerController) {       
        self.openCamera(vc: vc, imagePicker: imagePicker)
    }
    
    private class func openCamera(vc: UIViewController, imagePicker: UIImagePickerController){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            
            vc.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "Camera not found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            vc.present(alert, animated: true, completion: nil)
        }
    }
}
