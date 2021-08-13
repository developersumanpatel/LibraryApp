//
//  LibraryPresenter.swift
//  LibraryApp
//
//  Created by Suman on 13/08/21.
//

import Foundation
protocol LibraryProtocol: AnyObject {
    func finishGettingBookDataWithSuccess()
    func finishGettingBookDataWithFail(_ message: String)
}

class LibraryPresenter {
    weak private var viewDelegate: LibraryProtocol?
    var libraries: [LibraryModel]?
    
    init(viewDelegate: LibraryProtocol) {
        self.viewDelegate = viewDelegate
    }
    
    func getBooksData() {
        LibraryManager.shared.getAllBooks { (success, result) in
            if success {
                self.libraries = (result as? LibrariesModel)?.libraries
                self.viewDelegate?.finishGettingBookDataWithSuccess()
            } else {
                self.viewDelegate?.finishGettingBookDataWithFail((result as? String) ?? "Something went wrong")
            }
        }
    }
    
    func updateLibraryModel() {
        let cartData = LibraryManager.shared.getCartData()
        for library in self.libraries ?? [] {
            for book in library.books ?? [] {
                if let index = cartData?.firstIndex(where: { $0.bookId == book.bookId }) {
                    if cartData?.count ?? 0 > index {
                        book.cartQuantity = cartData?[index].cartQuantity
                    }
                } else {
                    book.cartQuantity = 0
                }
            }
        }
    }
}
