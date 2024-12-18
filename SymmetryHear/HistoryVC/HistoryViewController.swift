//
//  HistoryViewController.swift
//  SymmetryHear
//
//  Created by UCF on 04/09/2024.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    

    @IBOutlet weak var Nodatalbl: UILabel!
    @IBOutlet weak var Tv: UITableView!
    
    var FrequecyItems = [[String: String]]()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        loadHearingRange()
        Tv.reloadData()
    }
    
    func loadHearingRange()
    {
        let defaults = UserDefaults.standard
        if let history = defaults.array(forKey: "hearingHistory") as? [[String: String]] {
            FrequecyItems = history
        } else {
            FrequecyItems = []
        }
        updateEmptyViewVisibility()
    }
    
    func updateEmptyViewVisibility() {
        Nodatalbl?.isHidden = !FrequecyItems.isEmpty
        Tv?.isHidden = FrequecyItems.isEmpty
    }
    private func shareProfileData(at indexPath: IndexPath) {
        let profile = FrequecyItems [indexPath.row]
        let pdfData = createPDF(from: profile)

        let activityViewController = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }

    private func createPDF(from profile: [String: String]) -> Data {
        let pdfMetaData = [
            kCGPDFContextTitle as String: "Hearing Profile",
            kCGPDFContextCreator as String: "SymmetryHear"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData

        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 600, height: 800), format: format)

        let data = renderer.pdfData { (context) in
            context.beginPage()

            let text = """
            Name: \(profile["name"] ?? "N/A")
            Date: \(profile["date"] ?? "N/A")
            Low Frequency: \(profile["lowFreq"] ?? "N/A")
            High Frequency: \(profile["highFreq"] ?? "N/A")
            """

            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
            let attributedText = NSAttributedString(string: text, attributes: attributes)
            attributedText.draw(in: CGRect(x: 20, y: 20, width: 560, height: 760))
        }

        return data
    }

    
    @IBAction func removeAllPressed(_ sender:UIButton)
    {
        UserDefaults.standard.removeObject(forKey: "hearingHistory")
        FrequecyItems.removeAll()
        updateEmptyViewVisibility()
        Tv?.reloadData()
    }
    
    @IBAction func closebtnPressed(_ sender:UIButton)
    {
        self.dismiss(animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FrequecyItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryTableViewCell
        let item = FrequecyItems[indexPath.row]
               
       cell.nameLb.text = item["name"]
       cell.lowFreq.text = "Low Frequency: \(item["lowFreq"] ?? "N/A")"
       cell.HighFreq.text = "High Frequency: \(item["highFreq"] ?? "N/A")"
       cell.DateLb.text = item["date"]
        
        
         
        cell.shareButtonAction = { [weak self] in
            self?.shareProfileData(at: indexPath)
        }
       return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == .delete {
              // Remove the item from the data source
              FrequecyItems.remove(at: indexPath.row)
              
              // Save the updated array to UserDefaults
              let defaults = UserDefaults.standard
              defaults.set(FrequecyItems, forKey: "hearingHistory")
              
              // Delete the row from the table view
              tableView.deleteRows(at: [indexPath], with: .fade)
              
              // Update empty view visibility
              updateEmptyViewVisibility()
          }
      }
    
}
