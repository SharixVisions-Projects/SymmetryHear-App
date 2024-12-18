//
//  HearingProfilesViewController.swift
//  SymmetryHear
//
//  Created by UCF on 11/09/2024.
//

import UIKit

class HearingProfilesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var TableV: UITableView!
    @IBOutlet weak var Nodatalbl: UILabel!
    
    var profile: [Profiles] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableV.delegate = self
        TableV.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let savedData = UserDefaults.standard.array(forKey: "profile") as? [Data] {
            let decoder = JSONDecoder()
            profile = savedData.compactMap { data in
                do {
                    let profile = try decoder.decode(Profiles.self, from: data)
                    return profile
                } catch {
                    print("Error decoding medication: \(error.localizedDescription)")
                    return nil
                }
            }
        }
        TableV.reloadData()
    }
    
    @IBAction func Backbtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func Createprf(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let createProfileVC = storyboard.instantiateViewController(withIdentifier: "CreateProfileViewController") as? CreateProfileViewController {
            // Pass the frequency value to CreateProfileViewController
            
            createProfileVC.modalPresentationStyle = .fullScreen
            createProfileVC.modalTransitionStyle = .crossDissolve
            self.present(createProfileVC, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HearingProfilesTableViewCell
        let userprofile = profile[indexPath.row]
        
        cell.Namelbl.text = userprofile.name
       // cell.Genderlbl.text = profile.Gender
        //cell.Occupationlbl.text = profile.Occupation
        //cell.Enviornmentlbl.text = profile.Enviornment
        //cell.LowFreqlbl.text = profile.Lowfreq
       //cell.HighFreqlbl.text = profile.HighFreq
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        cell.DateOfBirthlbl.text = dateFormatter.string(from: userprofile.DOB)
        
        // Set the share button action
//        cell.shareButtonAction = { [weak self] in
//            self?.shareProfileData(at: indexPath)
        
        
        return cell
    }
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail =  profile [indexPath.row]
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DetailProfileViewController") as! DetailProfileViewController
        newViewController.userdetail = detail
        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
    }

//    self.present(newViewController, animated: true, completion: nil)
//    private func shareProfileData(at indexPath: IndexPath) {
//        let profile = profile [indexPath.row]
//        let pdfData = createPDF(from: profile)
//        
//        let activityViewController = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
//        present(activityViewController, animated: true, completion: nil)
//    }
//    
//    private func createPDF(from profile: Profiles) -> Data {
//        let pdfMetaData = [
//            kCGPDFContextTitle as String: "Hearing Profile",
//            kCGPDFContextCreator as String: "SymmetryHear"
//        ]
//        let format = UIGraphicsPDFRendererFormat()
//        format.documentInfo = pdfMetaData
//        
//        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 600, height: 800), format: format)
//        
//        let data = renderer.pdfData { (context) in
//            context.beginPage()
//            
//            let text = """
//            Name: \(profile.name)
//            Date of Birth: \(profile.DOB)
//            Gender: \(profile.Gender)
//            Occupation: \(profile.Occupation)
//            Environment: \(profile.Enviornment)
//            Low Frequency: \(profile.Lowfreq)
//            High Frequency: \(profile.HighFreq)
//            """
//            
//            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
//            let attributedText = NSAttributedString(string: text, attributes: attributes)
//            attributedText.draw(in: CGRect(x: 20, y: 20, width: 560, height: 760))
//        }
//        
//        return data
//    }
}
