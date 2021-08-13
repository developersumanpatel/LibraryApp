//
//  LibraryManager.swift
//  LibraryApp
//
//  Created by Suman on 13/08/21.
//

import Foundation
typealias CompletionBlock = (_ success: Bool, _ response: Any?) -> Void
class LibraryManager {
    static let shared: LibraryManager = LibraryManager()
    
    func getAllBooks(completion: @escaping(CompletionBlock)) {
        if let data = self.retrieveFromJsonFile() {
            let decoder = JSONDecoder()
            do {
                let libraryModel = try decoder.decode(LibrariesModel.self, from: data)
                completion(true, libraryModel)
            } catch {
                completion(false, error.localizedDescription)
            }
        } else {
            completion(false, "No data available.")
        }
    }
    
    private func retrieveFromJsonFile() -> Data? {
        if let path = Bundle.main.path(forResource: "Library", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
                
            } catch {
                return nil
            }
        }
        return nil
    }
    
    func saveCartData(booksData: [BookModel]) {
        if let encoded = try? JSONEncoder().encode(booksData) {
            UserDefaults.standard.set(encoded, forKey: DefaultsKey.cartData)
            UserDefaults.standard.synchronize()
        }
    }
    
    func removeCartData() {
        UserDefaults.standard.removeObject(forKey: DefaultsKey.cartData)
        UserDefaults.standard.synchronize()
    }
    
    func getCartData() -> [BookModel]? {
        if let cartObject = UserDefaults.standard.data(forKey: DefaultsKey.cartData),
            let cart = try? JSONDecoder().decode([BookModel].self, from: cartObject) {
            return cart
        }
        return nil
    }
}
