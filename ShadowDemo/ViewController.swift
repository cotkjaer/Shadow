//
//  ViewController.swift
//  ShadowDemo
//
//  Created by Christian Otkjær on 14/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit
import Shadow

class ViewController: UIViewController
{
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var shadowButton: UIButton!
    
    var shadows : [Shadow] = [Shadow.Light, Shadow.Dark, Shadow.None]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        shadows = [Shadow(color: UIColor.blackColor(), offset: UIOffset(horizontal: 30, vertical: 30), opacity: 0.8, radius : 5),
            Shadow(color: UIColor.blackColor(), offset: UIOffset(horizontal: -30, vertical: -30), opacity: 0.8, radius : 5)
        ]
    }
    
    @IBAction func cycleShadows()
    {
        shadowButton.enabled = false
        
        let shadow = shadows.removeFirst()
        
        shadows.append(shadow)
 
        shadowButton.setShadow(shadow, duration: 10)
        
        shadowView.setShadow(shadow, duration: 10) { _ in self.shadowButton.enabled = true }
    }
}

