//
//  main.swift
//  Classes And Objects
//
//  Created by Neota Moe on 8/26/18.
//  Copyright © 2018 Neota Moe. All rights reserved.
//

import Foundation

let myCar = Car(customerChosenColor: "Red")

let someRichPersonsCar = Car(customerChosenColor: "Gold")

print(myCar.color)
print(myCar.carType)
print(myCar.numberOfSeats)

myCar.drive()

let mySelfDrivingCar = SelfDrivingCar()

print(mySelfDrivingCar.color)
mySelfDrivingCar.drive()
