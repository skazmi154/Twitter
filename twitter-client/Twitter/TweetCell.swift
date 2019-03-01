//
//  TweetCell.swift
//  Twitter
//
//  Created by Syed Kazmi on 2/24/19.
//  Copyright © 2019 Syed Kazmi. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    
    @IBOutlet weak var userDp: UIImageView!
    
    
    @IBOutlet weak var tweet: UILabel!
    
    
    @IBOutlet weak var username: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
