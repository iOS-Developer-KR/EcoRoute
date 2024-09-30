//
//  LocationUtils.swift
//  ICPProject
//
//  Created by Taewon Yoon on 9/10/24.
//

import Foundation
import CoreLocation

// 두 좌표 간의 거리를 계산하는 함수 (Haversine formula 사용)
func calculateDistance(coord1: CLLocationCoordinate2D,
                       coord2: CLLocationCoordinate2D) -> CLLocationDistance {
    let loc1 = CLLocation(latitude: coord1.latitude, longitude: coord1.longitude)
    let loc2 = CLLocation(latitude: coord2.latitude, longitude: coord2.longitude)
    
    return loc1.distance(from: loc2) // 미터 단위로 반환
}

func convertMeterToKm(distance: CLLocationDistance) -> String {
    if distance >= 1000 {
        let km = distance / 1000
        return String(format: "%.2f km", km)  // 킬로미터로 변환하여 반환
    } else {
        return String(format: "%.0f m", distance)  // 미터 단위로 반환
    }
}

func calculateDistanceFromMe(to: CLLocationCoordinate2D) -> String {
    let current = LocationManager.shared.requestLocation()
    let distance = calculateDistance(coord1: current.center, coord2: to)
    return convertMeterToKm(distance: distance)
}


func calculateCarbonEmission(distance: Double, transportMode: Transportation) -> Double {
    let emissionFactor: Double // g CO₂/km
    switch transportMode {
    case .walking:
        emissionFactor = 0 // 도보는 탄소 배출 없음
    case .automobile:
        emissionFactor = 180 // 자동차의 킬로미터당 CO₂ 배출량 (가솔린 기준)
    case .transit:
        emissionFactor = 80 // 대중교통의 킬로미터당 CO₂ 배출량 (버스 기준)
    case .bicycle:
        emissionFactor = 0
    case .subway:
        emissionFactor = 56
    }
    
    let distanceInKm = distance / 1000 // 미터를 킬로미터로 변환

    // 탄소 배출량 계산 (단위: g)
    return distanceInKm * emissionFactor
}
