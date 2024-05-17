//
//  UserViewModel.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 03.05.2024.
//

import Foundation
import SwiftData

final class UserViewModel {
    var context: ModelContext!

    func read() -> User? {
        let fetchDescriptor = FetchDescriptor<SDUser>()
        let sdUsers = (try? context.fetch(fetchDescriptor))

        if sdUsers == nil || ((sdUsers?.isEmpty ?? true) == true)  {
            save(User(name: "User", image: nil))
        }
        guard let sdUser = sdUsers?.last else { return nil }

        return User(
            name: sdUser.name,
            image: sdUser.image
        )
    }

    func save(_ user: User) {
        let sdUser = SDUser(name: user.name, image: user.image)

        context.insert(sdUser)
        do {
            try context.save()
        }
        catch {
            Logger.log(kind: .swiftDataError, message: "Error saving user. \(error.localizedDescription)")
        }
    }
}
