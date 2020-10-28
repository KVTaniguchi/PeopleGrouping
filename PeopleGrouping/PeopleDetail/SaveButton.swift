//
//  SaveButton.swift
//  PeopleGrouping
//
//  Created by Kevin Taniguchi on 10/28/20.
//  Copyright © 2020 Kevin Taniguchi. All rights reserved.
//

import Foundation
import SwiftUI

struct SaveButton: View {
    @EnvironmentObject var resource: PeopleResource
    
    @Binding var shouldDisableSave: Bool
    @Binding var modifiable: PersonScratchModel
    @Binding var isNewPerson: Bool
    @Binding var isSaving: Bool
    @Binding var showingAlert: Bool
    
    init(
        shouldDisableSave: Binding<Bool>,
        modifiable: Binding<PersonScratchModel>,
        isNewPerson: Binding<Bool>,
        isSaving: Binding<Bool>,
        showingAlert: Binding<Bool>
    ) {
        _shouldDisableSave = shouldDisableSave
        _modifiable = modifiable
        _isNewPerson = isNewPerson
        _isSaving = isSaving
        _showingAlert = showingAlert
    }
    
    var body: some View {
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
    }
    
    private func updateAndDismiss(person: Person) {
        isSaving = false
        resource.itemsHashed[person.identifier] = person
    }
}
