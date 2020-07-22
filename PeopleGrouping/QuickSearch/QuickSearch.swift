//
//  QuickSearch.swift
//  PeopleGrouping
//
//  Created by Kevin Taniguchi on 7/20/20.
//  Copyright © 2020 Kevin Taniguchi. All rights reserved.
//

import Foundation

extension String {
    func fuzzyMatch(_ needle: String) -> [String.Index]? {
        var ixs: [Index] = []
        if needle.isEmpty { return [] }
        var remainder = needle[...].utf8
        for idx in utf8.indices {
            let char = utf8[idx]
            if char == remainder[remainder.startIndex] {
                ixs.append(idx)
                remainder.removeFirst()
                if remainder.isEmpty { return ixs }
            }
        }
        return nil
    }
}
