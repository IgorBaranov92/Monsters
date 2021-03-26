import UIKit
import GoogleMaps

class MainViewController: UIViewController, GMSMapViewDelegate,CLLocationManagerDelegate {

    lazy var locationManager = LocationManager(delegate: self)
    
    private(set) var monsters = [Monster]()
    private(set) var markers = [GMSMarker]()
    
    private var monster: Monster!
    private weak var timer: Timer!

    
    @IBOutlet weak var googleMap: GMSMapView! { didSet {
        googleMap.delegate = self
        googleMap.isMyLocationEnabled = true
    }}

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        centerAtMe()
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateMap), userInfo: nil, repeats: true)
        if let location = locationManager.location {
            getMonstersIfPossibleAt(location)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    @IBAction func zoomOut(_ sender: MinusButton) {
        googleMap.moveCamera(GMSCameraUpdate.zoomOut())
    }
    
    @IBAction func zoomIn(_ sender: PlusButton) {
        googleMap.moveCamera(GMSCameraUpdate.zoomIn())
    }
    
    @IBAction func centerAtMe(_ sender: LocationButton? = nil) {
        if let location = locationManager.location {
            showMeAt(location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            showMeAt(location)
            getMonstersIfPossibleAt(location)
        }
    }
    
    
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        let markerPosition = CLLocation(latitude: marker.position.latitude,
                                       longitude: marker.position.longitude)
        if let myPosition = locationManager.location {
            let distance = myPosition.distance(from: markerPosition)
            if distance <= 100  {
                for i in monsters.indices {
                    if monsters[i].latitude == marker.position.latitude &&
                        monsters[i].longitude == marker.position.longitude {
                        self.monster = monsters[i]
                        monsters.remove(at: i)
                        break
                    }
                }
                marker.map = nil
                performSegue(withIdentifier: "catchMonsterVC", sender: marker)
            } else {
                Alert.wrongDistaceIn(self, distance: Int(distance))
            }
        }
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "catchMonsterVC",
           let destinantion = segue.destination as? CatchMonsterViewController {
            destinantion.monster = monster
        }
    }
    
    private func showMeAt(_ location: CLLocation) {
        let coordinates = location.coordinate
        googleMap.camera = GMSCameraPosition(latitude: coordinates.latitude, longitude: coordinates.longitude, zoom: 16)
    }
    
    @objc
    private func updateMap() {
        
        var indexesToRemove = [Int]()
        for i in monsters.indices {
            if Probability.twentyPercent {
                indexesToRemove.append(i)
            }
        }
        indexesToRemove.sort(by: >)
        indexesToRemove.forEach {
            monsters.remove(at: $0)
            markers[$0].map = nil
        }
        if let location = locationManager.location {
            Locations.getRandomLocations(count: 6, from: location) { [unowned self](locations) in
                addMarkersFrom(locations)
            }
        }
        
    }
 
    
    private func addMarkersFrom(_ locations:[CLLocation]) {
        locations.forEach {
           let monster = Monster(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
           monsters.append(monster)
               let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: monster.latitude, longitude: monster.longitude))
               if let myPosition = locationManager.location {
                   let distance = myPosition.distance(from: CLLocation(latitude: marker.position.latitude, longitude: marker.position.longitude))
                   marker.icon = UIImage(named: "\(monster.name)")?.scaled
                   marker.map = distance <= 300 ? googleMap : nil
                   markers.append(marker)
               }
           }
    }
    
    private func getMonstersIfPossibleAt(_ location:CLLocation) {
        if monsters.isEmpty {
            Locations.getRandomLocations(count:30,from: location) {
                [unowned self](locations) in
                 addMarkersFrom(locations)
            }
        }
        
    }
    
}
