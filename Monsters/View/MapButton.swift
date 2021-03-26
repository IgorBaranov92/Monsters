import UIKit

@IBDesignable
class MapButton: UIButton {

    @IBInspectable
    var color: UIColor = .red { didSet { setNeedsDisplay()}}
    
    @IBInspectable
    var pathColor: UIColor = .green { didSet { setNeedsDisplay() }}

}
