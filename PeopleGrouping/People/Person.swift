//
//  Person.swift
//  Blacklister - Categorize People
//
//  Created by Kevin Taniguchi on 1/19/20.
//  Copyright © 2020 Kevin Taniguchi. All rights reserved.
//

import Foundation

struct PersonScratchModel: Equatable, Identifiable {
    var id: String {
        identifier
    }
    
    var identifier: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var middleName: String = ""
    var notes: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var location: String = ""
    var companyName: String = ""
    var occupation: String = ""
    var possibleAssociates: [Person] = []
    var associateIds: [String] = []
    var shortDescription: String = ""
    var ranking: Int = 0
    var personPlaceOrThing: PersonPlaceOrThing = .person
    var allPurposeName: String = ""
    
    var name: String {
        [firstName,
         lastName,
         companyName,
         email,
         location,
         companyName,
         occupation
            ].filter{ !$0.isEmpty }.joined(separator: " ")
    }
    
    var rankingString: String {
        if ranking == 0 {
            return "No rank"
        } else {
            return "Rank: \(ranking)"
        }
    }
    
    init() {
        self.identifier = UUID().uuidString
        self.firstName = ""
        self.lastName = ""
        self.middleName = ""
        self.notes = ""
        self.email = ""
        self.phoneNumber = ""
        self.location = ""
        self.companyName = ""
        self.occupation = ""
        self.possibleAssociates = []
        self.associateIds = []
        self.shortDescription = ""
        self.ranking = 0
        self.personPlaceOrThing = .person
        self.allPurposeName = ""
    }
    
    init(existingPerson: Person) {
        self.identifier = existingPerson.identifier
        self.firstName = existingPerson.firstName
        self.lastName = existingPerson.lastName
        self.middleName = existingPerson.middleName ?? ""
        self.notes = existingPerson.notes ?? ""
        self.email = existingPerson.email ?? ""
        self.phoneNumber = existingPerson.phoneNumber ?? ""
        self.location = existingPerson.location ?? ""
        self.companyName = existingPerson.companyName ?? ""
        self.occupation = existingPerson.occupation ?? ""
        self.possibleAssociates = existingPerson.possibleAssociates ?? []
        self.associateIds = existingPerson.associateIds ?? []
        self.shortDescription = existingPerson.shortDescription ?? ""
        self.ranking = existingPerson.ranking
        self.personPlaceOrThing = existingPerson.personPlaceOrThing
        self.allPurposeName = existingPerson.allPurposeName ?? ""
    }
}

struct Person: Equatable, Identifiable {
    var id: String {
        identifier
    }
    
    let identifier: String
    let firstName: String
    let lastName: String
    let middleName: String?
    let notes: String?
    let email: String?
    let phoneNumber: String?
    let location: String?
    let companyName: String?
    let occupation: String?
    var possibleAssociates: [Person]?
    let associateIds: [String]?
    let shortDescription: String?
    let ranking: Int
    let personPlaceOrThing: PersonPlaceOrThing
    let allPurposeName: String?
    
    init(existingPerson: Person) {
        self.identifier = existingPerson.identifier
        self.firstName = existingPerson.firstName
        self.lastName = existingPerson.lastName
        self.middleName = existingPerson.middleName
        self.notes = existingPerson.notes
        self.email = existingPerson.email
        self.phoneNumber = existingPerson.phoneNumber
        self.location = existingPerson.location
        self.companyName = existingPerson.companyName
        self.occupation = existingPerson.occupation
        self.possibleAssociates = existingPerson.possibleAssociates
        self.associateIds = existingPerson.associateIds
        self.shortDescription = existingPerson.shortDescription
        self.ranking = existingPerson.ranking
        self.personPlaceOrThing = existingPerson.personPlaceOrThing
        self.allPurposeName = existingPerson.allPurposeName
    }
    
    
    init(scratchModel: PersonScratchModel) {
        self.identifier = scratchModel.identifier
        self.firstName = scratchModel.firstName
        self.lastName = scratchModel.lastName
        self.middleName = scratchModel.middleName
        self.notes = scratchModel.notes
        self.email = scratchModel.email
        self.phoneNumber = scratchModel.phoneNumber
        self.location = scratchModel.location
        self.companyName = scratchModel.companyName
        self.occupation = scratchModel.occupation
        self.possibleAssociates = scratchModel.possibleAssociates
        self.associateIds = scratchModel.associateIds
        self.shortDescription = scratchModel.shortDescription
        self.ranking = scratchModel.ranking
        self.personPlaceOrThing = scratchModel.personPlaceOrThing
        self.allPurposeName = scratchModel.allPurposeName
    }
    
    init(identifier: String,
    firstName: String,
    lastName: String,
    middleName: String? = nil,
    notes: String? = nil,
    email: String? = nil,
    phoneNumber: String? = nil,
    location: String? = nil,
    companyName: String? = nil,
    occupation: String? = nil,
    possibleAssociates: [Person]? = nil,
    associateIds: [String]? = nil,
    shortDescription: String? = nil,
    ranking: Int = 0,
    personPlaceOrThing: PersonPlaceOrThing = .person,
    allPurposeName: String?
    ) {
        self.identifier = identifier
        self.firstName = firstName
        self.lastName = lastName
        self.middleName = middleName
        self.notes = notes
        self.email = email
        self.phoneNumber = phoneNumber
        self.location = location
        self.companyName = companyName
        self.occupation = occupation
        self.possibleAssociates = possibleAssociates
        self.associateIds = associateIds
        self.shortDescription = shortDescription
        self.ranking = ranking
        self.personPlaceOrThing = personPlaceOrThing
        self.allPurposeName = allPurposeName
    }
    
    private init(newIdentifier: String) {
        self.identifier = newIdentifier
        self.firstName = ""
        self.lastName = ""
        self.middleName = nil
        self.notes = nil
        self.email = nil
        self.phoneNumber = nil
        self.location = nil
        self.companyName = nil
        self.occupation = nil
        self.possibleAssociates = nil
        self.associateIds = nil
        self.shortDescription = nil
        self.ranking = 0
        self.personPlaceOrThing = .person
        self.allPurposeName = ""
    }
    
    static func newPerson() -> Person {
        Person(newIdentifier: UUID().uuidString)
    }
}

extension Person {
    var fullName: String {
        [firstName, middleName, lastName, allPurposeName.flatMap { $0 }].compactMap { $0 }.joined(separator: " ")
    }
    
    var haystack: String {
        [firstName,
         lastName,
         companyName,
         email,
         location,
         companyName,
         occupation
            ].compactMap { $0 }.filter{ !$0.isEmpty }.joined(separator: " ")
    }
}

extension Person {
    static let ckKey = "blackList"
    static let identifier = "identifier"
    static let firstNameKey = "firstNameKey"
    static let lastNameKey = "lastNameKey"
    static let middleNameKey = "middleNameKey"
    static let notes = "notesKey"
    static let email = "emailKey"
    static let phone = "phoneKey"
    static let location = "locationKey"
    static let company = "companyKey"
    static let occupation = "jobKey"
    static let associates = "associatesKey"
    static let shortDescription = "shortDescriptionKey"
    static let ranking = "rankingKey"
    static let personPlaceOrThing = "personPlaceorThing"
    static let allPurposeName = "allPurposeName"
}

enum PersonPlaceOrThing: Int {
    case person = 0
    case place = 1
    case thing = 2
}
