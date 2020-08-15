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
    @State private var isShowingingNewPerson: Bool = false
    
    var body: some View {
        NavigationView {
            List(resource.people) { person in
                NavigationLink(
                    destination: PeopleDetail(person: person)
                ) {
                    PersonRow(personId: person.identifier)
                }
            }
            .navigationBarTitle("people")
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
            PeopleDetail(isPersonDetail: true).environmentObject(self.resource)
        }
    }
}
