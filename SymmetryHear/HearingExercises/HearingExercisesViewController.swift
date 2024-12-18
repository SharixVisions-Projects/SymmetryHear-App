//
//  HearingExercisesViewController.swift
//  SymmetryHear
//
//  Created by UCF on 09/09/2024.
//

import UIKit

class HearingExercisesViewController: UIViewController {

    
    @IBOutlet weak var FeedbackTV: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        FeedbackTV.layer.borderWidth = 1.0
        FeedbackTV.layer.borderColor = UIColor.white.cgColor
        FeedbackTV.layer.cornerRadius = 10.0
        FeedbackTV.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    

    @IBAction func backbtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func RefLinkbtn(_ sender: Any) {
        if let url = URL(string: "https://www.nidcd.nih.gov/") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }

    
}
