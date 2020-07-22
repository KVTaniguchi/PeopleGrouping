//
//  PlaceRow.swift
//  PeopleGrouping
//
//  Created by Kevin Taniguchi on 7/18/20.
//  Copyright © 2020 Kevin Taniguchi. All rights reserved.
//

import Combine
import SwiftUI

struct PlaceRow: View {
    @EnvironmentObject var resource: PeopleResource

    let id: String
    
    init(placeId: String) {
        id = placeId
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text(resource.itemsHashed[self.id]?.allPurposeName ?? "no name")
                    .fontWeight(.bold)
                Spacer()
                Text(resource.itemsHashed[self.id]?.shortDescription ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Text(resource.itemsHashed[self.id]?.location ?? "")
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
    }
}
