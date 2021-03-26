import UIKit

@IBDesignable
class PlusButton: MapButton {

 
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 8, height: 8))
        color.setFill()
        path.fill()
        
        let plusPath = UIBezierPath()
        
        plusPath.move(to: CGPoint(x: rect.width*0.2, y: rect.midY))
        plusPath.addLine(to: CGPoint(x: rect.width*0.8, y: rect.midY))
        
        plusPath.move(to: CGPoint(x: rect.midX, y: rect.height*0.2))
        plusPath.addLine(to: CGPoint(x: rect.midX, y: rect.height*0.8))
        
        plusPath.lineWidth = 2.5
        pathColor.setStroke()
        plusPath.stroke()
    }

}
