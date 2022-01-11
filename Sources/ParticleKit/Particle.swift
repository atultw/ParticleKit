//
//  Item.swift
//  
//
//  Created by Atulya Weise on 1/10/22.
//

import Foundation
import UIKit
/**
 Protocol that all items in `ParticlesView` must conform to.
 
 - Warning: The `CAEmitterCell.contents` is already set when used in `ParticlesView`. **DO NOT** set contents, unless you want to override the return value of `createContents()`!
 
 Example implementation
```
struct Confetti: Item {
    func createContents() -> CGImage? {
        UIImage(systemName: "person.circle")?.cgImage
    }

    func createCell(from cell: CAEmitterCell) -> CAEmitterCell {
        // DO NOT SET CONTENTS!
        // cell.contents = createContents()
        cell.name = "Snow"
        cell.birthRate = 20.0
        cell.lifetime = 10.0
        cell.velocity = CGFloat(cell.birthRate * cell.lifetime)
        cell.velocityRange = cell.velocity / 2
        cell.emissionLongitude = .pi
        cell.emissionRange = .pi / 4
        cell.spinRange = .pi * 2
        cell.scaleRange = 0.25
        cell.scale = 1.0 - cell.scaleRange
        return cell
    }
}
```
*/
public protocol Particle {
    func createContents() -> CGImage?
    func createCell(from cell: CAEmitterCell) -> CAEmitterCell
}
