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
    private var isNewPerson = false
    private var isPersonDetail = false
    
    init(person: Person? = nil, isPersonDetail: Bool = true) {
        if let person = person {
            _modifiable = State(initialValue: PersonScratchModel(existingPerson: person))
        } else {
            isNewPerson = true
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
                    
                    // Buttons group
                    Group {
                        // save section
                        Section {
                            Button("Save") {
                                guard FileManager.default.ubiquityIdentityToken != nil else {
                                    self.showingAlert = true
                                    return
                                }
                                
                                self.isSaving = true
                                
                                let updatedPerson = Person(scratchModel: self.modifiable)
                                if self.isNewPerson {
                                    CloudKitManager.shared.saveNew(person: updatedPerson) { (error) in
                                        self.updateAndDismiss(person: updatedPerson)
                                    }
                                } else {
                                    CloudKitManager.shared.mutate(person: updatedPerson) { _ in
                                        self.updateAndDismiss(person: updatedPerson)
                                    }
                                }
                            }
                            .disabled(shouldDisableSave)
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
                    Group {
                        TextField("Name", text: $modifiable.allPurposeName, onEditingChanged: { didChange in
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
                    
                    // Buttons group
                    Group {
                        // save section
                        Section {
                            Button("Save") {
                                guard FileManager.default.ubiquityIdentityToken != nil else {
                                    self.showingAlert = true
                                    return
                                }
                                
                                self.isSaving = true
                                
                                let updatedPerson = Person(scratchModel: self.modifiable)
                                if self.isNewPerson {
                                    CloudKitManager.shared.saveNew(person: updatedPerson) { (error) in
                                        self.updateAndDismiss(person: updatedPerson)
                                    }
                                } else {
                                    CloudKitManager.shared.mutate(person: updatedPerson) { _ in
                                        self.updateAndDismiss(person: updatedPerson)
                                    }
                                }
                            }
                            .disabled(shouldDisableSave)
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
