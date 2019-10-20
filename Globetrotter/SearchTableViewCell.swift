//
//  SearchTableViewCell.swift
//  Globe Trotter
//
//  Created by Sunny Reddy on 17/04/19.
//  Copyright © 2019 Harsha Reddy. All rights reserved.
//
import UIKit
import Cosmos
class SearchTableViewCell: UITableViewCell {

    @IBOutlet var searchcellImage: UIImageView!
    @IBOutlet var titleReview: UILabel!
    @IBOutlet var titleDescription: UITextView!
    @IBOutlet var cosmos: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cosmos.isUserInteractionEnabled = false
        titleDescription.isUserInteractionEnabled = false
        titleDescription.isSelectable = false
        titleReview.isUserInteractionEnabled = false
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
