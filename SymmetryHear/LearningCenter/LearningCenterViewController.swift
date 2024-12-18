//
//  LearningCenterViewController.swift
//  SymmetryHear
//
//  Created by UCF on 11/09/2024.
//

import UIKit

class LearningCenterViewController: UIViewController {
    
    @IBOutlet weak var TableView: UITableView!
    var p_items : [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_items = items
        TableView.delegate = self
        TableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        TableView.rowHeight = UITableView.automaticDimension
        TableView.estimatedRowHeight = 44.0
    }
    
    @IBAction func RefLinkbtn(_ sender: Any) {
        if let url = URL(string: "https://www.nidcd.nih.gov/") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    @IBAction func Backbtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
extension LearningCenterViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "precautionCell", for: indexPath) as! LearningCenterTableViewCell
        
        let item = items[indexPath.row]
        cell.p_Label?.text = item.title
        cell.detailsLabel?.text = item.isExpanded ? item.details : nil
      //  cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return items[indexPath.row].isExpanded ? 500 : 65 // Adjust heights as needed
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            items[indexPath.row].isExpanded.toggle() // Toggle the expanded state
        TableView.reloadRows(at: [indexPath], with: .automatic) // Reload the tapped row
        }
    
    
}
