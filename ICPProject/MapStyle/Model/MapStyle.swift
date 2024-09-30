//
//  MapStyle.swift
//  ICPProject
//
//  Created by Taewon Yoon on 9/6/24.
//

import SwiftUI
import MapKit

enum MapStyles: String {
    case standard // 일반
    case hybrid // 항공+도로명
    case real // 항공
    case flat
//    case traffic //
//    case transit
////    case driving
    

    var image: Image {
        switch self {
        case .standard:
            return Image(systemName: "map.fill")
        case .hybrid:
            return Image(systemName: "airplane")
//        case .traffic:
//            return Image(systemName: "car.2")
//        case .transit:
//            return Image(systemName: "bus")
//        case .driving:
//            return Image(systemName: "car")
        case .real:
            return Image(systemName: "airplane")
        case .flat:
            return Image(systemName: "airplane")
        }
    }
    
    var style: MapStyle {
        switch self {
        case .standard:
            return .standard()
        case .hybrid:
            return .hybrid(showsTraffic: false)
        case .real:
            return .imagery(elevation: .realistic)
        case .flat:
            return .imagery(elevation: .flat)
//        case .traffic:
//            return .hybrid(showsTraffic: true)
        
//        case .transit:
//            return .imagery(elevation: .flat)
        }
    }


}
