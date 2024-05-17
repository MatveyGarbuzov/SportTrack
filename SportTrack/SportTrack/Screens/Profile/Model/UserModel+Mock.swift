//
//  UserModel+Mock.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 12.04.2024.
//

import Foundation

extension UserModel {

    static let mock = UserModel(person: .mock, stats: .mock)
}

extension Person {

    static let mock = Person(name: "Matvey", surname: "Garbuzov", mail: "matvey@gmail.com")
}

extension Stats {

    static let mock = Stats(experience: .beginner, level: 5, percentage: 0.3)
}
