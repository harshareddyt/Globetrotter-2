//
//  HomeTableViewCell.swift
//  Globe Trotter
//
//  Created by Sunny Reddy on 16/04/19.
//  Copyright © 2019 Harsha Reddy. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    var click : Bool!
    var button : UIButton!
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var butImage: UIImageView!
    @IBOutlet weak var datesLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cellImg: UIImageView!
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var TextField1: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentImg: UIImageView!
    
    @IBOutlet weak var noofcomments: UILabel!
    //    @IBOutlet weak var nexttripLabel: UILabel!
    //    @IBOutlet weak var carImg: UIImageView!
    //    @IBOutlet weak var hearImg: UIImageView!
    //    @IBOutlet weak var TravellingLabel: UILabel!
    //    @IBOutlet weak var nooflikesButton: UIButton!
    @IBAction func likeButton(_ sender: UIButton) {
        if click == false{
            butImage.image = UIImage(named: "heart.png")
            click = true
        }
        else{
            butImage.image = UIImage(named: "cheart.png")
            click = false
//            postLiked()
        }
    }
    
    override func awakeFromNib() {
         super.awakeFromNib()
        // Initialization code
        textField.isUserInteractionEnabled = false
        textField.isSelectable = false
        TextField1.isUserInteractionEnabled = false
//        TextField1.isSelected = false
        textField.isEditable = false
        cellImg.layer.cornerRadius = 20
        cellImg.layer.masksToBounds = true
        cellImg.contentMode = .scaleAspectFit
//        cellView.layer.shadowRadius = 50
//        cellView.layer.shadowOpacity = 0.5
        profileImg.layer.cornerRadius = 20
        profileImg.layer.masksToBounds = true
        
//        self.profileImg.layer.cornerRadius = self.profileImg.frame.size.width/30
//        self.profileImg.clipsToBounds = true
//        
//        let profile = UserDefaults.standard.url(forKey: "image")
//        let image2 = URL(string:(profile!.absoluteString))
//        
//        if let image1 = image2{
//            profileImg.layer.cornerRadius = profileImg.frame.size.height / 2
//            profileImg.clipsToBounds = true
//            profileImg.sd_setImage( with: image1 as URL)
//            profileImg.contentMode = .scaleAspectFit
//        }

     }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
