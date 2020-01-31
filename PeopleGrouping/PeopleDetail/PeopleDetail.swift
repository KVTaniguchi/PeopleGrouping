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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var showingAlert = false
    @State private var isSaving = false
    @State private var shouldDisableSave: Bool = false
    @State private var modifiable: PersonScratchModel
    @State private var updatedCategory: Int
    private var isNewPerson: Bool = false
    
    let category: PersonCategory
    
    init(person: Person? = nil, category: PersonCategory) {
        if let person = person {
            _modifiable = State(initialValue: PersonScratchModel(existingPerson: person))
        } else {
            isNewPerson = true
            _modifiable = State(initialValue: PersonScratchModel())
        }
        self.category = category
        _updatedCategory = State(initialValue: category == .enemy ? 0 : 1)
    }
    
    var body: some View {
        NavigationView {
            if isSaving {
                Text("Saving...")
            } else {
                Form {
                    Group {
                        TextField("First Name", text: $modifiable.firstName, onEditingChanged: { didChange in
                            self.shouldDisableSave = didChange
                        })
                        TextField("Last Name", text: $modifiable.lastName, onEditingChanged: { didChange in
                            self.shouldDisableSave = didChange
                        })
                        Picker("Friend or Enemy", selection: $updatedCategory) {
                            Text("Enemy").tag(0)
                            Text("Friend").tag(1)
                        }.pickerStyle(SegmentedPickerStyle())
                        TextField("Middle Name", text: $modifiable.middleName, onEditingChanged: { didChange in
                            self.shouldDisableSave = didChange
                        })
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
//                                guard FileManager.default.ubiquityIdentityToken != nil else {
//                                    self.showingAlert = true
//                                    return
//                                }
                                
                                self.isSaving = true
                                
                                if self.updatedCategory == 0 {
                                    self.modifiable.category = .enemy
                                } else {
                                    self.modifiable.category = .friend
                                }
                                
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
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                }
                            }.foregroundColor(.red)
                        }
                    }
                }
                .modifier(KeyboardHeightModifier())
            }
        }.navigationBarTitle(self.category.rawValue)
    }
    
    private func updateAndDismiss(person: Person) {
        self.resource.itemsHashed[person.identifier] = person
        DispatchQueue.main.async {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct PeopleDetail_Previews: PreviewProvider {
    static var previews: some View {
        PeopleDetail(category: .all)
    }
}