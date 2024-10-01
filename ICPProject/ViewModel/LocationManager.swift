//
//  Map.swift
//  ICPProject
//
//  Created by Taewon Yoon on 9/6/24.
//

import Foundation
import MapKit

class LocationManager: NSObject, ObservableObject {
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    
    static var shared = LocationManager()
    private let manager = CLLocationManager()
    
    var isNearMe: Bool = true

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    @discardableResult
    func requestLocation() -> MKCoordinateRegion {
        manager.requestWhenInUseAuthorization()
        return region
    }
    
    func checkNearMe(cameraRegion: MKCoordinateRegion) -> Bool {
        requestLocation()
        print("거리계산")
        let distance = calculateDistance(lat1: region.center.latitude, lon1: region.center.longitude,
                                         lat2: cameraRegion.center.latitude, lon2: cameraRegion.center.longitude)

        return distance <= 500
    }

    func calculateDistance(lat1: CLLocationDegrees, lon1: CLLocationDegrees,
                           lat2: CLLocationDegrees, lon2: CLLocationDegrees) -> CLLocationDistance {
        let loc1 = CLLocation(latitude: lat1, longitude: lon1)
        let loc2 = CLLocation(latitude: lat2, longitude: lon2)
        
        return loc1.distance(from: loc2)
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.desiredAccuracy = kCLLocationAccuracyBest
            self.manager.requestWhenInUseAuthorization()
        case .denied:
            print("권한 거부됨")
        case .restricted:
            print("권한 제한됨")
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
        default:
            print("기타 상태")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
    }
}
