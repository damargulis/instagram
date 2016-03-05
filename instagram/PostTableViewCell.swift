//
//  PostTableViewCell.swift
//  instagram
//
//  Created by Daniel Margulis on 3/5/16.
//  Copyright © 2016 Daniel Margulis. All rights reserved.
//

import UIKit
import ParseUI

class PostTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var postImageView: PFImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
