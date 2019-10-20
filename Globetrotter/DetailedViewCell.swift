import UIKit
import Cosmos
class DetailedViewCell: UITableViewCell {
    
    
    @IBOutlet weak var PostedPersonImage: UIImageView!
    @IBOutlet weak var ratting: CosmosView!
    @IBOutlet weak var detailViewcellView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var reviewTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        ratting.isUserInteractionEnabled = false
        descriptionTextView.isEditable = false
        descriptionTextView.isUserInteractionEnabled = false
        descriptionTextView.isSelectable = false
        PostedPersonImage.layer.cornerRadius = 25
        PostedPersonImage.layer.masksToBounds = true
        
//        detailViewcellView.layer.cornerRadius = 50
//        detailViewcellView.layer.masksToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
