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
        VStack {
            HStack {
                Spacer()
                Button {
                    print("dismiss 왜 안되는건데")
                    mapState.reset()
                    searchVM.removeState()
                } label: {
                    Image(systemName: "xmark")
                }
            }.padding()
            
            Divider()
            
            scrollView
        }
    }
}

extension FoundItemListView {
    
    private var scrollView: some View {
        ScrollView {
            ForEach(/*fakeMapItem*/searchVM.searchResults, id: \.self) { result in
                let distance = calculateDistance(coord1: result.placemark.coordinate, coord2: locationManager.region.center)
                
                Button {
                    mapState.model.showLists = false
                    mapState.model.selectedResult = result
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(result.name ?? "")
                            Text("\(convertMeterToKm(distance: distance))")
                                .font(.footnote)
                                .foregroundStyle(Color.gray)
                        }.foregroundStyle(Color.black)
                        Spacer()
                        annotationImage(for: result)
                            .shadow(radius: 2)
                            .padding()
                    }
                }
                Divider()
            }
            .presentationDetents([.fraction(0.45), .fraction(0.2)])
            .interactiveDismissDisabled()
            .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.45)))
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

#Preview {
    FoundItemListView()
        .environmentObject(SearchViewModel(mapState: MapViewModel(routeVM: RouteViewModel())))
        .environmentObject(MapViewModel(routeVM: RouteViewModel()))
}
