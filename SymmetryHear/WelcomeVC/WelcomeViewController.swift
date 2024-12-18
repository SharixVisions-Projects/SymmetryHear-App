//
//  WelcomeViewController.swift
//  SymmetryHear
//
//  Created by UCF on 04/09/2024.
//

import UIKit

class WelcomeViewController: UIViewController {

    
    @IBOutlet weak var Startbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundCorner(button: Startbtn)
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func Startbtn(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
    }
    

}
