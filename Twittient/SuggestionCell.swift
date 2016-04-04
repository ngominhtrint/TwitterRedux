//
//  SuggestionCell.swift
//  Twittient
//
//  Created by TriNgo on 4/4/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

class SuggestionCell: UITableViewCell {

    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        avatarImage.layer.cornerRadius = 3.0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
