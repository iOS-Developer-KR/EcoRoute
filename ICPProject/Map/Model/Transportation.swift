//
//  Transportation.swift
//  ICPProject
//
//  Created by Taewon Yoon on 9/22/24.
//

import SwiftUI

enum Transportation: String {
    case walking
    case automobile
    case transit
    case bicycle
    case subway
    
    var image: (String,CGFloat,CGFloat) {
        switch self {
        case .walking:
            return ("figure.walk", 15, 20)
        case .automobile:
            return ("car.fill", 23, 20)
        case .transit:
            return ("bus", 15, 20)
        case .bicycle:
            return ("bicycle", 15, 20)
        case .subway:
            return ("tram", 15, 20)
        }
    }
    
    var color: Color {
        switch self {
        case .walking:
            return .cyan
        case .automobile:
            return .red
        case .transit:
            return .orange
        case .bicycle:
            return .blue
        case .subway:
            return .mint
        }
    }
}
