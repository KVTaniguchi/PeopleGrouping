//
//  PeopleDetail.swift
//  Blacklister - Categorize People
//
//  Created by Kevin Taniguchi on 1/26/20.
//  Copyright © 2020 Kevin Taniguchi. All rights reserved.
//

import Foundation
import SwiftUI

struct PeopleDetail: View {
    @EnvironmentObject var resource: PeopleResource

    @State private var showingAlert = false
    @State private var isSaving = false
    @State private var shouldDisableSave: Bool = false
    @State private var modifiable: PersonScratchModel
    @State var isNewPerson: Bool
    private var isPersonDetail = false
    
    init(person: Person? = nil, isPersonDetail: Bool = true) {
        if let person = person {
            _isNewPerson = State(initialValue: false)
            _modifiable = State(initialValue: PersonScratchModel(existingPerson: person))
        } else {
            _isNewPerson = State(initialValue: true)
            _modifiable = State(initialValue: PersonScratchModel(isPersonDetail: isPersonDetail))
        }
        self.isPersonDetail = isPersonDetail
    }
    
    var body: some View {
        ZStack {
            if isSaving {
                Text("Saving...")
            } else if isPersonDetail {
                Form {
                    PeopleDataEntryFields(
                        modifiable: $modifiable,
                        shouldDisableSave: $shouldDisableSave
                    )
                    
                    // Buttons group
                    Group {
                        // save section
                        Section {
                            SaveButton(
                                shouldDisableSave: $shouldDisableSave,
                                modifiable: $modifiable,
                                isNewPerson: $isNewPerson,
                                isSaving: $isSaving,
                                showingAlert: $showingAlert
                            )
                            .environmentObject(self.resource)
                            .alert(isPresented: $showingAlert) {
                                Alert(title: Text("Not signed in"),
                                      message: Text("Please sign in to icloud"),
                                      dismissButton: .default(Text("Ok")))
                            }
                        }
                        // Delete Section
                        Section {
                            DeleteButton(
                                showingAlert: $showingAlert,
                                modifiable: $modifiable,
                                isSaving: $isSaving
                            ).environmentObject(self.resource)
                        }
                    }
                }
                .modifier(KeyboardHeightModifier())
                .navigationBarTitle("people")
            } else {
                Form {
                    PlaceEntryFields(
                        modifiable: $modifiable,
                        shouldDisableSave: $shouldDisableSave
                    )
                    
                    // Buttons group
                    Group {
                        // save section
                        Section {
                            SaveButton(
                                shouldDisableSave: $shouldDisableSave,
                                modifiable: $modifiable,
                                isNewPerson: $isNewPerson,
                                isSaving: $isSaving,
                                showingAlert: $showingAlert
                            )
                            .environmentObject(self.resource)
                            .alert(isPresented: $showingAlert) {
                                Alert(title: Text("Not signed in"),
                                      message: Text("Please sign in to icloud"),
                                      dismissButton: .default(Text("Ok")))
                            }
                        }
                        // Delete Section
                        Section {
                            DeleteButton(
                                showingAlert: $showingAlert,
                                modifiable: $modifiable,
                                isSaving: $isSaving
                            ).environmentObject(self.resource)
                        }
                    }
                }
                .modifier(KeyboardHeightModifier())
                .navigationBarTitle("places")
            }
        }
    }
}
