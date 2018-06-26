//
//  ViewController.swift
//  Scribe
//
//  Created by Munji on 6/23/18.
//  Copyright © 2018 Munji. All rights reserved.
//  ------------>           <-------------

import UIKit
//import framework
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var transcriptionTextField: UITextView!
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide spinner when you launch app
        activitySpinner.isHidden = true
    }
    
    // recognizes when audio finishes
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
        
    }
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                // download the test.m4a
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a") {
                    do {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        sound.play()
                        
                    } catch {
                        print("error!")
                    }
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request) { (result, error) in
                        if let error = error {
                            print("there was an error: \(error)")
                        } else {
                           self.transcriptionTextField.text = result?.bestTranscription.formattedString
                        }
                    }
                    
                }
                
            }
        }
    }
// when btn is pressed. we want to show our hidden activity spinner
   
    @IBAction func btnPressed(_ sender: Any) {
    
    activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeechAuth()
    }
    
}

