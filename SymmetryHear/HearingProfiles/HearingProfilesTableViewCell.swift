
import UIKit

class HearingProfilesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var Namelbl: UILabel!
    @IBOutlet weak var DateOfBirthlbl: UILabel!
    @IBOutlet weak var Genderlbl: UILabel!
    @IBOutlet weak var Occupationlbl: UILabel!
    @IBOutlet weak var Enviornmentlbl: UILabel!
    @IBOutlet weak var LowFreqlbl: UILabel!
    @IBOutlet weak var HighFreqlbl: UILabel!
    @IBOutlet weak var chevimg: UIImageView!
    
    
  //  var shareButtonAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       //ShareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
    }
    
//    @objc func shareButtonTapped() {
//        shareButtonAction?()
//    }
}
//    @IBAction func ShareButtonTap(_ sender: Any) {
//    }
