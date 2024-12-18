//
//  FeedbackViewController.swift
//  EarSpectrum
//
//  Created by Unique Consulting Firm on 22/05/2024.
//

import UIKit

class FeedbackViewController: UIViewController {

    @IBOutlet weak var textView:UITextView!
    @IBOutlet weak var donebtn:UIButton!
    @IBOutlet weak var backbtn: UIButton!
    
    var isButtonClicked = false
        var isFeedbackGiven = false
    var AllButtons: [UIButton] = []
    var tapRating: Int = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backbtn.setTitle("", for: .normal)
        roundCorner(button: donebtn)
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1
        textView.clipsToBounds = true
        setupfeedback()
        // Do any additional setup after loading the view.
    }
    
    func setupfeedback() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            tapGesture.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGesture)
        
        let buttonWidth: CGFloat = 50
        let spacing: CGFloat = 10
        
        
        for i in 0..<5 {
            let strBtn = UIButton(type: .custom)
            strBtn.frame = CGRect(x: 20 + CGFloat(i) * (buttonWidth + spacing), y: textView.frame.maxY + 50 , width: 100, height: 100)
            strBtn.setImage(UIImage(systemName: "star"), for: .normal)
            strBtn.setImage(UIImage(systemName: "star.fill"), for: .selected)
            strBtn.tag = i + 1
            strBtn.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
            strBtn.tintColor = UIColor.systemYellow
            AllButtons.append(strBtn)
            view.addSubview(strBtn)
        }
    }
    
    @objc func hideKeyboard()
    {
        view.endEditing(true)
    }
    @objc func starButtonTapped(_ sender: UIButton) {
        tapRating = sender.tag
        
        for button in AllButtons {
            button.isSelected = button.tag <= tapRating
        }
    }
    
    @IBAction func donebtnPressed(_ sender:UIButton)
    {
        guard tapRating > 0, !textView.text.isEmpty else {
            
            let alert = UIAlertController(title: "Failed!", message: "Please feel free to provide your valuable feedback and rating. Your insights are highly valued and appreciated.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let confirmationAlert = UIAlertController(title: "Success", message: "Your feedback is highly valued and appreciated. Thank you for taking the time to share your thoughts with us.", preferredStyle: .alert)
        
        // Add an action with a completion handler to dismiss the UI
        let okAction = UIAlertAction(title: "OK", style: .default) { [self] _ in
            textView.text = ""
            tapRating = 0
            AllButtons.removeAll()
            DispatchQueue.main.async
            {
                self.dismiss(animated: true)
            }
        }
        confirmationAlert.addAction(okAction)
        
        present(confirmationAlert, animated: true, completion: nil)
    }
    
    @IBAction func backbtnPressed(_ sender:UIButton)
    {
        self.dismiss(animated: true)
    }

}
