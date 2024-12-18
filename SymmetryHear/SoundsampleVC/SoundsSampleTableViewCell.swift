//
//  SoundsSampleTableViewCell.swift
//  SymmetryHear
//
//  Created by UCF on 09/09/2024.
//

import UIKit

class SoundsSampleTableViewCell: UITableViewCell {

    
    @IBOutlet weak var SelectedIconimg: UIImageView!
    @IBOutlet weak var Soundlbl: UILabel!
    @IBOutlet weak var SoundPlayandStopbtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
