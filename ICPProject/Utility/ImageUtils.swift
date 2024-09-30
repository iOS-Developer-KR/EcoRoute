//
//  ImageUtils.swift
//  ICPProject
//
//  Created by Taewon Yoon on 9/10/24.
//

import Foundation
import MapKit
import SwiftUI

func annotationImage(for result: MKMapItem) -> some View {
    let iconName = PointOfInterests.icon(for: result.pointOfInterestCategory ?? .restaurant)?.systemImage ?? "mappin.circle"
    return Image(systemName: iconName)
}
