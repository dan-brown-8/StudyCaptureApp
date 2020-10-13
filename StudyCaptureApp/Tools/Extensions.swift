//
//  Extensions.swift
//  StudyCaptureApp
//
//  Created by Dan Brown on 10/11/20.
//  Copyright © 2020 DanielBrown. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

extension String {
    /// Checks to see if the String is alphanumeric
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}

extension UIView {
    /// Converts a UIImageView to a UIImage
    func asImage() -> UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        }
        else {
            guard let context = UIGraphicsGetCurrentContext() else
            { return nil }
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            guard let cgImage = image?.cgImage else { return nil }
            return UIImage(cgImage: cgImage)
        }
    }
}
