//
//  Component.swift
//  Project Board
//
//  Created by Joe Soap on 2017/08/05.
//  Copyright © 2017 SinBros. All rights reserved.
//
/*
import UIKit

@IBDesignable
class ComponentView: UIView {
    
    var panGestureRecognizer:UIPanGestureRecognizer!
    var offset:CGPoint!
    
    @IBInspectable var handleView:UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        
        handleView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height / 2 ))
        handleView.backgroundColor = .blue
        handleView.layer.borderColor = UIColor.red.cgColor
        handleView.layer.borderWidth = 2.0
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handleDrag))
        handleView.addGestureRecognizer(panGestureRecognizer)
        self.backgroundColor = .black
        self.addSubview(handleView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        
    }
    
    @objc func handleDrag() {
        self.offset = panGestureRecognizer.translation(in: self.superview!)
        var newLocation = self.frame.origin + offset
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

//
//  CircuitKit.swift
//  Project Board
//
//  Created by Joe Soap on 2017/08/05.
//  Copyright © 2017 SinBros. All rights reserved.
//

protocol Component : class {
    
    weak var inputTerminal : Component? { get set }
    weak var outputTerminal : Component? { get set }
    var componentType : ComponentType { get }
}

protocol ActiveComponent : class {
    var output : EnergyMetric { get set }
}

protocol PassiveComponent : class {
    var energyDelta : EnergyMetric { get set     }
}

struct EnergyMetric {
    var voltage : Double
    var resistance : Double
    var current : Double
}

enum ComponentType {
    case passive
    case active
    case electromechanical
}

class CopperWire : Component {
    
    weak var inputTerminal: Component?
    weak var outputTerminal: Component?
    let componentType: ComponentType = .passive
    
}


class ViewController: UIViewController {
    
    @IBOutlet weak var canvas: UIView!
    var components : [Int] = []
    let newComponentSize = CGSize(width: 100, height: 100)
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
    @IBAction func addComponent() {
        let i = components.count
        let viewSize = self.view.bounds.size
        let newUI = ComponentView(frame: CGRect(origin: CGPoint(x: viewSize.width / 2 - newComponentSize.width / 2, y: viewSize.height / 2 - newComponentSize.height / 2), size: newComponentSize))
        newUI.tag = i
        canvas.addSubview(newUI)
    }
    
}
*/

