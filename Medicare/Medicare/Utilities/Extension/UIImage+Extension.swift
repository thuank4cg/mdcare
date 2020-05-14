//
//  UIImage+Extension.swift
//  Medicare
//
//  Created by sanghv on 11/13/19.
//

import Foundation

// MARK: - Rotation

public extension UIImage {

    func rotated(degrees: CGFloat) -> UIImage? {
        return rotated(radians: degrees.toRadians())
    }

    func rotated(radians: CGFloat) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size)
            .applying(CGAffineTransform(rotationAngle: radians)).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!

        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: radians)
        // Draw the image at its center
        self.draw(in: CGRect(
            x: -self.size.width/2,
            y: -self.size.height/2,
            width: self.size.width,
            height: self.size.height
        ))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
