//
//  CircleMenu.swift
//  MyaddButton
//
//  Created by Mateusz Matejczyk on 30.03.2018.
//  Copyright © 2018 Mateusz Matejczyk. All rights reserved.
//

import UIKit

@IBDesignable class CircleMenu: UIView
{
    @IBInspectable var firstColor: UIColor = UIColor.clear
    @IBInspectable var secondColor: UIColor = UIColor.clear
    @IBInspectable var gradient: Bool = false
    @IBInspectable var cornerAdapter: Int
    {
        get
        {
            return self.corner.rawValue
        }
        set
        {
            self.corner = Corner(rawValue: cornerAdapter) ?? .upperRight
        }
    }
    var corner: Corner = .bottomRight
    var buttonsArray = [RoundButton]()
    var animationState: Bool = false
    var isVisible: Bool = true
    
    enum Corner: Int {
        case upperRight
        case bottomRight
        case bottomLeft
        case upperLeft
    }
    
    override func draw(_ rect: CGRect)
    {
        self.layer.cornerRadius = self.bounds.width / 2
        self.clipsToBounds = true
        
        switch corner
        {
            case .upperRight:
                self.center.x = (superview?.bounds.maxX)!
                self.center.y = (superview?.bounds.minY)!
                self.transform = CGAffineTransform.identity.rotated(by: .pi * 3 / 2)
            case .bottomRight:
                self.center.x = (superview?.bounds.maxX)!
                self.center.y = (superview?.bounds.maxY)!
            case .bottomLeft:
                self.center.x = (superview?.bounds.minX)!
                self.center.y = (superview?.bounds.maxY)!
                self.transform = CGAffineTransform.identity.rotated(by: .pi / 2)
            case .upperLeft:
                self.center.x = (superview?.bounds.minX)!
                self.center.y = (superview?.bounds.minY)!
                self.transform = CGAffineTransform.identity.rotated(by: .pi)
        }
        
        if (gradient == true)
        {
            self.layer.insertSublayer(createGradientLayer(firstColor: firstColor, secondColor: secondColor, frame: self.bounds, cornerRadiatus: self.layer.cornerRadius), at: 0)
        }
    }
    
    /**
    Use this function to prepare menu for apperance.
     
     - Important:
     Use this function only before animateIn()
     It's not working for custom menu position (TODO)
     
     - Author:
     Mateusz Matejczyk
     
     - Version:
     0.1
     
     CircleMenu will be hidden.
    */
    func prepareForAppearanceAnimations()
    {
        self.isVisible = false
        self.animationState = false
        self.alpha = 0
        self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    }
    
    func animateIn()
    {
        if (animationState == false)
        {
            self.isVisible = true
            animationState = true
            
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 6.0, options: .curveEaseOut, animations: {
                self.alpha = 1.0
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }) { (finished) in
                self.animationState = false
            }
        }
    }
    
    func animateIn(duration: Double, delay: Double)
    {
        if (animationState == false)
        {
            self.isVisible = true
            animationState = true
            
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.6, initialSpringVelocity: 6.0, options: .curveEaseOut, animations: {
                self.alpha = 1.0
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }) { (finished) in
                self.animationState = false
            }
        }
    }
    
    func animateOut()
    {
        if (animationState == false)
        {
            animationState = true
            
            UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 7.0, options: .curveEaseOut, animations: {
                self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }, completion: { (finished) in
                UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 7.0, options: .curveEaseOut, animations: {
                    self.alpha = 0
                    self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                }, completion: { (finished) in
                    self.animationState = false
                    self.isVisible = false
                })
            })
        }
    }
    
    /**
     Use this function to prepare menu buttons.
     
     -Author:
     Mateusz Matejczyk
     
     -Version:
     0.1
     
     -Important:
     Use this function only after intialization CircleMenu
     
     */
    func setButtons()
    {
        if (buttonsArray.count == 1)
        {
            buttonsArray[0].center.x = self.bounds.width * 2 / 9
            buttonsArray[0].center.y = self.bounds.height * 2 / 9
            self.addSubview(buttonsArray[0])
            
            
        }
        else if (buttonsArray.count == 2)
        {
            buttonsArray[0].center.x = self.bounds.width * 1 / 6
            buttonsArray[0].center.y = self.bounds.height * 3 / 8
            buttonsArray[1].center.x = self.bounds.width * 3 / 8
            buttonsArray[1].center.y = self.bounds.height * 1 / 6
            self.addSubview(buttonsArray[0])
            self.addSubview(buttonsArray[1])
        }
        else if (buttonsArray.count == 3)
        {
            buttonsArray[0].center.x = self.bounds.width * 1 / 7
            buttonsArray[0].center.y = self.bounds.height * 4 / 10
            buttonsArray[1].center.x = self.bounds.width * 2 / 9
            buttonsArray[1].center.y = self.bounds.height * 2 / 9
            buttonsArray[2].center.x = self.bounds.width * 4 / 10
            buttonsArray[2].center.y = self.bounds.height * 1 / 7
            self.addSubview(buttonsArray[0])
            self.addSubview(buttonsArray[1])
            self.addSubview(buttonsArray[2])
        }
    }

    private func createGradientLayer(firstColor: UIColor, secondColor: UIColor, frame: CGRect, cornerRadiatus: CGFloat) -> CAGradientLayer
    {
        let gradient = CAGradientLayer()
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.frame = frame
        gradient.cornerRadius = cornerRadiatus
        return gradient
    }
    
    
}
