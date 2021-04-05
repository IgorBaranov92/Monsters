import Foundation
import CoreLocation

struct Monster: Codable {
    
    let name: String
    let level: Int
    let latitude: Double
    let longitude: Double
    
    var position: CLLocationCoordinate2D { CLLocationCoordinate2D(latitude: latitude, longitude: longitude)}
    
    init(latitude:Double,longitude:Double) {
        self.level = Int.random(in: 5...20)
        self.latitude = latitude
        self.longitude = longitude
        self.name = Monsters.names.randomElement() ?? "Kano"
    }
    
}


extension Monster: CustomStringConvertible {
    
    var description: String {
        "name = \(name) level = \(level)"
    }
    
}

extension CLLocationCoordinate2D: Equatable {
    
    public static func ==(lhs:CLLocationCoordinate2D,rhs:CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    
}
