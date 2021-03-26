import Foundation
import CoreLocation

class LocationManager: CLLocationManager {
    
    init(delegate: CLLocationManagerDelegate) {
        super.init()
        requestWhenInUseAuthorization()
        startUpdatingLocation()
        distanceFilter = 50.0
        self.delegate = delegate
    }
    
}
