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
    
    @IBAction func cycleShadows()
    {
        let shadow = shadows.removeFirst()
        
        shadows.append(shadow)
        shadowView.shadow = shadow
        shadowButton.shadow = shadow
    }
}

