//
//  Untitled.swift
//  ICPProject
//
//  Created by Taewon Yoon on 10/1/24.
//

import MapKit

// 임의의 좌표와 이름을 가진 MKMapItem 배열 생성
var fakeMapItem: [MKMapItem] = [
    MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194))), // 샌프란시스코
    MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437))), // 로스앤젤레스
    MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060))),  // 뉴욕
    MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278))),   // 런던
    MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 35.6895, longitude: 139.6917)))   // 도쿄
]



// 이제 fakeMapItem 배열에 채워진 데이터가 있습니다.
