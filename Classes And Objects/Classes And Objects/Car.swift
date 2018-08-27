//
//  Car.swift
//  Classes And Objects
//
//  Created by Neota Moe on 8/26/18.
//  Copyright © 2018 Neota Moe. All rights reserved.
//

import Foundation

enum CarType {
  case Sedan
  case Coupe
  case Hatchback
}

class Car {
  
  var color = "Black"
  var numberOfSeats = 5
  var carType : CarType = .Coupe

  init() {
    
  }
  
  convenience init(customerChosenColor: String) {
    self.init()
    color = customerChosenColor
  }
  
  func drive() {
    print("car is moving")
  }
  
}


