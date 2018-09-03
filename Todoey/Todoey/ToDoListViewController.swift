//
//  ViewController.swift
//  Todoey
//
//  Created by Neota Moe on 9/2/18.
//  Copyright © 2018 Neota Moe. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

  let itemArray = ["Go to State Fair", "Find keeper jersey", "get umbrella"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    
    cell.textLabel?.text = itemArray[indexPath.row]
    
    return cell
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArray.count
  }
  
  
}

