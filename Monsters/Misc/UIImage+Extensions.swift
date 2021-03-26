import Foundation
import UIKit

extension UIImage {
    
    static var randomMonster: UIImage {
        let randomName = Monsters.names.randomElement()
        return UIImage(named: "\(String(describing: randomName))")!
    }
    
    
    var scaled: UIImage? {
        let ratio = size.height/size.width
        let baseWidth:CGFloat = 70
        let newSize = CGSize(width: baseWidth, height: baseWidth*ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
