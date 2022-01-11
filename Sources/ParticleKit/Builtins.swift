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
        let size = CGSize(width: 40, height: 40)
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
    public var birthRate: Int
    
    public var lifetime: Int
    
    public var speed: Int
    
    let emoji: String
    
    public init(of emoji: String, birthRate: Int = 10, lifetime: Int = 8, speed: Int = 200) {
        self.emoji = emoji
        self.birthRate = birthRate
        self.lifetime = lifetime
        self.speed = speed
    }
    
    public func createContents() -> CGImage? {
        emoji.bitmapped()
    }
    
    public func createCell(from cell: CAEmitterCell) -> CAEmitterCell {
//        cell.birthRate = Float(birthRate)
//        cell.lifetime = Float(lifetime)
//        cell.velocity = CGFloat(speed)
        cell.emissionLongitude = .pi
        cell.emissionRange = .pi / 4
        cell.spinRange = .pi * 2
        cell.scaleRange = 0.25
        cell.scale = 1.0 - cell.scaleRange
        return cell
    }
}

