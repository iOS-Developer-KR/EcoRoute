//
//  FoundItemListView.swift
//  ICPProject
//
//  Created by Taewon Yoon on 9/10/24.
//

import SwiftUI
import MapKit

struct FoundItemListView: View {
    @EnvironmentObject var searchVM: SearchViewModel
    @EnvironmentObject var mapState: MapViewModel
    @Environment(\.dismiss) var dismiss
    var locationManager = LocationManager.shared
    
    var body: some View {
//        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        print("dismiss 왜 안되는건데")
//                        mapState.showLists = false
                        mapState.reset()
                        searchVM.removeState()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }.padding()
                
                Divider()
                
                scrollView
            }
//        }
    }
}

extension FoundItemListView {
    
    private var scrollView: some View {
        ScrollView {
            ForEach(searchVM.searchResults, id: \.self) { result in
                let distance = calculateDistance(coord1: result.placemark.coordinate, coord2: locationManager.region.center)
                
//                NavigationLink {
//                    SelectedDetailView()
//                } label: {
                Button {
                    // 이게 잠시 dismiss되고 detailview가 올라와야한다
                    // detailview가 닫히면 이게 다시 올라와야한다
                    mapState.model.showLists = false
                    mapState.model.selectedResult = result
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(result.name ?? "")
                            Text("\(convertMeterToKm(distance: distance))")
                        }.foregroundStyle(Color.black)
                        Spacer()
                        annotationImage(for: result)
                    }
                }
//                }
                
                Divider()
            }
            .presentationDetents([.fraction(0.45), .fraction(0.2)])
            .interactiveDismissDisabled()
            .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.45)))
            .padding()
            
            Spacer()
        }
    }
}

#Preview {
    FoundItemListView()
        .environmentObject(SearchViewModel(mapState: MapViewModel(routeVM: RouteViewModel())))
        .environmentObject(MapViewModel(routeVM: RouteViewModel()))
}
