//
//  ChatTableViewCell.swift
//  DemoChatApp
//
//  Created by Ajay Thakur on 08/03/22.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    
    @IBOutlet weak var chatCellView: UIView!
    
    @IBOutlet weak var chatMessageLabel: UILabel!
    
    @IBOutlet weak var boyImage: UIImageView!
    
    @IBOutlet weak var girlImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        chatCellView.layer.cornerRadius = chatCellView.frame.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
