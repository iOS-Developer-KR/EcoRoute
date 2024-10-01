//
//  SelectedDetailView.swift
//  ICPProject
//
//  Created by Taewon Yoon on 9/10/24.
//

import SwiftUI
import MapKit



struct SelectedDetailView: View {
    @EnvironmentObject var mapState: MapViewModel
    @EnvironmentObject var routeVM: RouteViewModel
    @Environment(\.dismiss) var dismiss
    @State private var selectedTransport: Transportation = .automobile
//    @State private var initialDistance: String? = nil
    var locationManager = LocationManager.shared

    var body: some View {
        VStack {
            
            Header
            
            DistanceText
            
            RouteButtons
            
            CarbonEmissionSummary
            
//            CarbonSeriousBar(transport: selectedTransport)
            
            Spacer()
        }
    }
    
    //MARK: HEADER VIEW
    var Header: some View {
        HStack {
            Text(mapState.model.selectedResult?.name ?? "")
                .font(.title2)
                .bold()
            
            Spacer()
            
            Button {
                mapState.model.selectedResult = nil
                dismiss()
            } label: {
                Image(systemName: "x.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.gray)
            }
        }
        .frame(height: 40)
        .padding(.horizontal)
        .padding(.top)
    }
    
    //MARK: DISTANCE 나타내는 뷰
    var DistanceText: some View {
        HStack {
//            Text("0m")
            if let state = mapState.model.selectedResult {
                Text("Distance: \(calculateDistanceFromMe(to: state.placemark.coordinate))")
            }
            Spacer()
        }
        .frame(height: 15)
        .padding(.horizontal)
    }
    
    //MARK: ROUTE 버튼
    func RouteButton(trans: Transportation, time: TimeInterval?, distance: Double, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack {
                Image(systemName: trans.image.0)
                    .resizable()
                    .frame(width: trans.image.1, height: trans.image.2)
//                Text("\(transferTimeInterval(time: time))")
//                    .font(.caption2)
                Text(trans.rawValue)
                    .font(.caption)
            }
        }
        .buttonStyle(routeButtonStyle())
    }

    //MARK: ROUTE 버튼들
    private var RouteButtons: some View {
        HStack {
            Spacer()
            RouteButton(trans: .walking, time: mapState.routeVM.walkRoute?.route?.expectedTravelTime, distance: mapState.routeVM.walkRoute?.route?.distance ?? 0) {
                mapState.routeVM.selectedRoute = mapState.routeVM.walkRoute
                mapState.model.selectedResult?.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking])
            }
            Spacer()
            RouteButton(trans: .automobile, time: mapState.routeVM.automobileRoute?.route?.expectedTravelTime, distance: mapState.routeVM.automobileRoute?.route?.distance ?? 0) {
                mapState.routeVM.selectedRoute = mapState.routeVM.automobileRoute
                mapState.model.selectedResult?.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
            }
            Spacer()
            RouteButton(trans: .transit, time: mapState.routeVM.transitRoute?.route?.expectedTravelTime, distance: mapState.routeVM.transitRoute?.route?.distance ?? 0) {
                mapState.routeVM.selectedRoute = mapState.routeVM.transitRoute
                mapState.model.selectedResult?.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeTransit])
            }
            Spacer()
        }
    }
    
    //MARK: 각 탄소 배출량 요약 뷰
    private var CarbonEmissionSummary: some View {
        VStack {
            Text("교통수단별 탄소 배출량")
                .font(.headline)
                .padding(.vertical, 10)

            HStack {
                CarbonBar(transport: .automobile, emission: calculateCarbonEmission(distance: mapState.routeVM.automobileRoute?.route?.distance ?? 0, transportMode: .automobile))
                
                CarbonBar(transport: .transit, emission: calculateCarbonEmission(distance: mapState.routeVM.automobileRoute?.route?.distance ?? 0, transportMode: .transit))
                
                CarbonBar(transport: .subway, emission: calculateCarbonEmission(distance: mapState.routeVM.automobileRoute?.route?.distance ?? 0, transportMode: .subway))
            }
            .frame(height: 20)
        }
        .padding(.horizontal)
    }
    
    //MARK: 각 교통수단별 탄소 배출량 막대기 표현
    func CarbonBar(transport: Transportation, emission: Double) -> some View {
        VStack {
                
            RoundedRectangle(cornerRadius: 5)
                .fill(transport.color)
                .overlay(
                    Text("\(emission, specifier: "%.0f") g CO₂")
                        .font(.caption2)
                        .foregroundColor(.white)
                        .padding(.horizontal, 5),
                    alignment: .center
                )

            Text(transport.rawValue)

        }
        .frame(height: 50)
    }
    
    //MARK: 특정 교통수단의 심각도
//    func CarbonSeriousBar(transport: Transportation) -> some View {
//        VStack {
//            RoundedRectangle(cornerRadius: 5)
//                .fill(transport.color)
//                .frame(width: 100, height: CGFloat(emission) / 10) // 배출량에 따른 높이 설정
//                .overlay(
//                    Text("\(emission, specifier: "%.0f") g CO₂")
//                        .font(.caption2)
//                        .foregroundColor(.white)
//                        .padding(.horizontal, 5),
//                    alignment: .center
//                )
//                .overlay(
//                    Text(label)
//                        .font(.caption)
//                        .foregroundColor(.white)
//                        .padding(.top, 5),
//                    alignment: .bottom
//                )
//        }
//    }

}

struct routeButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.white)
            .frame(width: 110, height: 60)
            .background(Color.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    NavigationStack {
        SelectedDetailView()//mapState: .init(), locationManager: .init(), routeVM: .init())
            .environmentObject(MapViewModel(routeVM: RouteViewModel()))            .environmentObject(LocationManager())
            .environmentObject(RouteViewModel())
    }
}
