//
//  HistoryTableViewCell.swift
//  SymmetryHear
//
//  Created by UCF on 04/09/2024.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var lowFreq: UILabel!
    @IBOutlet weak var HighFreq: UILabel!
    @IBOutlet weak var DateLb: UILabel!
    @IBOutlet weak var ShareButton: UIButton!
    
    var shareButtonAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ShareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        
    }

    
   @objc func shareButtonTapped() {
       shareButtonAction?()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

   // @IBAction func ShareButton(_ sender: UIButton) {
    //}
    
}
