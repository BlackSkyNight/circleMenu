//
//  RoundButton.swift
//  MyaddButton
//
//  Created by Mateusz Matejczyk on 30.03.2018.
//  Copyright © 2018 Mateusz Matejczyk. All rights reserved.
//

import UIKit

@IBDesignable class RoundButton: UIButton
{

    @IBInspectable var firstColor: UIColor = UIColor.clear
    @IBInspectable var secondColor: UIColor = UIColor.clear
    @IBInspectable var gradient: Bool = false
    @IBInspectable var roundShape = true
    @IBInspectable var cornerRadiatus: CGFloat = 0.0
    @IBInspectable var image: UIImage?
    @IBInspectable var imageColor: UIColor?
    @IBInspectable var borderSingleColor: UIColor?
    @IBInspectable var borderThickness: CGFloat = 0.0
    var animationState: Bool = false
    var isVisible: Bool = true
    
    
    override func draw(_ rect: CGRect)
    {
        self.layer.cornerRadius = cornerRadiatus
        if (borderSingleColor != nil)
        {
            self.layer.borderColor = borderSingleColor?.cgColor
            self.layer.borderWidth = borderThickness
        }
            
        if (roundShape == true)
        {
            self.layer.cornerRadius = self.bounds.width / 2
            cornerRadiatus = self.bounds.width / 2
        }
        
        if (gradient == true)
        {
            
            self.layer.insertSublayer(createGradientLayer(firstColor: firstColor, secondColor: secondColor, frame: self.bounds, cornerRadiatus: self.layer.cornerRadius), below: self.imageView?.layer)
        }
        
        if (self.image != nil && self.imageColor != nil)
        {
            setImageOnly(image: image!, color: imageColor!)
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
    
    
    /**
     Use this function to set icon (with color) for button.
     
     - Important:
     You can't set button's title
    
     - Author:
     Mateusz Matejczyk
     
     - Version:
     0.1
     */
    func setImageOnly(image: UIImage, color: UIColor)
    {
        self.setImage(image.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
        self.setTitle("", for: .normal)
        self.tintColor = color
        self.imageView?.tintColor = color
        self.imageEdgeInsets = UIEdgeInsets(top: 0.2 * self.frame.height, left: 0.2 * self.frame.width, bottom: 0.2 * self.frame.height, right: 0.2 * self.frame.width)
    }
    
    /**
     Use this function to prepare button for apperance.
     
     - Author:
     Mateusz Matejczyk
     
     - Version:
     0.1
     
     Button will be hidden and ready for any apperance animation.
     */
    func prepareForAppearanceAnimations()
    {
        self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.alpha = 0.0
        self.isVisible = false
        self.animationState = false
    }
    
    
    /**
     Apperance animation.
    
     - important:
     Use this after prepareForApperanceAnimation()
     
     - author:
     Mateusz Matejczyk
     
     - version:
     0.1
     
     Animation has default delay and duration
     
     */
    func animatePopAppearance()
    {
        if (self.isVisible == false && self.animationState == false)
        {
            UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 7.0, options: .curveEaseOut, animations: {
                self.alpha = 1.0
                self.transform = .identity
            }) { (finished) in
                self.isVisible = true
                self.animationState = false
            }
        }
    }
    
    /**
     Apperance animation with parameters.

     
     - important:
     Use this after prepareForApperanceAnimation()
     
     Using the parameters allow you to chain up the animations
     
     - parameters:
        - delay: Set the delay of the animation
        - duration: Set the delay of the animation
     
     - author:
     Mateusz Matejczyk
     
     - version:
     0.1
     */
    func animatePopAppearance(delay: Double, duration: Double)
    {
        if (self.isVisible == false && self.animationState == false)
        {
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 7.0, options: .curveEaseOut, animations: {
                self.alpha = 1.0
                self.transform = .identity
            }) { (finished) in
                self.isVisible = true
                self.animationState = false
            }
        }
    }
    
    /**
     Shake animation.

     - author:
     Mateusz Matejczyk
     
     - version:
     0.1
     */
    func animateShake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    func animateTransformImageWithBounce(finalImage: UIImage, finalColor: UIColor)
    {
        
    }
}
