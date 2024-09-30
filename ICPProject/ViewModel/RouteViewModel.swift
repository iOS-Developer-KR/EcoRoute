//
//  RouteViewModel.swift
//  ICPProject
//
//  Created by Taewon Yoon on 9/12/24.
//

import Foundation
import SwiftUI
import MapKit
import Combine

struct Route:Equatable {
    /// 경로
    var route: MKRoute?
    /// 탄소량
    var carbon: Int?
}

class RouteViewModel: ObservableObject {
    /// 도보 경로 찾기
    @Published var walkRoute: Route?

    /// 대중교통 경로 찾기
    @Published var transitRoute: Route?
    
    /// 자가용 경로 찾기
    @Published var automobileRoute: Route?
    
    /// 선택된 경로
    @Published var selectedRoute: Route?
    
    var walkCancellable: AnyCancellable?
    var autoCancellable: AnyCancellable?
    var transitCancellable: AnyCancellable?
    
    private var currentDestination: MKMapItem?

    // Combine을 사용하여 MKDirections 요청을 처리하는 메서드
    func getDirectionsPublisher(request: MKDirections.Request) -> Future<MKDirections.Response, Error> {
        Future { promise in
            let directions = MKDirections(request: request)
            directions.calculate { response, error in
                if let response = response {
                    promise(.success(response))
                } else if let error = error {
                    promise(.failure(error))
                }
            }
        }
    }
    
    @MainActor func getDirections(item: MKMapItem?) {
        // 새로운 목적지와 현재 목적지가 동일한지 확인하여 중복 호출 방지
//        if let destination = item, destination == currentDestination {
//            print("이미 탐색된 경로입니다. 중복 탐색 방지.")
//            return
//        }
        
        // 이전 구독을 취소
//        walkCancellable?.cancel()
//        autoCancellable?.cancel()
//        transitCancellable?.cancel()
        
        // 목적지가 달라지면 새로운 탐색을 실행
        currentDestination = item
        
        walkRoute = nil
        transitRoute = nil
        automobileRoute = nil
        
        guard let destination = item else { return }

        guard let walkRequest = createDirectionsRequest(to: destination, mode: .walking),
              let autoRequest = createDirectionsRequest(to: destination, mode: .automobile)
              /*let trasRequest = createDirectionsRequest(to: destination, mode: .transit)*/ else {
            return
        }
        
        // Combine을 사용하여 비동기적으로 경로를 계산
        let walkPublisher = getDirectionsPublisher(request: walkRequest)
        let autoPublisher = getDirectionsPublisher(request: autoRequest)
//        let transitPublisher = getDirectionsPublisher(request: trasRequest)
        
        // 각각의 퍼블리셔를 구독하여 경로를 업데이트
        walkCancellable = walkPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("도보 경로 계산 중 오류 발생: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] response in
                self?.walkRoute = Route(route: response.routes.first)
                self?.selectedRoute = self?.walkRoute
                //print("🤗\(self?.walkRoute?.route?.expectedTravelTime.description ?? "예상시간 없음")")
            })
        
        autoCancellable = autoPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("자가용 경로 계산 중 오류 발생: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] response in
                self?.automobileRoute = Route(route: response.routes.first)
            })
        
//        transitCancellable = transitPublisher
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                if case let .failure(error) = completion {
//                    print("대중교통 경로 계산 중 오류 발생: \(error.localizedDescription)")
//                }
//            }, receiveValue: { [weak self] response in
//                self?.transitRoute = Route(route: response.routes.first)
//            })
    }

    
    func createDirectionsRequest(to destination: MKMapItem, mode: MKDirectionsTransportType) -> MKDirections.Request? {
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = destination
        request.transportType = mode
        return request
    }
}
