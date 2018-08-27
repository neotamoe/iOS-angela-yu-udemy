//
//  SelfDrivingCar.swift
//  Classes And Objects
//
//  Created by Neota Moe on 8/26/18.
//  Copyright © 2018 Neota Moe. All rights reserved.
//

import Foundation

class SelfDrivingCar : Car {
  
  var destination : String?

  override func drive() {
    super.drive()

    if let userSetDestination = destination {
      print("returning to " + userSetDestination)
    }

  }
  
}
