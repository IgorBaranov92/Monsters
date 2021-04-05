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
    
    static func locationErrorIn(_ vc: UIViewController,completion:@escaping (() -> Void )) -> UIAlertController? {
        let alert = UIAlertController(title: "Ошибка", message: "Не можем Вас найти, включите геолокацию", preferredStyle: .alert)
        let action = UIAlertAction(title: "Перейти в настройки", style: .cancel) {  (action) in
            alert.dismiss(animated: true) { completion()}
        }
        alert.addAction(action)
        vc.present(alert, animated: true)
        return alert
    }
    
    static func cameraErrorIn(_ vc: UIViewController,completion:@escaping (() -> Void ))  {
        let alert = UIAlertController(title: "Ошибка", message: "Включите камеру для поимки монстра", preferredStyle: .alert)
        let action = UIAlertAction(title: "Перейти в настройки", style: .cancel) {  (action) in
            alert.dismiss(animated: true) { completion()}
        }
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
    
}
