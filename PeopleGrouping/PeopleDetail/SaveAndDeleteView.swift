//
//  SaveAndDeleteView.swift
//  PeopleGrouping
//
//  Created by Kevin Taniguchi on 10/29/20.
//  Copyright © 2020 Kevin Taniguchi. All rights reserved.
//

import Foundation
import SwiftUI

struct SaveAndDeleteButtonsView: View {
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
        VStack {
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
                .alert(isPresented: $showingAlert) { () -> Alert in
                    Alert(title: Text("Not signed in"),
                          message: Text("Please sign in to icloud"),
                          dismissButton: .default(Text("Ok")))
                }.padding()
            }
            // Delete Section
            Section {
                DeleteButton(
                    showingAlert: $showingAlert,
                    modifiable: $modifiable,
                    isSaving: $isSaving
                ).environmentObject(self.resource).padding()
            }
        }
    }
}
