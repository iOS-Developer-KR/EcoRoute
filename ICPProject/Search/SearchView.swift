//
//  SearchView.swift
//  ICPProject
//
//  Created by Taewon Yoon on 9/22/24.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var mapState: MapViewModel
    //    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var routeVM: RouteViewModel
    @EnvironmentObject var searchVM: SearchViewModel
    @FocusState private var focus: Bool
    var locationManager = LocationManager.shared
    
    var body: some View {
        
        if searchVM.isSearchView && searchVM.searchResults.isEmpty {
            VStack {
                Header
                
                Divider()
                
                completionList
                
                Spacer()
            }
            .frame(width: UIWindow.current?.frame.width, height: UIWindow.current?.frame.height)
            .background(Color.white)
            .onAppear {
                mapState.model.selectedResult = nil
                searchVM.addTextFieldSubscriber()
            }
        } else {
            SearchBar()
        }
        
    }
    
    var Header: some View {
        HStack {
            Image(systemName: "chevron.left")
                .foregroundStyle(Color.gray)
                .onTapGesture {
                    searchVM.removeState()
                }
                .padding(.horizontal, 3)
            
            TextField(text: $searchVM.text) {
                Text("장소, 버스, 지하철, 주소 검색")
            }
            .focused($focus)
            .onAppear {
                DispatchQueue.main.async {
                    self.focus = true
                }
            }
        }
        .padding(EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10))
    }
    
    var completionList: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(/*preSearchCompletion*/searchVM.searchCompletions, id: \.self) { completion in
                    HStack {
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.gray)
                            .padding(.leading)
                        Button {
                            searchVM.search(for: completion.title)
                            print("search 눌렸다")
                        } label: {
                            Text(completion.title)
                                .padding(.leading, 3)
                        }
                        
                        Spacer()
                    }
                    
                    Divider()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SearchView()
            .environmentObject(MapViewModel(routeVM: RouteViewModel()))
            .environmentObject(RouteViewModel())
            .environmentObject(SearchViewModel(mapState: MapViewModel(routeVM: RouteViewModel())))
    }
}
