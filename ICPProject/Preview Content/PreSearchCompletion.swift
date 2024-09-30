//
//  PreSearchCompletion.swift
//  ICPProject
//
//  Created by Taewon Yoon on 9/22/24.
//

import MapKit


struct FakeSearchCompletion: Hashable {
    var title: String
    var subtitle: String
}

var preSearchCompletion: [FakeSearchCompletion] = [
    FakeSearchCompletion(title: "Coffee Shop", subtitle: "123 Main St"),
    FakeSearchCompletion(title: "Library", subtitle: "456 Oak Ave"),
    FakeSearchCompletion(title: "Park", subtitle: "789 Pine Dr")
]
