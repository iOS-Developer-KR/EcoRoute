//
//  SearchViewModel.swift
//  ICPProject
//
//  Created by Taewon Yoon on 9/22/24.
//

import SwiftUI
import Combine
import MapKit

class SearchViewModel: NSObject, ObservableObject {
    @Published var text: String = ""
    @Published var isSearchView: Bool = false
    @Published var searchCompletions: [MKLocalSearchCompletion] = []
    @Published var searchResults: [MKMapItem] = []
    
    private var searchCancellable = Set<AnyCancellable>()
    private var searchCompleter: MKLocalSearchCompleter
    var locationManager = LocationManager.shared
    var mapState: MapViewModel
    
    init(mapState: MapViewModel) {
        self.searchCompleter = MKLocalSearchCompleter()
        self.mapState = mapState
        super.init()
        self.searchCompleter.delegate = self
    }
    
    func removeState() {
        text = ""
        isSearchView = false
        searchCompletions = []
        searchCompletions = []
        searchResults = []
    }

    func addTextFieldSubscriber() {
        $text
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] query in
                self?.searchCompleter.queryFragment = query
            })
            .store(in: &searchCancellable)
    }
    
    @MainActor func search(for query: String, relocation: Bool = false) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        // 지역 재탐색 버튼이 눌린 상태라면 현재 카메라뷰 지역을 재탐색, 아니면 내 위치를 기준으로 탐색
        request.region = relocation ? mapState.model.visibleRegion : MKCoordinateRegion(
            center: locationManager.region.center, span: mapState.model.visibleRegion.span)
                
        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }
}

extension SearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.searchCompletions = completer.results
    }
}
