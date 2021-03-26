import Foundation

struct Monster: Codable {
    
    let name: String
    let level: Int
    let latitude: Double
    let longitude: Double
    
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
