import UIKit

class MinusButton: MapButton {

    override func draw(_ rect: CGRect) {
        
        let minusPath = UIBezierPath()
        
        minusPath.move(to: CGPoint(x: rect.width*0.2, y: rect.midY))
        minusPath.addLine(to: CGPoint(x: rect.width*0.8, y: rect.midY))
        
        minusPath.lineWidth = 2.5
        pathColor.setStroke()
        minusPath.stroke()
        
    }

}
