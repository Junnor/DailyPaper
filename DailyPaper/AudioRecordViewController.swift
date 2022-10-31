//
//  AudioRecordViewController.swift
//  DailyPaper
//
//  Created by ys on 2022/10/31.
//

import UIKit
import AVFoundation

class AudioRecordViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    @IBOutlet var recordingTimeLabel: UILabel!
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var playButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    
    var meterTimer:Timer!
    
    var isAudioRecordingGranted: Bool!
    var isRecording = false
    var isPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkRecordPermission()
    }
    
    // check record permission
    func checkRecordPermission() {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .granted:
            isAudioRecordingGranted = true
            break
        case .denied:
            isAudioRecordingGranted = false
            break
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission({ (allowed) in
                if allowed {
                    self.isAudioRecordingGranted = true
                } else {
                    self.isAudioRecordingGranted = false
                }
            })
            break
        default:
            break
        }
    }
    
    // generate path where you want to save that recording as myRecording.m4a
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func getFileUrl() -> URL {
        let filename = "myRecording.m4a"
        let filePath = getDocumentsDirectory().appendingPathComponent(filename)
        return filePath
    }
    
    // Setup the recorder
    func setupRecorder() {
        if isAudioRecordingGranted {
            let session = AVAudioSession.sharedInstance()
            do {
                try session.setCategory(.playAndRecord, options: .defaultToSpeaker)
                try session.setActive(true)
                let settings = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 44100,
                    AVNumberOfChannelsKey: 2,
                    AVEncoderAudioQualityKey:AVAudioQuality.high.rawValue
                ]
                audioRecorder = try AVAudioRecorder(url: getFileUrl(), settings: settings)
                audioRecorder.delegate = self
                audioRecorder.isMeteringEnabled = true
                audioRecorder.prepareToRecord()
            }
            catch let error {
                displayAlert(msgTitle: "Error", msgDesc: error.localizedDescription, actionTitle: "OK")
            }
        }
        else {
            displayAlert(msgTitle: "Error", msgDesc: "Don't have access to use your microphone.", actionTitle: "OK")
        }
    }
    
    // Start recording when button start_recording press & display seconds using updateAudioMeter, & if recording is start then finish the recording
    @IBAction func startRecording(_ sender: UIButton) {
        if(isRecording) {
            finishAudioRecording(success: true)
            recordButton.setTitle("Record", for: .normal)
            playButton.isEnabled = true
            isRecording = false
        } else {
            setupRecorder()
            
            audioRecorder.record()
            meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)
            recordButton.setTitle("Stop", for: .normal)
            playButton.isEnabled = false
            isRecording = true
        }
    }
    
    @objc func updateAudioMeter(timer: Timer) {
        if audioRecorder.isRecording {
            let hr = Int((audioRecorder.currentTime / 60) / 60)
            let min = Int(audioRecorder.currentTime / 60)
            let sec = Int(audioRecorder.currentTime.truncatingRemainder(dividingBy: 60))
            let totalTimeString = String(format: "%02d:%02d:%02d", hr, min, sec)
            recordingTimeLabel.text = totalTimeString
            audioRecorder.updateMeters()
        }
    }
    
    func finishAudioRecording(success: Bool) {
        if success {
            audioRecorder.stop()
            audioRecorder = nil
            meterTimer.invalidate()
            print("recorded successfully.")
        } else {
            displayAlert(msgTitle: "Error", msgDesc: "Recording failed.", actionTitle: "OK")
        }
    }
    
    // Play the recording
    func preparePlay() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: getFileUrl())
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
        } catch {
            print("Error")
        }
    }
    
    @IBAction func playRecording(_ sender: Any) {
        if(isPlaying) {
            audioPlayer.stop()
            recordButton.isEnabled = true
            playButton.setTitle("Play", for: .normal)
            isPlaying = false
        }
        else {
            if FileManager.default.fileExists(atPath: getFileUrl().path) {
                recordButton.isEnabled = false
                playButton.setTitle("pause", for: .normal)
                preparePlay()
                audioPlayer.play()
                isPlaying = true
            } else {
                displayAlert(msgTitle: "Error", msgDesc: "Audio file is missing.", actionTitle: "OK")
            }
        }
    }
    
    //When recording is finish enable the play button & when play is finish enable the record button
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishAudioRecording(success: false)
        }
        playButton.isEnabled = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordButton.isEnabled = true
    }
    
    //Generalize function for display alert
    func displayAlert(msgTitle : String , msgDesc : String ,actionTitle : String) {
        let ac = UIAlertController(title: msgTitle, message: msgDesc, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: actionTitle, style: .default)
                     {
            (result : UIAlertAction) -> Void in
            _ = self.navigationController?.popViewController(animated: true)
        })
        present(ac, animated: true)
    }
    
}

