//
//  Contact.swift
//  2017_11_28 Getting Data from Internet with error handling
//
//  Created by C4Q on 11/28/17.
//  Copyright © 2017 Quark. All rights reserved.
//
import Foundation

struct Results: Codable {
    let results: [Contact]
}
struct Contact: Codable {
    let gender: String
    let email: String
    let phone: String
    let cell: String
    let dob: String
    let name: nameWraper
    let location: locationWraper
    let picture: pictureWraper?
}
struct nameWraper: Codable {
    let title: String
    let first: String
    let last: String
}
struct locationWraper:Codable {
    let street: String
    let city: String
    let state: String
}
struct pictureWraper: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}
