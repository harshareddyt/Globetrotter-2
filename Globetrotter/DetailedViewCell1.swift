//
//  DetailedViewCell1.swift
//  Globe Trotter
//
//  Created by Sunny Reddy on 16/04/19.
//  Copyright © 2019 Harsha Reddy. All rights reserved.
//

import UIKit

class DetailedViewCell1: UITableViewCell {

    @IBOutlet weak var commentsTextView: UITextView!
    
    @IBOutlet weak var PlaceImage_Imageview: UIImageView!
    
    @IBOutlet weak var postedDate_Lbl: UILabel!
    @IBOutlet weak var mailId_Lbl: UILabel!
    var commentTexts = ""
        override func awakeFromNib() {
        super.awakeFromNib()
        commentsTextView.text = commentTexts
            PlaceImage_Imageview.layer.cornerRadius = 10
            PlaceImage_Imageview.layer.masksToBounds = true
            
            
            self.PlaceImage_Imageview.layer.cornerRadius = self.PlaceImage_Imageview.frame.size.width/30
            self.PlaceImage_Imageview.clipsToBounds = true
            
            let profile = UserDefaults.standard.url(forKey: "image")
            let image2 = URL(string:(profile!.absoluteString))
            
            if let image1 = image2{
                PlaceImage_Imageview.layer.cornerRadius = PlaceImage_Imageview.frame.size.height / 2
                PlaceImage_Imageview.clipsToBounds = true
                PlaceImage_Imageview.sd_setImage( with: image1 as URL)
                PlaceImage_Imageview.contentMode = .scaleAspectFit
            }
            
            
            
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
