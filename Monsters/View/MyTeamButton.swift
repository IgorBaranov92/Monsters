import UIKit

@IBDesignable
class MyTeamButton: UIButton {

    @IBInspectable
    var color: UIColor = .red { didSet { setNeedsDisplay()}}
    
    @IBInspectable
    var cornerRadius: CGFloat = 1.0 { didSet { setNeedsDisplay()}}
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        color.setFill()
        path.fill()
    }

}
