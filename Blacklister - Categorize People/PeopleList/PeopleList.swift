//
//  PeopleList.swift
//  Blacklister - Categorize People
//
//  Created by Kevin Taniguchi on 1/19/20.
//  Copyright © 2020 Kevin Taniguchi. All rights reserved.
//

import SwiftUI

struct PeopleList: View {
    @EnvironmentObject var resource: PeopleResource
    let category: PersonCategory
    
    init(category: PersonCategory) {
        self.category = category
    }
    
    var body: some View {
        List {
            ForEach(resource.itemsHashed.values.filter { $0.category == self.category }) { person in
                NavigationLink(destination: PeopleDetail(person: person, category: self.category)) {
                    PersonRow(personId: person.identifier)
                }
            }
        }
    }
}

struct PeopleList_Previews: PreviewProvider {
    static var previews: some View {
        PeopleList(category: .all)
    }
}
