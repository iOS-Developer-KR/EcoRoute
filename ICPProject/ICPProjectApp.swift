//
//  ICPProjectApp.swift
//  ICPProject
//
//  Created by Taewon Yoon on 9/6/24.
//

import SwiftUI

@main
struct ICPProjectApp: App {
    @StateObject private var mapViewModel: MapViewModel
    @StateObject private var searchViewModel: SearchViewModel

    init() {
        let routeVM = RouteViewModel()
        let mapVM = MapViewModel(routeVM: routeVM)
        _mapViewModel = StateObject(wrappedValue: mapVM)
        _searchViewModel = StateObject(wrappedValue: SearchViewModel(mapState: mapVM)) // 주입
    }

    var body: some Scene {
        WindowGroup {
            MapView()
                .environmentObject(mapViewModel)
                .environmentObject(searchViewModel)
        }
    }
}
