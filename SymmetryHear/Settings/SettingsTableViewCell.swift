//
//  SettingsTableViewCell.swift
//  SymmetryHear
//
//  Created by UCF on 09/09/2024.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var Namelbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        img.layer.cornerRadius = img.frame.size.height/2
        img.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
