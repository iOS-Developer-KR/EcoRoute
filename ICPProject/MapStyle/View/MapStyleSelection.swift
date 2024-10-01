//
//  MapStyleSelection.swift
//  ICPProject
//
//  Created by Taewon Yoon on 9/10/24.
//

import SwiftUI

//MARK: DEPRECATED
//struct MapStyleSelection: View {
//    @EnvironmentObject var mapState: MapViewModel
//    var body: some View {
//        HStack {
//            mayStyleSelectionButton(style: .standard, title: "일반")
//            mayStyleSelectionButton(style: .hybrid, title: "항공+도로명")
//            mayStyleSelectionButton(style: .real, title: "항공")
//        }
//        .safeAreaPadding(.top)
//        
//        
//    }
//    
//    private func mayStyleSelectionButton(style: MapStyles, title: String) -> some View {
//        VStack {
//            Button {
//                mapState.model.mapStyle = style.style
//            } label: {
//                style.image
//                    .foregroundStyle(.white)
//            }
//            .frame(width: 60, height: 60)
//            .background(Color.secondary)
//            .clipShape(Circle())
//            .padding(.horizontal, 10)
//            
//            Text(title)
//        }
//    }
//}
//
//#Preview {
//    MapStyleSelection()
//        .environmentObject(MapViewModel(routeVM: RouteViewModel()))
//}
