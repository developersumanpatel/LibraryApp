//
//  LibraryCell.swift
//  LibraryApp
//
//  Created by Suman on 13/08/21.
//

import UIKit

class LibraryCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var storeTypeLabel: UILabel!
    @IBOutlet weak var libraryImageView: UIImageView!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var storeTypeView: UIView!
    
    var locationButtonClikcedCompletion: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(_ data: LibraryModel?) {
        nameLabel.text = data?.name ?? ""
        addressLabel.text = "\(data?.address ?? "") - \(data?.country ?? "")\nPhone Number: \(data?.phoneNumber ?? "")"
        storeTypeLabel.text = "\(getOperationHours(operatingTime: data?.operatingTime))"
        
        if data?.type == .online {
            storeTypeView.backgroundColor = UIColor.green
        } else {
            storeTypeView.backgroundColor = UIColor.red
        }
        
        if let imageName = data?.logoUrl, let image = UIImage(named: imageName) {
            libraryImageView?.image = image
        }
        if let lat = data?.gps?.lat, let long = data?.gps?.long, lat != 0.0, long != 0.0 {
            locationView.isHidden = false
        } else {
            locationView.isHidden = true
        }
    }
    
    private func getOperationHours(operatingTime: OperatingTimeModel?) -> String {
        let dayOfWeek = Date().dayOfWeek()?.lowercased()
        var timeModel: [TimeModel]?
        
        switch dayOfWeek {
        case WeekDayType.sun.rawValue:
            timeModel = operatingTime?.sun
        case WeekDayType.mon.rawValue:
            timeModel = operatingTime?.mon
        case WeekDayType.tue.rawValue:
            timeModel = operatingTime?.tue
        case WeekDayType.wed.rawValue:
            timeModel = operatingTime?.wed
        case WeekDayType.thu.rawValue:
            timeModel = operatingTime?.thu
        case WeekDayType.fri.rawValue:
            timeModel = operatingTime?.fri
        case WeekDayType.sat.rawValue:
            timeModel = operatingTime?.sat
        default:
            break
        }
        
        var openingHours = ""
        for time in timeModel ?? [] {
            if openingHours.isEmpty {
                openingHours = "\(time.from ?? "")-\(time.to ?? "")"
            } else {
                openingHours = "\(openingHours), \(time.from ?? "")-\(time.to ?? "")"
            }
        }
        
        if openingHours.isEmpty {
           openingHours = "Close"
        }
        return openingHours
    }
    
    @IBAction func locationClicked(_ sender: Any) {
        locationButtonClikcedCompletion?()
    }
}
