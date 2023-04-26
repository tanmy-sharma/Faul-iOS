//
//  ReminderCollectionViewCell.swift
//  Faul-iOS
//
//  Created by VarunMalhotra on 26/03/23.
//

import UIKit

class ReminderCollectionViewCell: UICollectionViewCell {

    @IBOutlet var cView: UIView!
    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cView.layer.cornerRadius = cView.frame.size.height / 5
    }
    
}
