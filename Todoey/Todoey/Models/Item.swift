//
//  Item.swift
//  Todoey
//
//  Created by Neota Moe on 9/5/18.
//  Copyright © 2018 Neota Moe. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
  
  @objc dynamic var title : String = ""
  @objc dynamic var done : Bool = false
 
  // define inverse relationship
  var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
