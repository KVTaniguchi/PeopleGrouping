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
    
    var body: some View {
        List {
            ForEach(resource.people) { person in
                NavigationLink(destination: PeopleDetail(person: person)) {
                    PersonRow(personId: person.identifier)
                }
            }
        }
    }
}

//struct PeopleList_Previews: PreviewProvider {
//    static var previews: some View {
//        PeopleList()
//    }
//}
