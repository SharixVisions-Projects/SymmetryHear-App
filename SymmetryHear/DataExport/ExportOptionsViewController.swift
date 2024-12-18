//
//  ExportOptionsViewController.swift
//  SymmetryHear
//
//  Created by UCF on 12/09/2024.
//

import UIKit

class ExportOptionsViewController: UIViewController {

    
    @IBOutlet weak var exportlbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var Profilesbtn: UIButton!
    @IBOutlet weak var Historybtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        roundCorner(button: Profilesbtn)
        roundCorner(button: Historybtn)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Profilesbtn(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HearingProfilesViewController") as! HearingProfilesViewController
        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func Historybtn(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
        
    }
    @IBAction func Backbtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    

}
