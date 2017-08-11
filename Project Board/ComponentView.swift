//
//  Component.swift
//  Project Board
//
//  Created by Joe Soap on 2017/08/05.
//  Copyright © 2017 SinBros. All rights reserved.
//

import UIKit

@objc protocol ComponentViewDelegate : class {
    func didReceiveTap(_ tapGestureRecognizer:UITapGestureRecognizer)
    func selectionStateChanged(_ isSelected:Bool)
    weak var delegate:ComponentViewDelegate? { get set }
}

class ComponentView: UIView {
    
    let notName = Notification.Name(rawValue: notificationKey)
    
    var delegate: ComponentViewDelegate?

    var panGestureRecognizer:UIPanGestureRecognizer!
    
    var offset:CGPoint!
    
    var handleView:UIView!
    var imageView:UIView!
    
    var isSelected:Bool! = false
    
    override init(frame: CGRect) {
        isSelected = false
        
        super.init(frame: frame)
        //imageView = UIImageView(image: UIImage(named: "Resistor"))
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.actOnNotification), name: notName, object: nil)
    }
    
    convenience init(with frame:CGRect, image:UIImage) {
        
        self.init(frame: frame)
        
        imageView = UIImageView(image: image)
        
        self.addSubview(imageView)
        self.bringSubview(toFront: handleView)
    }
    
    @objc func actOnNotification(_ object: Notification) {
        print(object.object as! String)
        let color = self.backgroundColor
        self.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        
        UIView.animate(withDuration: 0.4, animations: {
            self.backgroundColor = color
            })
    }
    
    
    func currentColor() -> UIColor {
        if let isSelected = isSelected {
            return isSelected ? .yellow : .blue
        } else {
            return .blue
        }
    }
    
    
    
    func setupUI() {
        
        handleView = UIView(frame: CGRect(x: frame.width - 20, y: 0, width: 20, height: 20 ))
        handleView.backgroundColor = .blue
        handleView.layer.cornerRadius = 10
        handleView.layer.borderColor = UIColor.cyan.cgColor
        handleView.layer.borderWidth = 1.0
        handleView.tag = 22
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handleDrag))
        
        handleView.addGestureRecognizer(panGestureRecognizer)
        self.backgroundColor = .black
        self.addSubview(handleView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        
    }
    
    @objc func handleTap() {
        isSelected = !isSelected
        
        handleView.backgroundColor = currentColor()
    }
    @objc func handleDrag() {
        self.offset = panGestureRecognizer.translation(in: self.superview!)
        if panGestureRecognizer.state == .changed {
            handleView.backgroundColor = .green
        } else {
            handleView.backgroundColor = currentColor()
        }
        var newLocation = self.frame.origin + offset
        if newLocation.x < 0 { newLocation.x = 0 }
        if newLocation.y < 0 { newLocation.y = 0 }
        self.frame.origin = newLocation
        panGestureRecognizer.setTranslation(CGPoint(x:0, y:0), in: self.superview!)
        
    }

}


extension CGPoint {
    static func + (lhs:CGPoint, rhs:CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    static func - (lhs:CGPoint, rhs:CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
}
