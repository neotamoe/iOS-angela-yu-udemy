//
//  Category.swift
//  Todoey
//
//  Created by Neota Moe on 9/5/18.
//  Copyright © 2018 Neota Moe. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
  
  @objc dynamic var name : String = ""
  // this defines a forward relationship
  let items = List<Item>()
}
