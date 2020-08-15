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
    @State private var isShowingingNewPerson: Bool = false
    @State var pushed: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(resource.places) { place in
                    NavigationLink(
                        destination: PeopleDetail(
                                        person: place,
                                        isPersonDetail: false
                        )
                    ) {
                        PlaceRow(placeId: place.id)
                    }
                }
            }
            .navigationBarTitle("places")
            .navigationBarItems(
                trailing:
                addNewButton
            )
        }
    }
    
    private var addNewButton: some View {
        Button(action: {
            self.isShowingingNewPerson = true
        }) {
            Image(systemName: "plus.square.fill")
                .resizable()
                .frame(width: 25.0, height: 25.0)
                .foregroundColor(Color.blue)
        }.sheet(isPresented: self.$isShowingingNewPerson, onDismiss: {
            self.isShowingingNewPerson = false
        }) {
            PeopleDetail(
                isPersonDetail: false
            )
            .environmentObject(self.resource)
        }
    }
}
