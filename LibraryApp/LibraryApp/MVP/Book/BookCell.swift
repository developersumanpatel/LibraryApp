//
//  BookCell.swift
//  LibraryApp
//
//  Created by Suman on 13/08/21.
//

import UIKit

class BookCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(_ data: BookModel?) {
        titleLabel.text = data?.title ?? ""
        descriptionLabel.text = data?.description ?? ""
        if let imageNames = data?.imageUrls, imageNames.count > 0, let image = UIImage(named: imageNames[0]) {
            bookImageView?.image = image
        } else if let imageUrls = data?.imageUrls, imageUrls.count > 0, let image = URL(string: imageUrls[0]) {
            bookImageView?.setImageFrom(from: image)
        }
    }
}
