//
//  PlaceList.swift
//  PeopleGrouping
//
//  Created by Kevin Taniguchi on 2/15/20.
//  Copyright © 2020 Kevin Taniguchi. All rights reserved.
//

import SwiftUI

struct PlaceList: View {
    @EnvironmentObject var resource: PeopleResource
    
    var body: some View {
        List {
            ForEach(resource.places) { place in
                NavigationLink(destination: PeopleDetail(person: place, isPersonDetail: false)) {
                    PlaceRow(placeId: place.id)
                }
            }
        }
    }
}

//struct PlaceList_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceList()
//    }
//}

//struct PeopleList: View {
//    @EnvironmentObject var resource: PeopleResource
//
//    var body: some View {
//        List {
//            ForEach(resource.people) { person in
//                NavigationLink(destination: PeopleDetail(person: person)) {
//                    PersonRow(personId: person.identifier)
//                }
//            }
//        }
//    }
//}
