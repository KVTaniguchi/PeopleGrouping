//
//  PersonRow.swift
//  Blacklister - Categorize People
//
//  Created by Kevin Taniguchi on 1/19/20.
//  Copyright © 2020 Kevin Taniguchi. All rights reserved.
//

import Combine
import SwiftUI

struct PersonRow: View {
    @EnvironmentObject var resource: PeopleResource

    let id: String
    
    init(personId: String) {
        id = personId
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text(resource.itemsHashed[self.id]?.fullName ?? "no name").fontWeight(.bold)
                Spacer()
                Text(resource.itemsHashed[self.id]?.shortDescription ?? "").foregroundColor(.secondary)
            }
            HStack {
                Text(resource.itemsHashed[self.id]?.location ?? "").foregroundColor(.secondary)
                Spacer()
                Text(resource.itemsHashed[self.id]?.companyName ?? "").foregroundColor(.secondary)
            }
        }
    }
}

struct PersonRow_Previews: PreviewProvider {
    static var previews: some View {
        PersonRow(personId: "")
    }
}
