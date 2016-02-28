
//
//  ImageFeedTableViewCell.swift
//  Image-Search
//
//  Created by Amog Kamsetty on 2/27/16.
//  Copyright (c) 2016 Amog Kamsetty. All rights reserved.
//

import UIKit

class ImageFeedTableViewCell: UITableViewCell {

    @IBOutlet var mediaImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
