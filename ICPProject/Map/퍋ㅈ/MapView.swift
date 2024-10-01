//
//  ContentView.swift
//  ICPProject
//
//  Created by Taewon Yoon on 9/6/24.
//

import SwiftUI
import MapKit


struct MapView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var routeVM: RouteViewModel
    @EnvironmentObject var mapState: MapViewModel
    @EnvironmentObject var searchVM: SearchViewModel
    
    var locationManager = LocationManager.shared

    var body: some View {
        MapReader { reader in
            mapView
                .sheet(isPresented: $mapState.model.showLists) {
                    FoundItemListView()
                        .presentationDetents(([.fraction(0.25), .fraction(0.45)]))
                        .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.25)))
                        .interactiveDismissDisabled()
                }
                .onChange(of: searchVM.searchResults, { oldValue, newValue in
                    if !newValue.isEmpty {
                        mapState.model.showLists = true
                    }
                })
                .onChange(of: mapState.model.selectedResult) { oldValue, newValue in
                    if !searchVM.searchResults.isEmpty && newValue == nil {
                        mapState.model.showLists = true
                    }
                }
        }
    }
    
    /// 지도가 내 위치와 동일한지 게산
    func checkNearMe() {
        let currentRegion = locationManager.region.center
        let visibleRegion = mapState.model.visibleRegion.center
        let distance = calculateDistance(coord1: currentRegion, coord2: visibleRegion)
        if distance > 500 { // 500미터보다 멀리 떨어져있으면
            locationManager.isNearMe = false
        } else {
            locationManager.isNearMe = true
        }
    }
    
    /// 선택된 항목들 초기화
    func initalization() {
        if mapState.model.selectedResult == nil {
            mapState.model.selectedResult = nil
        } else {
            mapState.model.selectedResult = nil
            if mapState.model.sheetVisible == true {
                mapState.model.sheetVisible = false
            }
        }
    }
}

extension MapView {

    private var mapView: some View {
        Map(position: $mapState.model.position, interactionModes: .all, selection: $mapState.model.selectedResult) {
            if let selected = mapState.model.selectedResult {
                Marker(item: selected)
            } else {
                ForEach(searchVM.searchResults, id: \.self) { result in
                    Marker(item: result)
                }
            }
            
            UserAnnotation()
            
        }
        .onTapGesture {
            print("onTapGeustre")
            initalization()
        }
        .overlay(alignment: .top) {
            VStack {
                SearchView()

                HStack {
                    
                    Spacer()

                    buttonOnMap

                }
                
            }
        }
        .sheet(isPresented: $mapState.model.sheetVisible) {
            SelectedDetailView()
                .presentationDetents([.fraction(0.35)])
                .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.35)))
        }
        .onMapCameraChange { context in
            mapState.model.visibleRegion = context.region
            if !searchVM.searchResults.isEmpty {
                checkNearMe()
            }
        }
        .mapStyle(mapState.model.mapStyle)
    }
    
    //MARK: UI PARTS
    
    private var buttonOnMap: some View {
        ZStack {
            Circle()
                .fill(Color(uiColor: .systemGray6))
                .frame(width: 40, height: 40) // 바깥 Circle 크기
                .shadow(radius: 5)
            Button {
                withAnimation(.spring) {
                    mapState.model.position = .userLocation(fallback: .automatic)
                }
                
            } label: {
                Image(systemName: mapState.model.position.followsUserLocation ? "location.fill" : "location")
                    .resizable()
                    .frame(width: 20, height: 20) // 안쪽 아이콘 크기
                    .foregroundColor(.blue) // 아이콘 색상
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    MapView()
        .environmentObject(MapViewModel(routeVM: RouteViewModel()))
        .environmentObject(RouteViewModel())
        .environmentObject(SearchViewModel(mapState: MapViewModel(routeVM: RouteViewModel())))
}
