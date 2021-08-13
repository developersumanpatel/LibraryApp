//
//  LibrariesModel.swift
//  LibraryApp
//
//  Created by Suman on 13/08/21.
//

import Foundation
class LibrariesModel: Codable {
    var libraries: [LibraryModel]?
    
    enum CodingKeys: String, CodingKey {
        case libraries = "libraries"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        libraries = try container.decode([LibraryModel].self, forKey: .libraries)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(libraries, forKey: .libraries)
    }
}

class LibraryModel: Codable {
    var libraryId: String?
    var name: String?
    var logoUrl: String?
    var address: String?
    var country: String?
    var phoneNumber: String?
    var type: StoreType?
    var books: [BookModel]?
    var gps: GPSModel?
    var operatingTime: OperatingTimeModel?
    
    enum CodingKeys: String, CodingKey {
        case libraryId = "id"
        case name = "name"
        case logoUrl = "logoUrl"
        case address = "address"
        case country = "country"
        case phoneNumber = "phone"
        case type = "type"
        case books = "books"
        case gps = "gps"
        case operatingTime = "operatingTimes"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        libraryId = try container.decode(String.self, forKey: .libraryId)
        name = try container.decode(String.self, forKey: .name)
        logoUrl = try container.decode(String.self, forKey: .logoUrl)
        address = try container.decodeIfPresent(String.self, forKey: .address)
        country = try container.decode(String.self, forKey: .country)
        phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        books = try container.decodeIfPresent([BookModel].self, forKey: .books)
        gps = try container.decodeIfPresent(GPSModel.self, forKey: .gps)
        type = try container.decodeIfPresent(StoreType.self, forKey: .type)
        operatingTime = try container.decodeIfPresent(OperatingTimeModel.self, forKey: .operatingTime)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(libraryId, forKey: .libraryId)
        try container.encode(name, forKey: .name)
        try container.encode(logoUrl, forKey: .logoUrl)
        try container.encode(address, forKey: .address)
        try container.encode(country, forKey: .country)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(books, forKey: .books)
        try container.encode(gps, forKey: .gps)
        try container.encode(type, forKey: .type)
        try container.encode(operatingTime, forKey: .operatingTime)
    }
}

class OperatingTimeModel: Codable {
    var sun: [TimeModel]?
    var mon: [TimeModel]?
    var tue: [TimeModel]?
    var wed: [TimeModel]?
    var thu: [TimeModel]?
    var fri: [TimeModel]?
    var sat: [TimeModel]?
    
    enum CodingKeys: String, CodingKey {
        case sun = "sun"
        case mon = "mon"
        case tue = "tue"
        case wed = "wed"
        case thu = "thu"
        case fri = "fri"
        case sat = "sat"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sun = try container.decodeIfPresent([TimeModel].self, forKey: .sun)
        mon = try container.decodeIfPresent([TimeModel].self, forKey: .mon)
        tue = try container.decodeIfPresent([TimeModel].self, forKey: .tue)
        wed = try container.decodeIfPresent([TimeModel].self, forKey: .wed)
        thu = try container.decodeIfPresent([TimeModel].self, forKey: .thu)
        fri = try container.decodeIfPresent([TimeModel].self, forKey: .fri)
        sat = try container.decodeIfPresent([TimeModel].self, forKey: .sat)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sun, forKey: .sun)
        try container.encode(mon, forKey: .mon)
        try container.encode(tue, forKey: .tue)
        try container.encode(wed, forKey: .wed)
        try container.encode(thu, forKey: .thu)
        try container.encode(fri, forKey: .fri)
        try container.encode(sat, forKey: .sat)
    }
}

class TimeModel: Codable {
    var from: String?
    var to: String?
    
    enum CodingKeys: String, CodingKey {
        case from = "from"
        case to = "to"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        from = try container.decodeIfPresent(String.self, forKey: .from)
        to = try container.decodeIfPresent(String.self, forKey: .to)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(from, forKey: .from)
        try container.encode(to, forKey: .to)
    }
}

class GPSModel: Codable {
    var lat: Double?
    var long: Double?
    
    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case long = "lon"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lat = try container.decodeIfPresent(Double.self, forKey: .lat)
        long = try container.decodeIfPresent(Double.self, forKey: .long)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lat, forKey: .lat)
        try container.encode(long, forKey: .long)
    }
}

class BookModel: Codable {
    var bookId: String?
    var title: String?
    var description: String?
    var quantity: Int?
    var unitSold: Int?
    var currentViewers: Int?
    var price: Double?
    var rating: Float?
    var imageUrls: [String]?
    var cartQuantity: Int?
    
    enum CodingKeys: String, CodingKey {
        case bookId = "id"
        case title = "title"
        case description = "description"
        case quantity = "quantity"
        case unitSold = "unitSold"
        case currentViewers = "currentViewers"
        case price = "price"
        case rating = "rating5"
        case imageUrls = "imageUrls"
        case cartQuantity = "cartQuantity"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        bookId = try container.decodeIfPresent(String.self, forKey: .bookId)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        quantity = try container.decodeIfPresent(Int.self, forKey: .quantity)
        unitSold = try container.decodeIfPresent(Int.self, forKey: .unitSold)
        currentViewers = try container.decodeIfPresent(Int.self, forKey: .currentViewers)
        price = try container.decodeIfPresent(Double.self, forKey: .price)
        rating = try container.decodeIfPresent(Float.self, forKey: .rating)
        imageUrls = try container.decodeIfPresent([String].self, forKey: .imageUrls)
        cartQuantity = try container.decodeIfPresent(Int.self, forKey: .cartQuantity)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(bookId, forKey: .bookId)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(unitSold, forKey: .unitSold)
        try container.encode(currentViewers, forKey: .currentViewers)
        try container.encode(price, forKey: .price)
        try container.encode(rating, forKey: .rating)
        try container.encode(imageUrls, forKey: .imageUrls)
        try container.encode(cartQuantity, forKey: .cartQuantity)
    }
}

