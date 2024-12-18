import UIKit

class DetailProfileViewController: UIViewController {

    @IBOutlet weak var Namelb: UILabel!
    @IBOutlet weak var NametextF: UITextField!
    
    @IBOutlet weak var DOBlb: UILabel!
    @IBOutlet weak var DOBDatePicker: UIDatePicker!
    @IBOutlet weak var Genderlb: UILabel!
    @IBOutlet weak var GenderTextF: UITextField!
    @IBOutlet weak var Occupationlb: UILabel!
    @IBOutlet weak var OccupationTextF: UITextField!
    @IBOutlet weak var Enviornmentlb: UILabel!
    @IBOutlet weak var EnviornmentTextF: UITextField!
    @IBOutlet weak var LowFreqlb: UILabel!
    @IBOutlet weak var LowFreqTextF: UITextField!
    @IBOutlet weak var HighFreqlb: UILabel!
    @IBOutlet weak var HighFreqTextF: UITextField!
    @IBOutlet weak var Sharebtn: UIButton!
    
    var userdetail: Profiles?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let UserDetail = userdetail {
            NametextF.text = UserDetail.name
            DOBDatePicker.date = UserDetail.DOB
            GenderTextF.text = UserDetail.Gender
            OccupationTextF.text = UserDetail.Occupation
            EnviornmentTextF.text = UserDetail.Enviornment
            LowFreqTextF.text = UserDetail.Lowfreq
            HighFreqTextF.text = UserDetail.HighFreq
        }
    }
    
    @IBAction func Backbtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    @IBAction func Sharebtn(_ sender: UIButton) {
        // Create the PDF data
        let pdfData = createPDF()

        // Present the share sheet with the generated PDF
        let activityViewController = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    private func createPDF() -> Data {
        let pdfMetaData = [
            kCGPDFContextTitle as String: "User Profile",
            kCGPDFContextCreator as String: "SymmetryHear"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData
        
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11.0 * 72.0
        let pageSize = CGSize(width: pageWidth, height: pageHeight)
        
        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: pageSize), format: format)
        
        let data = renderer.pdfData { context in
            context.beginPage()
            
            // Set the content's origin point and size
            let titleAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
            let bodyAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
            
            // Title of PDF
            let title = "User Profile"
            title.draw(at: CGPoint(x: 20, y: 20), withAttributes: titleAttributes)
            
            // Add the profile information
            let profileInfo = """
            Name: \(NametextF.text ?? "")
            Date of Birth: \(DOBDatePicker.date)
            Gender: \(GenderTextF.text ?? "")
            Occupation: \(OccupationTextF.text ?? "")
            Environment: \(EnviornmentTextF.text ?? "")
            Low Frequency: \(LowFreqTextF.text ?? "")
            High Frequency: \(HighFreqTextF.text ?? "")
            """
            
            profileInfo.draw(in: CGRect(x: 20, y: 60, width: pageWidth - 40, height: pageHeight - 80), withAttributes: bodyAttributes)
        }
        
        return data
    }
}
