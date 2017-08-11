	//
//  ViewController.swift
//  Project Board
//
//  Created by Joe Soap on 2017/08/05.
//  Copyright © 2017 SinBros. All rights reserved.
//

import UIKit
let notificationKey = "SinBros.ProjectBoard.Notification.Control"

class ViewController: UIViewController {

    @IBOutlet weak var canvas: UIView!
    var components : [Int] = []
    let newComponentSize = CGSize(width: 125, height: 125)
    var tap:UITapGestureRecognizer!
    @IBOutlet weak var scrollView: UIScrollView!
    let notName = Notification.Name(rawValue: notificationKey)
    var index = -1
    
    func getImage(_ index: inout Int) -> UIImage {
        
        index += 1
        if index >= componentImages.count {
            index = 0
        }
        return componentImages[index].image
    }
    
    var componentImages : [(name: String,image: UIImage)] = [
        ("acvoltagesource" , #imageLiteral(resourceName: "acvoltagesource").resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch)),
        ("notgate" ,  #imageLiteral(resourceName: "nand").resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch)),
        ("capacitor" , #imageLiteral(resourceName: "capacitor").resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch)),
        ("diode" , #imageLiteral(resourceName: "diode").resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch)),
        ("xorgate" , #imageLiteral(resourceName: "xor") .resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch)),
        ("norgate" , #imageLiteral(resourceName: "or").resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch)),
        ("orgate" , #imageLiteral(resourceName: "or").resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch)),
        ("resistor" , #imageLiteral(resourceName: "resistor").resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch) ),
        ("inductor" , #imageLiteral(resourceName: "Inductor").resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch)),
        ("dcvoltagesource" , #imageLiteral(resourceName: "dcvoltagesource").resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch)),
        ("andgate" , #imageLiteral(resourceName: "andgate").resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch)),
        ("inverter" ,  #imageLiteral(resourceName: "inverter").resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch))
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        canvas.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(self.actOnControlNotification), name: Notification.Name(rawValue: notificationKey), object: nil)
    }
    
    func post(message: String) {
        NotificationCenter.default.post(name: notName, object: message)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        scrollView.contentSize = view.bounds.size
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func actOnControlNotification(_ notification:Notification) {
        let color = view.backgroundColor
        scrollView.backgroundColor = .white
        UIView.animate(withDuration: 1, animations: {
            self.view.backgroundColor = color
            })
    }
    
    
    @IBAction func trashComponent(_ sender: Any) {
        for vw in canvas.subviews {
            if vw is ComponentView {
                let cv = vw as! ComponentView
                if cv.isSelected {
                    vw.removeFromSuperview()
                }
                
            }
        }
    }
    
    @IBAction func pauseTapped(_ sender: Any) {
        post(message: "All your base are belong to us!")
    }
    @objc func handleTap() {
        let location = tap.location(in: view)
        for vw in canvas.subviews {
            if vw is ComponentView {
                let j = vw as! ComponentView
                let vwframe = j.frame
                if vwframe.minX < location.x && vwframe.minY < location.y &&
                    vwframe.maxX > location.x && vwframe.maxY > location.y {
                    j.isSelected = true
                } else {
                    j.isSelected = false
                }
                
                j.handleView.backgroundColor = j.currentColor()
                
            }
        }
        
    }
    
    @IBAction func addComponent() {
        let i = components.count
        let viewSize = self.view.bounds.size
        let resizeImage = getImage(&index)
        let newUI = ComponentView(with: CGRect(origin: CGPoint(x: viewSize.width / 2 - newComponentSize.width / 2, y: viewSize.height / 2 - newComponentSize.height / 2), size: newComponentSize), image: resizeImage )
        newUI.tag = i
        canvas.addSubview(newUI)
    }
 
    
        
    
}

