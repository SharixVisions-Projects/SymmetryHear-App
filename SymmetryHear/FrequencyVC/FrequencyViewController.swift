//
//  FrequencyViewController.swift
//  SymmetryHear
//
//  Created by UCF on 04/09/2024.
//

import UIKit
import MTCircularSlider
class FrequencyViewController: UIViewController {

    @IBOutlet weak var frequencyLabel: UILabel!
    @IBOutlet weak var frequencySlider: MTCircularSlider!
    @IBOutlet weak var playbtnn: UIButton!
    @IBOutlet weak var stopbtn: UIButton!
    @IBOutlet weak var savebtn: UIButton!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var nametf: UITextField!
    @IBOutlet weak var lowfrettf: UITextField!
    @IBOutlet weak var highFreqTF: UITextField!
    @IBOutlet weak var DateTf: UITextField!
    @IBOutlet weak var historyBtn: UIButton!
   
    @IBOutlet weak var FreqView: UIView!
    @IBOutlet weak var CreateProfilbtn: UIButton!
    
    
    var selectedsound = String()
    var isFromHomeName = String()
    var titlestr = String()
    
    var FrequecyItems = [[String: String]]()
    
    var soundGenerator: SoundGenerator!
        var currentFrequency: Double = 1000.0 // Start with a frequency of 1000 Hz
        var highestFrequency: Double = 0.0
        var lowestFrequency: Double = 1000.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        roundCorner(button: playbtnn)
        roundCorner(button: stopbtn)
        roundCorneView(view: FreqView)
        detailView.isHidden = true
        soundGenerator = SoundGenerator()
        
      
        
        frequencySlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        frequencyLabel.text = String(format: "Frequency: %.2f Hz", currentFrequency)
        // Set slider range for human hearing frequencies (20 Hz to 20,000 Hz)
//        frequencySlider.minimumValue = 20
       // frequencySlider.maximumValue = 20000
        //frequencySlider.value = Float(currentFrequency)
        detailView.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            tapGesture.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    func loadHearingRange()
    {
        let defaults = UserDefaults.standard
        if let history = defaults.array(forKey: "hearingHistory") as? [[String: String]] {
            FrequecyItems = history
        } else {
            FrequecyItems = []
        }
        //updateEmptyViewVisibility()
    }
    //func updateEmptyViewVisibility() {
       //Nodatalbl?.isHidden = !FrequecyItems.isEmpty
       // Tv?.isHidden = FrequecyItems.isEmpty
    //}
    @objc func hideKeyboard()
    {
        view.endEditing(true)
    }
    
    @IBAction func startTest(_ sender: UIButton) {
        soundGenerator.playFrequency(frequency: currentFrequency)
    }
    
    @IBAction func stopTest(_ sender: UIButton) {
        soundGenerator.stop()
    }
    
    @IBAction func savebtnPressed(_ sender: UIButton) {
        detailView.isHidden = false
        highFreqTF.text = String(format: "%.2f Hz", highestFrequency)
        lowfrettf.text = String(format: "%.2f Hz", lowestFrequency)
        DateTf.text = getCurrentDate()
    }
    
    func getCurrentDate() -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
    
    
    @IBAction func viewCLosebtn(_ sender: UIButton) {
        detailView.isHidden = true
    }
    @IBAction func historyBtn(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func BackBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func settingsbtn(_ sender: UIButton) {
      //  let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
       // let newViewController = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
       // newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
       // newViewController.modalTransitionStyle = .crossDissolve
       // self.present(newViewController, animated: true, completion: nil)
    }
    
  
    
    @objc func sliderValueChanged(_ sender: MTCircularSlider)
    {
        currentFrequency = Double(sender.value)
        frequencyLabel.text = String(format: "Frequency: %.2f Hz", currentFrequency)
        
        // Update the frequency being played as the slider is adjusted
        if soundGenerator.audioPlayerNode.isPlaying {
            soundGenerator.playFrequency(frequency: currentFrequency)
        }
        
        if currentFrequency > highestFrequency
        {
              highestFrequency = currentFrequency
        }
          
        if currentFrequency < lowestFrequency
        {
              lowestFrequency = currentFrequency
        }
    }
    
    @IBAction func CreateProfil(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let createProfileVC = storyboard.instantiateViewController(withIdentifier: "CreateProfileViewController") as? CreateProfileViewController {
               // Pass the frequency value to CreateProfileViewController
               createProfileVC.highFrequencyValue = frequencyLabel.text ?? "0.0 Hz"
               
               createProfileVC.modalPresentationStyle = .fullScreen
               createProfileVC.modalTransitionStyle = .crossDissolve
               self.present(createProfileVC, animated: true, completion: nil)
           }
    }
}


//UIView
extension FrequencyViewController
{
    
    @IBAction func detailssavebtnPressed(_ sender: UIButton) {
        
        guard let name = nametf.text, !name.isEmpty,
              let lowFreq = lowfrettf.text, !lowFreq.isEmpty,
              let highFreq = highFreqTF.text, !highFreq.isEmpty,
              let date = DateTf.text, !date.isEmpty else {
            // Show alert if any text field is empty
            showAlert(title: "Alert!", message: "All fields are required.")
            return
        }
        // Save data to UserDefaults
        saveHearingRange(name: name, lowFreq: lowFreq, highFreq: highFreq, date: date)
    }
    
    func saveHearingRange(name: String, lowFreq: String, highFreq: String, date: String) {
         let defaults = UserDefaults.standard
         var history = defaults.array(forKey: "hearingHistory") as? [[String: String]] ?? []
         
         let newEntry = [
             "name": name,
             "lowFreq": lowFreq,
             "highFreq": highFreq,
             "date": date
         ]
         //
         history.append(newEntry)
         defaults.set(history, forKey: "hearingHistory")
        
        let alert = UIAlertController(title: "Saved!", message: "Record has been updated successfully.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            self.detailView.isHidden = true
            self.clearTextFields()
        }))
        present(alert, animated: true, completion: nil)

         
     }
    
    func clearTextFields() {
        nametf.text = ""
        lowfrettf.text = ""
        highFreqTF.text = ""
        DateTf.text = ""
    }
    

}
