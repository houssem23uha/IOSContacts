//
//  Contact.swift
//  ContactBook
//
//  Created by Houssem Eddine Hadji on 02/12/2020.
//

import UIKit
import Combine


class Contact: Identifiable, Codable, ObservableObject {
    @Published var firstName: String
    @Published var secondName: String
    @Published var adress: String
    @Published var phoneNumber: String
    @Published var email: String

    
    init(_ firstName: String,_ secondName: String,_ adress: String,_ phoneNumber: String,_ email: String) {
        self.firstName = firstName
        self.secondName = secondName
        self.adress = adress
        self.phoneNumber = phoneNumber
        self.email = email
    }
    
    // Codable protocol
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case secondName
        case adress
        case phoneNumber
        case email
    }
    
    // Decodable protocol
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try values.decode(String.self, forKey: .firstName)
        secondName = try values.decode(String.self, forKey: .secondName)
        adress = try values.decode(String.self, forKey: .adress)
        phoneNumber = try values.decode(String.self, forKey: .phoneNumber)
        email = try values.decode(String.self, forKey: .email)

    }
    
    // Encodable protocol
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(secondName, forKey: .secondName)
        try container.encode(adress, forKey: .adress)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(email, forKey: .email)
    }
    
    
}


class ContactBase {
    static var shared: ContactBase = readFromResources()
    var allContact: [Contact]
    
    private init() {
        allContact = []
    }

    
    func findContact(phone: String) -> Contact? {
        return allContact.first { $0.phoneNumber == phone }
    }
    
    func delete(contact: Contact) {
        if let index = allContact.firstIndex(where: { $0 === contact }) {
            allContact.remove(at: index)
        }
    }
    
    
    private static func readFromResources() -> ContactBase {
        let contactBase = ContactBase()
        do {
            if let url = Bundle.main.url(forResource: "Contacts", withExtension: nil),
                let data = NSData(contentsOf: url) {
                let jsonDecoder = JSONDecoder()
                let contacts = try jsonDecoder.decode([Contact].self, from: data as Data)
                contacts.forEach { contact in contactBase.addFromResources(contact) }
            }
        } catch {
        }
        return contactBase
    }
    
    fileprivate func addFromResources(_ contact: Contact) {
        if findContact(phone: contact.phoneNumber) == nil {
            allContact.append(contact)
        }
    }
    
}
