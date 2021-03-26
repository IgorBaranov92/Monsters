import UIKit

class LocationButton: MapButton {

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 8, height: 8))
        color.setFill()
        path.fill()
        
        
        let outerCircle = UIBezierPath(arcCenter: CGPoint(x: rect.midX, y: rect.height*0.4), radius: rect.width*0.25, startAngle: 0, endAngle: .pi, clockwise: false)
        outerCircle.move(to: CGPoint(x: rect.width*0.25, y: rect.height*0.4))
        outerCircle.addLine(to: CGPoint(x: rect.midX, y: rect.height*0.8))
        outerCircle.addLine(to: CGPoint(x: rect.width*0.75, y: rect.height*0.4))

        UIColor.white.setFill()
        outerCircle.fill()
        
        let clearPath = UIBezierPath(arcCenter: CGPoint(x: rect.midX, y: rect.height*0.4), radius: rect.width*0.15, startAngle: 0, endAngle: .pi*2, clockwise: false)
        color.setFill()
        clearPath.fill()
        
        let innerCircle = UIBezierPath(arcCenter: CGPoint(x: rect.midX, y: rect.height*0.4), radius: rect.width*0.08, startAngle: 0, endAngle: .pi*2, clockwise: false)
        pathColor.setFill()
        innerCircle.fill()
    }

}
