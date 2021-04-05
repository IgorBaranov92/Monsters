import Foundation
import CoreLocation


class Locations {
    
    static private var randomDist: Double { 0.00000900900900901  * Double.random(in: -700...700) }
    
    static func getRandomLocations(count: Int,
                           from location: CLLocation,
                              completion: @escaping (([CLLocation]) -> ()) ) {
        
        DispatchQueue.global(qos: .userInitiated).sync {
            
            var locations = [CLLocation]()
            
            while locations.count != count {
                let randomLocation = CLLocation(latitude: location.coordinate.latitude + randomDist ,
                                                longitude: location.coordinate.longitude + randomDist)
                if !locations.contains(randomLocation) {
                    locations.append(randomLocation)
                }
            }
            
            DispatchQueue.main.async {
                completion(locations)
            }
        }
    }
    
}
