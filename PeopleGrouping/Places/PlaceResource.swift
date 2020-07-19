//
//  PlaceResource.swift
//  PeopleGrouping
//
//  Created by Kevin Taniguchi on 7/18/20.
//  Copyright © 2020 Kevin Taniguchi. All rights reserved.
//

import Combine
import Foundation

final class PlaceResource: ObservableObject {
    let objectWillChange = PassthroughSubject<[String: Place], Never>()
    
    var itemsHashed: [String: Place] = [:] {
        didSet {
            DispatchQueue.main.async {
                self.objectWillChange.send(self.itemsHashed)
            }
        }
    }
    
    var all: [Place] {
        itemsHashed.values.map { $0 }
    }
    
    init() {
        load()
    }
    
    func load() {
//        CloudKitManager.shared.loadSavedConsumables { [weak self] (people, error) in
//            var dict: [String: Person] = [:]
//
//            people.forEach {
//                dict[$0.identifier] = $0
//            }
//
//            self?.itemsHashed = dict
//        }
    }
    
    var places: [Place] {
        itemsHashed.values.sorted(by: { $0.ranking > $1.ranking })
    }
}
