//
//  Shadow.swift
//  Shadow
//
//  Created by Christian Otkjær on 14/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit
import Animation
import Interpolation

//MARK: - Shadow

public struct Shadow
{
    var color : UIColor
    var offset : UIOffset
    var opacity : CGFloat
    var radius : CGFloat
    
    public init(
        color : UIColor = UIColor.clearColor(),
        offset : UIOffset = UIOffsetZero,
        opacity : CGFloat = 0,
        radius : CGFloat = 0
        )
    {
        self.color = color
        self.offset = offset
        self.opacity = opacity
        self.radius = radius
    }
    // MARK: Statics
    
    public static let None = Shadow()
    
    public static let Light = Shadow(color: UIColor.blackColor(), offset: UIOffsetZero, opacity: 0.3, radius: 1)
    
    public static let Dark = Shadow(color: UIColor.blackColor(), offset: UIOffset(horizontal: 2, vertical: 2), opacity: 0.8, radius: 3)
}

//MARK: - Equatable

extension Shadow : Equatable {}

public func == (lhs: Shadow, rhs:Shadow) -> Bool
{
    return lhs.color == rhs.color && lhs.offset == rhs.offset && lhs.opacity == rhs.opacity && lhs.radius == rhs.radius
}

// MARK: - CustomDebugStringConvertible

extension Shadow : CustomDebugStringConvertible
{
    public var debugDescription : String { return "Shadow(offset: \(offset), opacity: \(opacity), radius: \(radius), color: \(color))" }
}

// MARK: - LERP

func ◊ (ab: (Shadow, Shadow), t: CGFloat) -> Shadow
{
    let a = ab.0
    let b = ab.1
    
    return Shadow(
        color: (a.color, b.color) ◊ t,
        offset: (a.offset, b.offset) ◊ t,
        opacity: (a.opacity, b.opacity) ◊ t,
        radius: (a.radius, b.radius) ◊ t)
}

public extension UIView
{
    @IBInspectable
    var shadowColor : UIColor?
        {
        set { layer.shadowColor = newValue?.CGColor }
        get
        {
            if let shadowCgColor = layer.shadowColor
            {
                return UIColor(CGColor: shadowCgColor)
            }
            return nil
        }
    }
    
    @IBInspectable
    var shadowOffset : CGSize
        {
        set { layer.shadowOffset = newValue }
        get { return layer.shadowOffset }
    }
    
    @IBInspectable
    var shadowOpacity : CGFloat
        {
        set { layer.shadowOpacity = Float(newValue) }
        get { return CGFloat(layer.shadowOpacity) }
    }
    
    @IBInspectable
    var shadowRadius : CGFloat
        {
        set { layer.shadowRadius = newValue }
        get { return layer.shadowRadius }
    }
    
    public var shadow : Shadow
        {
        set
        {
            shadowColor = newValue.color
            shadowOffset = CGSize(width: newValue.offset.horizontal, height: newValue.offset.vertical)
            shadowOpacity = newValue.opacity
            shadowRadius = newValue.radius
        }
        
        get
        {
            return Shadow(
                color: shadowColor ?? UIColor.clearColor(),
                offset: UIOffset(horizontal: shadowOffset.width, vertical: shadowOffset.height),
                opacity: shadowOpacity,
                radius: shadowRadius)
        }
    }
    
    func setShadow(shadow: Shadow,
        duration: Double,
        timing: Animation.TimingFunction = .QuadraticEaseInOut,
        completion: (Bool -> ())? = nil)
    {
        let shadowBefore = self.shadow
        
        Animator.animate(duration,
            delay: 0,
            timingFunction: timing,
            closure: { self.shadow = (shadowBefore, shadow) ◊ CGFloat($0) },
            completion: completion)
    }
}

