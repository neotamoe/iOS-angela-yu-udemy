//
//  AppDelegate.swift
//  Todoey
//
//  Created by Neota Moe on 9/2/18.
//  Copyright © 2018 Neota Moe. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
      // print(Realm.Configuration.defaultConfiguration.fileURL)

      do{
        _ = try Realm()
      } catch {
        print("error initializing new realm, \(error)")
      }
    
    
      return true
  }

}

