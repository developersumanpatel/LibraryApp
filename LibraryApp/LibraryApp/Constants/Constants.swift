//
//  Constants.swift
//  LibraryApp
//
//  Created by Suman on 13/08/21.
//

import Foundation
struct DefaultsKey {
    static let cartData = "CartData"
}

public enum StoreType: String, Codable {
    case store = "store"
    case online = "online"
}

public enum WeekDayType: String {
    case sun = "sun"
    case mon = "mon"
    case tue = "tue"
    case wed = "wed"
    case thu = "thu"
    case fri = "fri"
    case sat = "sat"
}
