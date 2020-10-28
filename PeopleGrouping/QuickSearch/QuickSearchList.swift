//
//  QuickSearchList.swift
//  PeopleGrouping
//
//  Created by Kevin Taniguchi on 7/18/20.
//  Copyright © 2020 Kevin Taniguchi. All rights reserved.
//

import SwiftUI

struct QuickSearch: View {
    @EnvironmentObject var resource: PeopleResource
    @State var needle: String = ""
    @State var pushed: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $needle)
                Spacer()
                List(filtered) { place in
                    NavigationLink(
                    destination: PeopleDetail(person: place.person)
                    ) {
                        self.highlight(
                            string: place.person.fullName,
                            indices: place.indices
                        )
                    }
                }
                .navigationBarTitle("search")
            }
        }
    }
    
    var filtered: [QuickSearchResult] {
        return resource.all.compactMap {
            guard let match = $0.haystack.fuzzyMatch(needle), !match.isEmpty else { return nil }
            return QuickSearchResult(person: $0, indices: match)
        }
    }
    
    func highlight(string: String, indices: [String.Index]) -> Text {
        var result = Text("")
        for i in string.indices {
            let char = Text(String(string[i]))
            if indices.contains(i) {
                result = result + char.bold()
            } else {
                result = result + char.foregroundColor(.secondary)
            }
        }
        return result
    }
}
