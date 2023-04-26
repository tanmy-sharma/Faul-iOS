//
//  MessageCell.swift
//  Faul-iOS
//
//  Created by VarunMalhotra on 20/03/23.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet var message: UILabel!
    @IBOutlet var messageView: UIView!
    @IBOutlet var leftImageView: UIImageView!
    @IBOutlet var rightImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageView.layer.cornerRadius = messageView.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
