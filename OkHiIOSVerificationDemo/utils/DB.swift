//
//  DB.swift
//  OkHiIOSVerificationDemo
//
//  Created by Julius Kiano on 13/11/2024.
//

import Foundation
import OkHi

public struct DBAddressResponse {
    public let user: OkHiUser
    public let location: OkHiLocation

    public init(user: OkHiUser, location: OkHiLocation) {
        self.user = user
        self.location = location
    }
}

public class DB {
    private static var user: OkHiUser?
    private static var location: OkHiLocation?
    
    public static func saveAddress(user: OkHiUser, location: OkHiLocation) {
        DB.user = user
        DB.location = location
    }
    
    public static func fetchSavedAddress() -> DBAddressResponse? {
        guard let user = DB.user, let location = DB.location else { return nil }
        return DBAddressResponse(user: user, location: location)
    }
}
