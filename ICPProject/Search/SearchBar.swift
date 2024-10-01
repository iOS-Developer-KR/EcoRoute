//
//  SearchBar.swift
//  ICPProject
//
//  Created by Taewon Yoon on 9/8/24.
//

import SwiftUI
import MapKit
import Combine

struct SearchBar: View {
    @EnvironmentObject var mapState: MapViewModel
    @EnvironmentObject var routeVM: RouteViewModel
    @EnvironmentObject var searchVM: SearchViewModel
    var locationManager = LocationManager.shared
    

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                Text("Search for a location...")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(5.0)
            .padding(.horizontal)
            .onTapGesture {
                searchVM.isSearchView = true
            }
            .overlay(alignment: .center) {
                if !locationManager.isNearMe && !searchVM.searchResults.isEmpty {
                    Button {
                        searchVM.search(for: searchVM.text, relocation: true)
                    } label: {
                        Text("↻ Reload this area")
                            .padding(8)
                            .font(.footnote)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                    }.padding(.top, 80)
                }
            }

            
     
            
        }
    }
}

#Preview {
    SearchBar(mapState: .init(), routeVM: .init(), locationManager: .init())
            .environmentObject(SearchViewModel(mapState: MapViewModel(routeVM: RouteViewModel())))
}
