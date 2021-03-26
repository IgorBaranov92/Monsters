import UIKit

class Alert {
    
    static func wrongDistaceIn(_ vc:UIViewController,distance:Int) {
        let alert = UIAlertController(title: "Ошибка", message: "Вы находитесь слишком далеко от монстра – \(Int(distance)) метров", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { [unowned alert] (action) in
            alert.dismiss(animated: true)
        }
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
    
    static func successIn(_ vc: UIViewController,name:String,completion:@escaping (() -> Void )) {
        let alert = UIAlertController(title: "Ура", message: "Вы поймали монстра \(name) в свою команду", preferredStyle: .alert)
        let action = UIAlertAction(title: "Вернуться на карту", style: .cancel) { (action) in
            completion()
        }
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
    
    static func failureIn(_ vc: UIViewController,completion:@escaping (() -> Void )) {
        let alert = UIAlertController(title: "Поражение", message: "Монст убежал", preferredStyle: .alert)
        let action = UIAlertAction(title: "Вернуться на карту", style: .cancel) {  (action) in
            completion()
        }
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
    
    static func recatch(_ vc: UIViewController,completion:@escaping (() -> Void )) {
        let alert = UIAlertController(title: "Не вышло", message: "Попробуйте поймать еще раз", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) {  (action) in
            completion()
        }
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
    
}
