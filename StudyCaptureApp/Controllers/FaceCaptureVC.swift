//
//  ViewController.swift
//  StudyCaptureApp
//
//  Created by Dan Brown on 10/11/20.
//  Copyright © 2020 DanielBrown. All rights reserved.
//

import UIKit
import CoreImage
import CoreGraphics

class FaceCaptureVC: UIViewController, UINavigationControllerDelegate {

    @IBOutlet var faceCaptureView: FaceCaptureView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        
        // Brief directions (This may not be necessary for production)
        let ac = UIAlertController(title: "Press the camera icon at the top right of the screen to take a selfie", message: "Enter a valid subject ID", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    /// Necessary customizations to the navigation bar
    func configureNavigationBar() {
        // Add camera image as navigation bar button
        let imageBarButton = UIBarButtonItem(image: UIImage(named: "camera.png")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.action(sender:)))
        
        self.navigationItem.rightBarButtonItem = imageBarButton
        self.navigationItem.title = "Image Processor"
    }
    
    // Handle what happens when the camera icon is pressed
    @objc func action(sender: UIBarButtonItem) {
        launchCamera()
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        faceCaptureView.startAnimatingSpinner()
        // Save photo to camera roll
        guard let selectedImage = faceCaptureView.processedImage.image else {
               // print("Image not found!")
                return
            }
            UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error
            faceCaptureView.stopAnimatingSpinner()
            CommonAlertFunctions.showAlertWith(title: "Save error", message: error.localizedDescription, vc: self)
        } else {
            faceCaptureView.stopAnimatingSpinner()
            CommonAlertFunctions.showAlertWith(title: "Saved!", message: "Your image has been saved to your photos.", vc: self)
        }
    }

    // Check if the id is valid, then launch the user's camera
    @IBAction func retakeButtonPressed(_ sender: Any) {
        launchCamera()
    }
    
    /// Check if the subject id is valid, then launch the user's camera
    func launchCamera() {
        let id = faceCaptureView.subjectIdTextField.text ?? ""
        
        if (id.isAlphanumeric) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            CommonAlertFunctions.showAlertWith(title: "Error", message: "Please enter a valid subject ID", vc: self)
        }
    }
    
    func imageProcessor(image: UIImage) {
        let ciImage = CIImage(image: image) ?? CIImage()
        // Confirm image is a face
        if (ImageProcessor.isFaceDetected(image: ciImage)) {
            // Continue with processing, apply filter
            let processedImage = ImageProcessor.applyFilter(image: ciImage)
            self.displayProcessedImage(image: processedImage)
        }
        else {
            CommonAlertFunctions.showAlertWith(title: "Error: Face not found", message: "Please retake the selfie of your face", vc: self)
            faceCaptureView.stopAnimatingSpinner()
        }
    }
    
    func displayProcessedImage(image: UIImage) {
        faceCaptureView.saveButton.isHidden = false
        faceCaptureView.retakeButton.isHidden = false
        
        // Adjust the orientation to fit the original layout
        let finalImage = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: .right)
        faceCaptureView.processedImage.image = finalImage
        
        // 'Burn' in the subject ID to the image
        faceCaptureView.embeddedId.text = faceCaptureView.subjectIdTextField.text
        faceCaptureView.embeddedId.adjustsFontSizeToFitWidth = true
        faceCaptureView.embeddedId.isHidden = false
        faceCaptureView.processedImage.addSubview(faceCaptureView.embeddedId)
        faceCaptureView.processedImage.bringSubviewToFront(faceCaptureView.embeddedId)
        
        let img = faceCaptureView.processedImage.asImage()
        faceCaptureView.processedImage.isHidden = false
        faceCaptureView.processedImage.image = img
        
        faceCaptureView.stopAnimatingSpinner()
    }
}

extension FaceCaptureVC: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let selfie = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following \(info)")
        }
        // Dismiss the picker
        dismiss(animated: true, completion: nil)
        
        // Process the selfie
        self.faceCaptureView.startAnimatingSpinner()
        self.imageProcessor(image: selfie)
    }
}


