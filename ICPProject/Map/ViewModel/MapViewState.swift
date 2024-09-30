//
//  ContentViewState.swift
//  ICPProject
//
//  Created by Taewon Yoon on 9/8/24.
//

import Foundation
import SwiftUI
import MapKit
import Combine


// ViewModel 정의
@MainActor
class MapViewModel: NSObject, ObservableObject {

    @Published var model: MapModel
    
    private var cancellables = Set<AnyCancellable>()
    var routeVM: RouteViewModel
    var previousSelectedResult: MKMapItem?
    
    
    
    init(routeVM: RouteViewModel) {
        self.routeVM = routeVM
        self.model = MapModel(position: .userLocation(fallback: .automatic), mapStyle: .standard, visibleRegion: .init())
        super.init()
        
        $model
            .map(\.selectedResult)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates() // 중복된 값을 제거합니다.
            .sink { [weak self] result in
                if result == nil {
                    self?.model.sheetVisible = false
                    return
                }
                
                if result != self?.previousSelectedResult {
                    if let result = result {
                        print(self?.previousSelectedResult?.name ?? "없음")
                        self?.model.sheetVisible = true
                        self?.reCalculateDirections(item: result)
                        self?.previousSelectedResult = result
                        withAnimation(.easeInOut) {
                            self?.model.position = .camera(.init(centerCoordinate: result.placemark.coordinate, distance: 1000))
                        }
                    }
                } else {
                    self?.model.sheetVisible = true
                }
            }
            .store(in: &cancellables)
    }
    
    func reset() {
        model.sheetVisible = false
        model.showLists = false
        previousSelectedResult = nil
    }
    

    
    func reCalculateDirections(item: MKMapItem) {
        routeVM.getDirections(item: item)
    }
    
    
}
