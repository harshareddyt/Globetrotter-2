//
//  ProfileTableViewCell.swift
//  Globe Trotter
//
//  Created by Sunny Reddy on 16/04/19.
//  Copyright © 2019 Harsha Reddy. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    var click : Bool!
    var button : UIButton!


    @IBOutlet weak var nooflikeslabel: UILabel!
    @IBOutlet var noofcommentslabel: UILabel!
    @IBOutlet weak var ProfilecellView: UIView!
    @IBOutlet weak var ProfilecellImg: UIImageView!
    @IBOutlet weak var ProfilecellNameLabel: UILabel!
    @IBOutlet weak var ProfilecellmainImg: UIImageView!
    @IBOutlet weak var ProfilecellcmtsImg: UIImageView!
    @IBOutlet weak var ProfilecellTextView: UITextView!
    @IBOutlet var ProfilecelllikeImg: UIImageView!
    @IBAction func ProfilecellcmtsButton(_ sender: UIButton) {


    }
    @IBAction func ProfilecelllikeButton(_ sender: UIButton) {

        if click == false{
            ProfilecelllikeImg.image = UIImage(named: "heart.png")
            click = true
        }
        else{
            ProfilecelllikeImg.image = UIImage(named: "cheart.png")
            click = false
        }
    }
    
    @IBOutlet var ProfilecellreviewTitleLabel: UILabel!
    @IBOutlet var nooflikesButton: UILabel!
    @IBOutlet weak var ProfilecellDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ProfilecellView.layer.shadowRadius = 20
        ProfilecellView.layer.shadowOpacity = 0.5
        
        
        ProfilecellTextView.isUserInteractionEnabled = false
        ProfilecellTextView.isSelectable = false
        ProfilecellTextView.isEditable = false
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
