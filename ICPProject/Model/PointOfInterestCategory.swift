//
//  PointOfInterestCategory.swift
//  ICPProject
//
//  Created by Taewon Yoon on 9/9/24.
//

import SwiftUI
import MapKit

enum PointOfInterests: String, CaseIterable {
    case airport = "공항"
    case amusementPark = "놀이공원"
    case aquarium = "수족관"
    case atm = "ATM"
    case bakery = "빵집"
    case beach = "해변"
    case brewery = "양조장"
    case cafe = "카페"
    case campground = "캠프장"
    case carRental = "렌터카"
    case evCharger = "전기차 충전소"
    case fireStation = "소방서"
    case fitnessCenter = "피트니스 센터"
    case foodMarket = "식료품 시장"
    case gasStation = "주유소"
    case hospital = "병원"
    case hotel = "호텔"
    case laundry = "세탁소"
    case library = "도서관"
    case marina = "마리나"
    case movieTheater = "영화관"
    case nationalPark = "국립공원"
    case nightlife = "나이트라이프"
    case park = "공원"
    case parking = "주차장"
    case pharmacy = "약국"
    case police = "경찰서"
    case postOffice = "우체국"
    case publicTransport = "대중교통"
    case restaurant = "식당"
    case restroom = "화장실"
    case school = "학교"
    case stadium = "경기장"
    case store = "상점"
    case theater = "극장"
    case university = "대학교"
    case winery = "와이너리"
    case zoo = "동물원"
    case museum = "박물관"
    case bank = "은행"
    
    var displayName: String {
        return self.rawValue
    }
    
    // 아이콘에 해당하는 SF Symbol 이름
    var systemImage: String {
        switch self {
        case .airport: return "airplane"
        case .amusementPark: return "sparkles"
        case .aquarium: return "tortoise"
        case .atm: return "creditcard"
        case .bakery: return "cup.and.saucer"
        case .beach: return "sun.max"
        case .brewery: return "bottle"
        case .cafe: return "cup.and.saucer"
        case .campground: return "tent"
        case .carRental: return "car.fill"
        case .evCharger: return "bolt.car"
        case .fireStation: return "flame"
        case .fitnessCenter: return "figure.walk"
        case .foodMarket: return "cart"
        case .gasStation: return "fuelpump"
        case .hospital: return "cross.case"
        case .hotel: return "bed.double.fill"
        case .laundry: return "washer.fill"
        case .library: return "books.vertical"
        case .marina: return "sailboat"
        case .movieTheater: return "film"
        case .nationalPark: return "leaf.fill"
        case .nightlife: return "music.note"
        case .park: return "tree"
        case .parking: return "parkingsign.circle"
        case .pharmacy: return "pills"
        case .police: return "shield"
        case .postOffice: return "envelope"
        case .publicTransport: return "tram"
        case .restaurant: return "fork.knife"
        case .restroom: return "figure.restroom"
        case .school: return "graduationcap.fill"
        case .stadium: return "sportscourt"
        case .store: return "bag.fill"
        case .theater: return "theatermasks.fill"
        case .university, .museum, .bank: return "building.columns"
        case .winery: return "wineglass.fill"
        case .zoo: return "pawprint"
        }
    }
    
    // 카테고리와 아이콘을 매칭하는 함수
    static func icon(for category: MKPointOfInterestCategory) -> PointOfInterests? {
        switch category {
        case .airport: return .airport
        case .amusementPark: return .amusementPark
        case .aquarium: return .aquarium
        case .atm: return .atm
        case .bakery: return .bakery
        case .bank: return .bank
        case .beach: return .beach
        case .brewery: return .brewery
        case .cafe: return .cafe
        case .campground: return .campground
        case .carRental: return .carRental
        case .evCharger: return .evCharger
        case .fireStation: return .fireStation
        case .fitnessCenter: return .fitnessCenter
        case .foodMarket: return .foodMarket
        case .gasStation: return .gasStation
        case .hospital: return .hospital
        case .hotel: return .hotel
        case .laundry: return .laundry
        case .library: return .library
        case .marina: return .marina
        case .movieTheater: return .movieTheater
        case .museum: return .museum
        case .nationalPark: return .nationalPark
        case .nightlife: return .nightlife
        case .park: return .park
        case .parking: return .parking
        case .pharmacy: return .pharmacy
        case .police: return .police
        case .postOffice: return .postOffice
        case .publicTransport: return .publicTransport
        case .restaurant: return .restaurant
        case .restroom: return .restroom
        case .school: return .school
        case .stadium: return .stadium
        case .store: return .store
        case .theater: return .theater
        case .university: return .university
        case .winery: return .winery
        case .zoo: return .zoo
        default: return nil
        }
    }
}
