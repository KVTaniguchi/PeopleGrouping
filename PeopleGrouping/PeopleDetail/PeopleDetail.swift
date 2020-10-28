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
    @State var isNewPerson = false
    private var isPersonDetail = false
    
    init(person: Person? = nil, isPersonDetail: Bool = true) {
        if let person = person {
            _modifiable = State(initialValue: PersonScratchModel(existingPerson: person))
        } else {
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
                            .alert(isPresented: $showingAlert) {
                                Alert(title: Text("Not signed in"),
                                      message: Text("Please sign in to icloud"),
                                      dismissButton: .default(Text("Ok")))
                            }
                        }
                        // Delete Section
                        Section {
                            Button("Delete") {
                                guard FileManager.default.ubiquityIdentityToken != nil else {
                                    self.showingAlert = true
                                    return
                                }
                                
                                self.isSaving = true
                                CloudKitManager.shared.fetchRecord(identifier: self.modifiable.identifier) { (records, error) in
                                    guard let record = records?.first else { return }
                                    CloudKitManager.shared.delete(record: record) { (recordId, error) in
                                        self.resource.itemsHashed.removeValue(forKey: self.modifiable.identifier)
                                    }
                                }
                            }.foregroundColor(.red)
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
                            .alert(isPresented: $showingAlert) {
                                Alert(title: Text("Not signed in"),
                                      message: Text("Please sign in to icloud"),
                                      dismissButton: .default(Text("Ok")))
                            }
                        }
                        // Delete Section
                        Section {
                            Button("Delete") {
                                guard FileManager.default.ubiquityIdentityToken != nil else {
                                    self.showingAlert = true
                                    return
                                }
                                
                                self.isSaving = true
                                CloudKitManager.shared.fetchRecord(identifier: self.modifiable.identifier) { (records, error) in
                                    guard let record = records?.first else { return }
                                    CloudKitManager.shared.delete(record: record) { (recordId, error) in
                                        self.resource.itemsHashed.removeValue(forKey: self.modifiable.identifier)
                                    }
                                }
                            }.foregroundColor(.red)
                        }
                    }
                }
                .modifier(KeyboardHeightModifier())
                .navigationBarTitle("places")
            }
        }
    }
    
    private func updateAndDismiss(person: Person) {
        isSaving = false
        resource.itemsHashed[person.identifier] = person
    }
}
