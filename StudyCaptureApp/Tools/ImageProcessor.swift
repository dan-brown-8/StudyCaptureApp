//
//  ImageProcessor.swift
//  StudyCaptureApp
//
//  Created by Dan Brown on 10/13/20.
//  Copyright © 2020 DanielBrown. All rights reserved.
//

import Foundation
import UIKit

class ImageProcessor {
    
    /// Return true if a face was detected in the image, false if not detected
    static func isFaceDetected(image: CIImage) -> Bool {
        
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        let faces = faceDetector?.features(in: image)
        
        if (faces?.count == 1) {
            // Face found, continue with processing
            return true
        }
        else {
            return false
        }
    }
    
    /// Apply a filter and return a filterered UIImage
    static func applyFilter(image: CIImage) -> UIImage {
        let context = CIContext(options: nil)

        if let filter = CIFilter(name: FilterValues.FILTERTYPE) {
            // Setting filter
            filter.setValue(image, forKey: kCIInputImageKey)
            filter.setValue(FilterValues.INPUTRADIUS, forKey: kCIInputRadiusKey)
            filter.setValue(FilterValues.INPUTINTENSITY, forKey: kCIInputIntensityKey)

        if let cgimg = context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
                let processedImage = UIImage(cgImage: cgimg)
                return processedImage
            }
        }
        return UIImage()
    }
}
