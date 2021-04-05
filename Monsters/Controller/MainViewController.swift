import UIKit
import GoogleMaps

class MainViewController: UIViewController, GMSMapViewDelegate,CLLocationManagerDelegate {

    lazy var locationManager = LocationManager(delegate: self)
    
    private(set) var monsters = [Monster]()
    private(set) var markers = [GMSMarker]()
    
    private var monster: Monster!
    private weak var timer: Timer!

    private var alert: UIAlertController?
    
    @IBOutlet weak var googleMap: GMSMapView! { didSet {
        googleMap.delegate = self
        googleMap.isMyLocationEnabled = true
    }}

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                           selector: #selector(checkLocationAvailable),
                                               name: UIApplication.didBecomeActiveNotification,
                                             object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        alert?.dismiss(animated: false)
        startUpdatingLocation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    @objc
    private func startUpdatingLocation() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            centerAtMe()
            timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateMap), userInfo: nil, repeats: true)
            if let location = locationManager.location,
                    !locationManager.foundLocation {
                    getMonstersIfPossibleAt(location)
                    locationManager.foundLocation = true
            }
        }
    }
    
    @objc
    private func checkLocationAvailable() {
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            alert = Alert.locationErrorIn(self) { Settings.open() }
            timer?.invalidate()
        } else {
            if locationManager.foundLocation {
                startUpdatingLocation()
            }
        }
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
            updateMonstersVisibility()
            if !locationManager.foundLocation {
                getMonstersIfPossibleAt(location)
                locationManager.foundLocation = true
            }
        }
    }
    
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        let markerPosition = CLLocation(latitude: marker.position.latitude,
                                       longitude: marker.position.longitude)
        if let myPosition = locationManager.location {
            let distance = myPosition.distance(from: markerPosition)
            if distance <= 150  {
                for i in monsters.indices {
                    if monsters[i].position == marker.position {
                        self.monster = monsters[i]
                        monsters.remove(at: i)
                        marker.map = nil
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
            markers.remove(at: $0)
        }
        
        if let location = locationManager.location {
            Locations.getRandomLocations(count: 10, from: location) { [unowned self](locations) in
                addMarkersFrom(locations)
            }
        }
        
    }
 
    
    private func addMarkersFrom(_ locations:[CLLocation]) {
        locations.forEach {
           if let myPosition = locationManager.location {
            let monster = Monster(latitude: $0.coordinate.latitude,
                                 longitude: $0.coordinate.longitude)
            monsters.append(monster)
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: monster.latitude,                                                         longitude: monster.longitude))
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
    
    private func updateMonstersVisibility() {
        if let myPosition = locationManager.location {
            markers.forEach {
                let distance = myPosition.distance(from: CLLocation(latitude: $0.position.latitude,                                                    longitude: $0.position.longitude))
                $0.map = distance <= 300 ? googleMap : nil
            }
        }
    }
    
}
