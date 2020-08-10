//
//  QuickSearchList.swift
//  PeopleGrouping
//
//  Created by Kevin Taniguchi on 7/18/20.
//  Copyright © 2020 Kevin Taniguchi. All rights reserved.
//

import SwiftUI

// goal create a quick search list in swift UI
struct QuickSearch: View {
    @EnvironmentObject var resource: PeopleResource
    @State var needle: String = ""
    
    var body: some View {
        VStack {
            SearchBar(text: $needle)
            Spacer()
            List(filtered) { place in
                NavigationLink(destination: PeopleDetail(person: place.person)) {
                    self.highlight(
                        string: place.person.fullName,
                        indices: place.indices
                    )
                }
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
