//
//  DeleteButton.swift
//  PeopleGrouping
//
//  Created by Kevin Taniguchi on 10/28/20.
//  Copyright © 2020 Kevin Taniguchi. All rights reserved.
//

import Foundation
import SwiftUI

struct DeleteButton: View {
    @EnvironmentObject var resource: PeopleResource
    
    @Binding var showingAlert: Bool
    @Binding var modifiable: PersonScratchModel
    @Binding var isSaving: Bool
    
    init(
        showingAlert: Binding<Bool>,
        modifiable: Binding<PersonScratchModel>,
        isSaving: Binding<Bool>
    ) {
        _showingAlert = showingAlert
        _modifiable = modifiable
        _isSaving = isSaving
    }
    
    var body: some View {
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
