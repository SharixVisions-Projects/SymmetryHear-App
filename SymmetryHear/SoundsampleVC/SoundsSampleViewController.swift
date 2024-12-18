import UIKit
import AVFoundation

class SoundsSampleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var TableV: UITableView!

    var selectedsoundIndex: Int?
    let SoundsFsampleList = ["frequency1", "frequency2", "frequency3", "frequency4", "frequency5", "frequency6", "frequency7", "frequency8", "frequency9", "frequency10", "frequency11", "frequency12", "frequency13", "frequency14", "frequency15", "frequency16", "frequency17", "frequency18", "frequency19", "frequency20"]

    var audioPlayer: AVAudioPlayer?
    var isPlaying = false
    var currentlyPlayingIndex: Int?
    var previousButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        TableV.delegate = self
        TableV.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showAlert(title: "Alert!", message: "For the best experience, please use headphones to listen to the frequency sound for optimal clarity and results.")
    }

    @IBAction func BackBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    func playSound(fileName: String) {
        if let soundURL = Bundle.main.url(forResource: fileName, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
                print("Playing sound: \(fileName)")
            } catch {
                print("Failed to play sound: \(fileName)")
            }
        }
    }

    func stopSound() {
        audioPlayer?.stop()
        audioPlayer = nil
        print("Sound stopped")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SoundsFsampleList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SoundsSampleTableViewCell
        let soundName = SoundsFsampleList[indexPath.row]
        cell.Soundlbl.text = soundName
        cell.SoundPlayandStopbtn.tag = indexPath.row // Set the button tag
        
        // Set the play image if it's not the currently playing index
        if indexPath.row == currentlyPlayingIndex {
            cell.SoundPlayandStopbtn.setImage(UIImage(named: "stopimg"), for: .normal)
        } else {
            cell.SoundPlayandStopbtn.setImage(UIImage(named: "playimg"), for: .normal)
        }
        
        cell.SoundPlayandStopbtn.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    @objc func didTapButton(_ sender: UIButton) {
        let index = sender.tag // Get the index from the button's tag
        let soundName = SoundsFsampleList[index]
        
        if isPlaying && currentlyPlayingIndex == index {
            // Stop the current sound
            stopSound()
            isPlaying = false
            sender.setImage(UIImage(named: "playimg"), for: .normal)
            currentlyPlayingIndex = nil
        } else {
            // Stop the previous sound if playing and update its button
            if isPlaying, let previousIndex = currentlyPlayingIndex {
                stopSound()
                if let previousButton = previousButton {
                    previousButton.setImage(UIImage(named: "playimg"), for: .normal)
                }
            }
            
            // Play the new sound
            playSound(fileName: soundName)
            isPlaying = true
            currentlyPlayingIndex = index
            sender.setImage(UIImage(named: "stopimg"), for: .normal)
        }
        
        // Store the reference to the current button
        previousButton = sender
    }
}
