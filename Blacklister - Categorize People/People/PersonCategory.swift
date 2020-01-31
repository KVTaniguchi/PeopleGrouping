//
//  PersonCategory.swift
//  Blacklister - Categorize People
//
//  Created by Kevin Taniguchi on 1/19/20.
//  Copyright © 2020 Kevin Taniguchi. All rights reserved.
//

import Foundation

enum PersonCategory: String, Equatable, Identifiable, CaseIterable {
    case friend = "friend"
    case enemy = "enemy"
    case all = "all"
    
    var id: String {
        return rawValue
    }
}
