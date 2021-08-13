//
//  CartCell.swift
//  LibraryApp
//
//  Created by Suman on 13/08/21.
//

import UIKit

class CartCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(_ data: BookModel?) {
        titleLabel.text = data?.title ?? ""
        
        let attributes: [NSAttributedString.Key : Any]  = [ .font: UIFont.systemFont(ofSize: 16.0), .foregroundColor: UIColor.darkGray]
        let priceOriginalText = "Price: \(data?.price ?? 0.0)"
        let priceAttributedText = NSMutableAttributedString(string: priceOriginalText, attributes: attributes)
        priceAttributedText.addBold(forString: priceOriginalText, withTerm: "Price:", color: UIColor.black, font: UIFont.boldSystemFont(ofSize: 18.0))
        self.priceLabel.attributedText = priceAttributedText
        
        let quantityOriginalText = "Quantity: \(data?.cartQuantity ?? 0)"
        let quantityAttributedText = NSMutableAttributedString(string: quantityOriginalText, attributes: attributes)
        quantityAttributedText.addBold(forString: quantityOriginalText, withTerm: "Quantity:", color: UIColor.black, font: UIFont.boldSystemFont(ofSize: 18.0))
        self.quantityLabel.attributedText = quantityAttributedText
        
        
        if let imageNames = data?.imageUrls, imageNames.count > 0, let image = UIImage(named: imageNames[0]) {
            bookImageView?.image = image
        } else if let imageUrls = data?.imageUrls, imageUrls.count > 0, let image = URL(string: imageUrls[0]) {
            bookImageView?.setImageFrom(from: image)
        }
    }
}
