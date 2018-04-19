//
//  ViewController.swift
//  MyaddButton
//
//  Created by Mateusz Matejczyk on 30.03.2018.
//  Copyright © 2018 Mateusz Matejczyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var circleView = CircleMenu()
    
    @IBAction func moreButtonAction(_ sender: Any)
    {
        if (circleView.isVisible == false && circleView.animationState == false)
        {
            for button in circleView.buttonsArray
            {
                button.prepareForAppearanceAnimations()
            }
            
            circleView.animateIn(duration: 0.4, delay: 0.0)
            var i: Double = 0.0
            for button in circleView.buttonsArray
            {
                button.animatePopAppearance(delay: 0.4 + (i * 0.1), duration: 0.2)
                i += 1
            }
        }
        
        if (circleView.isVisible == true && circleView.animationState == false)
        {
            circleView.animateOut()
        }
    }
    
    @IBOutlet weak var moreButton: RoundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let button = RoundButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        
        let image = #imageLiteral(resourceName: "icons8-plus-math.png")
        
        button.setImageOnly(image: image, color: UIColor.white)
        button.borderThickness = 1
        button.borderSingleColor = UIColor.white
        
        let button2 = RoundButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        let image2 = #imageLiteral(resourceName: "settings.png")
        button2.setImageOnly(image: image2, color: UIColor.white)
        button2.borderThickness = 1
        button2.borderSingleColor = UIColor.white
        
        let button3 = RoundButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        let image3 = #imageLiteral(resourceName: "reset.png")
        button3.setImageOnly(image: image3, color: UIColor.white)
        button3.borderThickness = 1
        button3.borderSingleColor = UIColor.white

        
        circleView = CircleMenu(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.width))
        circleView.backgroundColor = UIColor.orange
        circleView.firstColor = UIColor.green
        circleView.secondColor = UIColor.blue
        circleView.gradient = true
 
        circleView.buttonsArray.append(button)
        circleView.buttonsArray.append(button2)
        circleView.buttonsArray.append(button3)
        circleView.corner = .bottomRight
        circleView.setButtons()
        
        self.view.insertSubview(circleView, at: 0)
        self.view.bringSubview(toFront: moreButton)
        
        circleView.prepareForAppearanceAnimations()
     

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

