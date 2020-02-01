//
//  PeopleResource.swift
//  Blacklister - Categorize People
//
//  Created by Kevin Taniguchi on 1/19/20.
//  Copyright © 2020 Kevin Taniguchi. All rights reserved.
//

import Combine
import Foundation

final class PeopleResource: ObservableObject {
    let objectWillChange = PassthroughSubject<[String: Person], Never>()
    
    var itemsHashed: [String: Person] = [:] {
        didSet {
            DispatchQueue.main.async {
                self.objectWillChange.send(self.itemsHashed)
            }
        }
    }
    
    var friends: [Person] {
        itemsHashed.values.filter { $0.category == .friend }
    }
    
    var enemies: [Person] {
        itemsHashed.values.filter { $0.category == .enemy }
    }
    
    var all: [Person] {
        itemsHashed.values.map { $0 }
    }
    
    init() {
        load()
    }
    
    func load() {
        CloudKitManager.shared.loadSavedConsumables { [weak self] (people, error) in
            var dict: [String: Person] = [:]
            
            people.forEach {
                dict[$0.identifier] = $0
            }
            
            self?.itemsHashed = dict
        }
    }
}
