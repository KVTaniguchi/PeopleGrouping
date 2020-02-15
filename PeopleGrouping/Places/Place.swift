//
//  Place.swift
//  PeopleGrouping
//
//  Created by Kevin Taniguchi on 2/15/20.
//  Copyright © 2020 Kevin Taniguchi. All rights reserved.
//

import Foundation

struct PlaceScratchModel: Equatable, Identifiable {
    var id: String {
        identifier
    }
    
    var identifier: String = ""
    var name: String = ""
    var notes: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var location: String = ""
    var possibleAssociates: [Place] = []
    var associateIds: [String] = []
    var shortDescription: String = ""
    var ranking: Int = 0
    
    var rankingString: String {
        if ranking == 0 {
            return "No rank"
        } else {
            return "Rank: \(ranking)"
        }
    }
    
    init() {
        self.identifier = UUID().uuidString
        self.name = ""
        self.notes = ""
        self.email = ""
        self.phoneNumber = ""
        self.location = ""
        self.possibleAssociates = []
        self.associateIds = []
        self.shortDescription = ""
        self.ranking = 0
    }
    
    init(existingPlace: Place) {
        self.identifier = existingPlace.identifier
        self.name = existingPlace.name
        self.notes = existingPlace.notes ?? ""
        self.email = existingPlace.email ?? ""
        self.phoneNumber = existingPlace.phoneNumber ?? ""
        self.location = existingPlace.location ?? ""
        self.possibleAssociates = existingPlace.possibleAssociates ?? []
        self.associateIds = existingPlace.associateIds ?? []
        self.shortDescription = existingPlace.shortDescription ?? ""
        self.ranking = existingPlace.ranking
    }
}

struct Place: Equatable, Identifiable {
    var id: String {
        identifier
    }
    
    let identifier: String
    let name: String
    let notes: String?
    let email: String?
    let phoneNumber: String?
    let location: String?
    var possibleAssociates: [Place]?
    let associateIds: [String]?
    let shortDescription: String?
    let ranking: Int
    
    init(existingPlace: Place) {
        self.identifier = existingPlace.identifier
        self.name = existingPlace.name
        self.notes = existingPlace.notes
        self.email = existingPlace.email
        self.phoneNumber = existingPlace.phoneNumber
        self.location = existingPlace.location
        self.possibleAssociates = existingPlace.possibleAssociates
        self.associateIds = existingPlace.associateIds
        self.shortDescription = existingPlace.shortDescription
        self.ranking = existingPlace.ranking
    }
    
    
    init(scratchModel: PlaceScratchModel) {
        self.identifier = scratchModel.identifier
        self.name = scratchModel.name
        self.notes = scratchModel.notes
        self.email = scratchModel.email
        self.phoneNumber = scratchModel.phoneNumber
        self.location = scratchModel.location
        self.possibleAssociates = scratchModel.possibleAssociates
        self.associateIds = scratchModel.associateIds
        self.shortDescription = scratchModel.shortDescription
        self.ranking = scratchModel.ranking
    }
    
    init(identifier: String,
    name: String,
    notes: String? = nil,
    email: String? = nil,
    phoneNumber: String? = nil,
    location: String? = nil,
    possibleAssociates: [Place]? = nil,
    associateIds: [String]? = nil,
    shortDescription: String? = nil,
    ranking: Int = 0) {
        self.identifier = identifier
        self.name = name
        self.notes = notes
        self.email = email
        self.phoneNumber = phoneNumber
        self.location = location
        self.possibleAssociates = possibleAssociates
        self.associateIds = associateIds
        self.shortDescription = shortDescription
        self.ranking = ranking
    }
    
    private init(newIdentifier: String) {
        self.identifier = newIdentifier
        self.name = ""
        self.notes = nil
        self.email = nil
        self.phoneNumber = nil
        self.location = nil
        self.possibleAssociates = nil
        self.associateIds = nil
        self.shortDescription = nil
        self.ranking = 0
    }
    
    static func newPlace() -> Place {
        Place(newIdentifier: UUID().uuidString)
    }
}

extension Place {
    static let ckKey = "blackList"
    static let identifier = "placeidentifier"
    static let nameKey = "placenameKey"
    static let notes = "placenotesKey"
    static let email = "placeemailKey"
    static let phone = "placephoneKey"
    static let location = "placelocationKey"
    static let company = "placecompanyKey"
    static let associates = "placeassociatesKey"
    static let shortDescription = "placeshortDescriptionKey"
    static let ranking = "placerankingKey"
}
