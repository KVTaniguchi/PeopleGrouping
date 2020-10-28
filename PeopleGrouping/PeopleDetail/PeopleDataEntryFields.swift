//
//  DataEntryFields.swift
//  PeopleGrouping
//
//  Created by Kevin Taniguchi on 10/28/20.
//  Copyright © 2020 Kevin Taniguchi. All rights reserved.
//

import Foundation
import SwiftUI

struct PeopleDataEntryFields: View {
    @Binding var modifiable: PersonScratchModel
    @Binding var shouldDisableSave: Bool
    
    var body: some View {
        Group {
            TextField("First Name", text: $modifiable.firstName, onEditingChanged: { didChange in
                self.shouldDisableSave = didChange
            })
            TextField("Last Name", text: $modifiable.lastName, onEditingChanged: { didChange in
                self.shouldDisableSave = didChange
            })
            TextField("Middle Name", text: $modifiable.middleName, onEditingChanged: { didChange in
                self.shouldDisableSave = didChange
            })
            Picker(selection: $modifiable.ranking, label: Text(modifiable.rankingString)) {
                ForEach((1..<11).reversed(), id: \.self) { int in
                    Text("\(int)")
                }
            }
            TextField("Location", text: $modifiable.location, onEditingChanged: { didChange in
                self.shouldDisableSave = didChange
            })
            TextField("Notes", text: $modifiable.notes, onEditingChanged: { didChange in
                self.shouldDisableSave = didChange
            })
            TextField("Short Description ", text: $modifiable.shortDescription, onEditingChanged: { didChange in
                self.shouldDisableSave = didChange
            })
        }
    }
}
