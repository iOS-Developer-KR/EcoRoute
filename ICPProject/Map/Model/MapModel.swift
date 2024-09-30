//
//  MapModel.swift
//  ICPProject
//
//  Created by Taewon Yoon on 9/21/24.
//

import SwiftUI
import MapKit

// MapModel 정의
struct MapModel {
    
    /// 지도 카메라 위치
    var position: MapCameraPosition
    
    /// 지도 스카일
    var mapStyle: MapStyle
    
    /// 선택된 마커
    var selectedResult: MKMapItem?
    
    /// 카메라 시선 관찰
    var visibleRegion: MKCoordinateRegion
    
    /// 검색 기록 담는곳
    var searchResults: [MKMapItem]?
    
    /// 지도 스타일 결정 버튼 클릭 여부
    var showMapStyleButtons = false
    
    // DetilView 보여주는 트리거
    var sheetVisible: Bool = false
    
    // 검색 리스트 보여주는 트리거
    var showLists: Bool = false
    
}


