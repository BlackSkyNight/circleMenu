//
//  circleView.swift
//  UXDesign
//
//  Created by Mateusz Matejczyk on 05.11.2017.
//  Copyright © 2017 Mateusz Matejczyk. All rights reserved.
//

import UIKit

class CircleClass: UIView {

    let path = UIBezierPath()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect)
    {
        let radius: Double = Double(rect.width) / 2 - 20
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        
        path.move(to: CGPoint(x: CGFloat(center.x + CGFloat(radius)), y: CGFloat(center.y)))
        
        for i in stride(from: 0, to: 361.0, by: 2) // im mniejsza liczba po by tym lepszy okrag
        {
            let radians = i * Double.pi / 180
            
            let x = Double(center.x) + radius * cos(radians)
            let y = Double(center.y) + radius * sin(radians)
            
            path.addLine(to: CGPoint(x: x, y: y))
        }
        let color = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1.0)
        color.setStroke()
        path.stroke() // dodaje obraz
    }
    
    func setDesign(color: UIColor, lineWidth: Double)
    {
        self.path.lineWidth = CGFloat(lineWidth)
    }
}

