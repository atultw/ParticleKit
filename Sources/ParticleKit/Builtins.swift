//
//  File.swift
//  
//
//  Created by Atulya Weise on 1/10/22.
//

import Foundation
import UIKit

// Credit to https://stackoverflow.com/questions/38809425/convert-apple-emoji-string-to-uiimage
public extension String {
    func bitmapped() -> CGImage? {
        let size = CGSize(width: 45, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 40)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image?.cgImage
    }
}

public struct Emoji: Particle {
    
    let emoji: String
    
    public init(of emoji: String) {
        self.emoji = emoji
    }
    
    public func createContents() -> CGImage? {
        emoji.bitmapped()
    }
    
    public func configure(cell: CAEmitterCell) {
        cell.emissionLongitude = .pi
        cell.emissionRange = .pi / 4
        cell.spinRange = .pi * 2
        cell.scaleRange = 0.25
        cell.scale = 1.0 - cell.scaleRange
    }
}

