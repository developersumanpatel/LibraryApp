//
//  BookDetailsViewController.swift
//  LibraryApp
//
//  Created by Suman on 13/08/21.
//

import UIKit

class BookDetailsViewController: UIViewController {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var unitSoldLabel: UILabel!
    @IBOutlet weak var currentViewersLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var cartQuantityLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var presenter = BookDetailsPresenter(viewDelegate: self)
    var isFromCart: Bool = false
    var isAvailableOnline: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = presenter.book?.title ?? ""
        presenter.updateBookCartData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData()
    }
    
    private func setupData() {
        self.collectionView.reloadData()
        let attributes: [NSAttributedString.Key : Any]  = [ .font: UIFont.systemFont(ofSize: 16.0), .foregroundColor: UIColor.darkGray]
         
        let descriptionOriginalText = "Description: \(presenter.book?.description ?? "")"
        let descriptionAttributedText = NSMutableAttributedString(string: descriptionOriginalText, attributes: attributes)
        descriptionAttributedText.addBold(forString: descriptionOriginalText, withTerm: "Description:", color: UIColor.black, font: UIFont.boldSystemFont(ofSize: 18.0))
        self.descriptionLabel.attributedText = descriptionAttributedText
        
        let priceOriginalText = "Price: \(presenter.book?.price ?? 0.0)"
        let priceAttributedText = NSMutableAttributedString(string: priceOriginalText, attributes: attributes)
        priceAttributedText.addBold(forString: priceOriginalText, withTerm: "Price:", color: UIColor.black, font: UIFont.boldSystemFont(ofSize: 18.0))
        self.priceLabel.attributedText = priceAttributedText
        
        var quantityOriginalText = "Quantity: \(presenter.book?.quantity ?? 0)"
        
        if presenter.getBookCartQuantityIfAvailable() > 0 {
            quantityOriginalText = "\(quantityOriginalText) - \(presenter.getBookCartQuantityIfAvailable()) available in your cart."
        }
        
        let quantityAttributedText = NSMutableAttributedString(string: quantityOriginalText, attributes: attributes)
        quantityAttributedText.addBold(forString: quantityOriginalText, withTerm: "Quantity:", color: UIColor.black, font: UIFont.boldSystemFont(ofSize: 18.0))
        self.quantityLabel.attributedText = quantityAttributedText
        
        let unitSoldOriginalText = "Unit Sold: \(presenter.book?.unitSold ?? 0)"
        let unitSoldAttributedText = NSMutableAttributedString(string: unitSoldOriginalText, attributes: attributes)
        unitSoldAttributedText.addBold(forString: unitSoldOriginalText, withTerm: "Unit Sold:", color: UIColor.black, font: UIFont.boldSystemFont(ofSize: 18.0))
        self.unitSoldLabel.attributedText = unitSoldAttributedText
        
        let currentViewersOriginalText = "Current Viewers: \(presenter.book?.currentViewers ?? 0)"
        let currentViewersAttributedText = NSMutableAttributedString(string: currentViewersOriginalText, attributes: attributes)
        currentViewersAttributedText.addBold(forString: currentViewersOriginalText, withTerm: "Current Viewers:", color: UIColor.black, font: UIFont.boldSystemFont(ofSize: 18.0))
        self.currentViewersLabel.attributedText = currentViewersAttributedText
        
        let ratingsOriginalText = "Rating: \(Int(presenter.book?.rating ?? 0))/5"
        let ratingsAttributedText = NSMutableAttributedString(string: ratingsOriginalText, attributes: attributes)
        ratingsAttributedText.addBold(forString: ratingsOriginalText, withTerm: "Rating:", color: UIColor.black, font: UIFont.boldSystemFont(ofSize: 18.0))
        self.ratingLabel.attributedText = ratingsAttributedText
        
        if (presenter.book?.cartQuantity ?? 0) > 0 {
            addToCartButton.setTitle("Update Cart", for: .normal)
        } else {
            addToCartButton.setTitle("Add To Cart", for: .normal)
        }
        
        if isAvailableOnline && ((presenter.book?.quantity ?? 0) > 0) {
            self.cartView.isHidden = false
        } else {
            self.cartView.isHidden = true
        }
        updateCartData()
        collectionView.reloadData()
    }
    
    private func updateCartData() {
        self.cartQuantityLabel.text = "\(presenter.book?.cartQuantity ?? 0)"
        if isAvailableOnline && ((presenter.book?.cartQuantity ?? 0) > 0) {
            self.addToCartButton.isHidden = false
        } else {
            self.addToCartButton.isHidden = true
        }
    }
    
    @IBAction func minusQuantityClicked(_ sender: Any) {
        presenter.removeItemQuantity()
    }
    
    @IBAction func plusQuantityClicked(_ sender: Any) {
        presenter.addItemQuantity()
    }
    
    @IBAction func addToCartClicked(_ sender: Any) {
        presenter.addDataToCart()
        if isFromCart {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}

extension BookDetailsViewController: BookDetailsProtocol {
    func updateItemQuantity() {
        updateCartData()
    }
}

extension BookDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.book?.imageUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookImageCell", for: indexPath) as? BookImageCell {
            cell.configureCell(url: presenter.book?.imageUrls?[indexPath.row] ?? "")
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 150)
    }
}
