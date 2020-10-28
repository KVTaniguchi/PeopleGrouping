//
//  QuickSearchResult.swift
//  PeopleGrouping
//
//  Created by Kevin Taniguchi on 10/28/20.
//  Copyright © 2020 Kevin Taniguchi. All rights reserved.
//

import Foundation

struct QuickSearchResult: Identifiable {
    var id: String
    
    let person: Person
    let indices: [String.Index]
    
    init(person: Person, indices: [String.Index]) {
        self.person = person
        self.indices = indices
        self.id = person.identifier
    }
}
