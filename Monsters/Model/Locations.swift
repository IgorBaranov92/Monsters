import Foundation
import CoreLocation


class Locations {
    
    static func getRandomLocations(count: Int,
                           from location: CLLocation,
                              completion: @escaping (([CLLocation]) -> ()) ) {
        DispatchQueue.global(qos: .userInitiated).sync {
            
            var locations = [CLLocation]()
            
            for _ in 1...count {
                var newLocation = CLLocation()
                let random = Int.random(in: 1...8)
                let randomMeters = 0.00900900900901 / Double(1000) * Double.random(in: 0...1000)
                switch random {
                case 1: newLocation = CLLocation(latitude: location.coordinate.latitude + randomMeters ,
                                              longitude: location.coordinate.longitude + randomMeters)
                case 2: newLocation = CLLocation(latitude: location.coordinate.latitude - randomMeters,
                                              longitude: location.coordinate.longitude - randomMeters)
                case 3: newLocation = CLLocation(latitude: location.coordinate.latitude + randomMeters,
                                              longitude: location.coordinate.longitude - randomMeters)
                case 4: newLocation = CLLocation(latitude: location.coordinate.latitude - randomMeters,
                                              longitude: location.coordinate.longitude + randomMeters)
                case 5: newLocation = CLLocation(latitude: location.coordinate.latitude + randomMeters,
                                              longitude: location.coordinate.longitude)
                case 6: newLocation = CLLocation(latitude: location.coordinate.latitude - randomMeters,
                                              longitude: location.coordinate.longitude)
                case 7: newLocation = CLLocation(latitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude - randomMeters)
                case 8: newLocation = CLLocation(latitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude + randomMeters)
                default:newLocation = CLLocation(latitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude + randomMeters)
                }
                locations.append(newLocation)
            }
            DispatchQueue.main.async {
                completion(locations)
            }
        }
    }
    
}
