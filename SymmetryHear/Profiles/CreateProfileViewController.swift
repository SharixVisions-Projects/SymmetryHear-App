//
//  CreateProfileViewController.swift
//  SymmetryHear
//
//  Created by UCF on 10/09/2024.
//

import UIKit

class CreateProfileViewController: UIViewController {

    @IBOutlet weak var Namelbl: UILabel!
    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var DateOfBirthlbl: UILabel!
   
    @IBOutlet weak var DateOfBirth: UIDatePicker!
    @IBOutlet weak var Genderlbl: UILabel!
    @IBOutlet weak var GenderDropDown: DropDown!
    @IBOutlet weak var Occupationlbl: UILabel!
    @IBOutlet weak var OccupationTF: UITextField!
    @IBOutlet weak var Enviornmentlbl: UILabel!
    @IBOutlet weak var EnviornmentDropDown: DropDown!
    @IBOutlet weak var LowFreqlbl: UILabel!
    @IBOutlet weak var LowFreqTF: UITextField!
    @IBOutlet weak var HighFreqlbl: UILabel!
    @IBOutlet weak var HighFreqTF: UITextField!
    @IBOutlet weak var Savebtn: UIButton!
    
    var highFrequencyValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
           
        LowFreqTF.text = "1000.00 Hz"
        // Set the passed high frequency value to the HighFreqTF text field
           HighFreqTF.text = highFrequencyValue
        
        self.GenderDropDown.placeholder = "Select Gender"
        GenderDropDown.optionArray = ["Male", "Female"]
        GenderDropDown.didSelect { (selectedText, index, id) in
            self.GenderDropDown.text = selectedText
        }
        
        self.EnviornmentDropDown.placeholder = "Select Enviornment"
        EnviornmentDropDown.optionArray = ["Noisy Enviornment", "Normal Enviornment","Quiet Room","Office Environment","Home Environment","Factory Floor","Hospital or Clinic","Train Station Platform"]
        EnviornmentDropDown.didSelect { (selectedText, index, id) in
            self.EnviornmentDropDown.text = selectedText
        }
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        showAlert(title: "Alert", message: "Create multiple profiles to track your lowest and highest frequency data, along with related records. You can set up profiles for yourself or family members to easily manage and access frequency history for each person.")
    }
    
    func SaveUserData(_ sender: Any) {
        guard let Name = NameTF.text, !Name.isEmpty,
              let Occupation = OccupationTF.text, !Occupation.isEmpty,
              let Enviornment = EnviornmentDropDown.text, !Enviornment.isEmpty,
              let LowFreq = LowFreqTF.text, !LowFreq.isEmpty,
              let Gender = GenderDropDown.text, !Gender.isEmpty,
              let HighFreq = HighFreqTF.text, !HighFreq.isEmpty else {
            showAlert(title: "Alert", message: "Please fill in all fields")
            return
        }
        
        // Get the Date from the UIDatePicker
        let date = DateOfBirth.date
        
        // Now create the UserData with the Date
        let UserData = Profiles(
            name: Name,
            DOB: date, // Use the Date from UIDatePicker
            Gender: Gender,
            Occupation: Occupation,
            Enviornment: Enviornment,
            Lowfreq: LowFreq,
            HighFreq: HighFreq
        )
        
        saveMedication(UserData)
    }

    
    func saveMedication(_ medication: Profiles) {
        var medications = UserDefaults.standard.object(forKey: "profile") as? [Data] ?? []
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(medication)
            medications.append(data)
            UserDefaults.standard.set(medications, forKey: "profile")
        
        } catch {
            print("Error encoding medication: \(error.localizedDescription)")
        }
        showAlert(title: "Done", message: "Profile Create successfully.")
    }

    @IBAction func SaveData(_ sender: UIButton) {
        SaveUserData(sender)
    }
    
    @IBAction func Backbtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
