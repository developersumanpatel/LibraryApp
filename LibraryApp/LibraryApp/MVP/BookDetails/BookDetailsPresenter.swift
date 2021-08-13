//
//  BookDetailsPresenter.swift
//  LibraryApp
//
//  Created by Suman on 13/08/21.
//

import Foundation
protocol BookDetailsProtocol: AnyObject {
    func updateItemQuantity()
}

class BookDetailsPresenter {
    weak private var viewDelegate: BookDetailsProtocol?
    var book: BookModel?
    
    init(viewDelegate: BookDetailsProtocol) {
        self.viewDelegate = viewDelegate
    }
    
    func updateBookCartData() {
        book?.cartQuantity = getBookCartQuantityIfAvailable()
    }
    
    func addItemQuantity() {
        let updatedQuantiry = (book?.cartQuantity ?? 0) + 1
        if updatedQuantiry <= book?.quantity ?? 0 {
            book?.cartQuantity = updatedQuantiry
        }
        self.viewDelegate?.updateItemQuantity()
    }
    
    func removeItemQuantity() {
        let updatedQuantiry = (book?.cartQuantity ?? 0) - 1
        if updatedQuantiry >= 0 {
            book?.cartQuantity = updatedQuantiry
        }
        self.viewDelegate?.updateItemQuantity()
    }
    
    func getBookCartQuantityIfAvailable() -> Int {
        let books = LibraryManager.shared.getCartData() ?? []
        if let cartData = books.filter({$0.bookId == book?.bookId}).first {
            return cartData.cartQuantity ?? 0
        }
        
        return book?.cartQuantity ?? 0
    }
    
    func addDataToCart() {
        var books = LibraryManager.shared.getCartData() ?? []
        if let index = books.firstIndex(where: { $0.bookId == book?.bookId }) {
            if books.count > index, let updateData = book {
                books[index] = updateData
            }
        } else {
            if let updateData = book {
                books.append(updateData)
            }
        }
        
        LibraryManager.shared.saveCartData(booksData: books)
        self.viewDelegate?.updateItemQuantity()
    }
    
}
