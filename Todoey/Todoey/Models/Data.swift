//
//  Data.swift
//  Todoey
//
//  Created by Neota Moe on 9/5/18.
//  Copyright © 2018 Neota Moe. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
  @objc dynamic var name : String = ""
  @objc dynamic var age : Int = 0
}
