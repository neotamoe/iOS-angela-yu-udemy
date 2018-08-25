//
//  ViewController.swift
//  Magic8Ball
//
//  Created by Neota Moe on 8/24/18.
//  Copyright © 2018 Neota Moe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var ballImage: UIImageView!
  var ballImageIndex = 0
  let ballArray = ["ball1","ball2","ball3","ball4","ball5"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    changeBallImage()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func askButtonPressed(_ sender: Any) {
    ballImageIndex = Int(arc4random_uniform(5))
    print(ballImageIndex)
    ballImage.image = UIImage(named: ballArray[ballImageIndex])  
  }
  
  func changeBallImage() {
    ballImageIndex = Int(arc4random_uniform(5))
    print(ballImageIndex)
    ballImage.image = UIImage(named: ballArray[ballImageIndex])
  }
  
  override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
    changeBallImage()
  }
}

