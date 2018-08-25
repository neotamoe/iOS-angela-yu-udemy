//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController, AVAudioPlayerDelegate{
    
    var audioPlayer : AVAudioPlayer!
    let xylophoneSounds = ["note1", "note2", "note3", "note4", "note5", "note6", "note7"]
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }



    @IBAction func notePressed(_ sender: UIButton) {

      playSound(soundFileName: xylophoneSounds[sender.tag - 1])

    }
  
  
  func playSound(soundFileName : String) {
    
    let url = Bundle.main.url(forResource: soundFileName, withExtension: "wav")
    
    do {
      
      audioPlayer = try AVAudioPlayer(contentsOf: url!)
      
    } catch let error {
      
      print(error)
      
    }
    
    audioPlayer.play()
  }

}

