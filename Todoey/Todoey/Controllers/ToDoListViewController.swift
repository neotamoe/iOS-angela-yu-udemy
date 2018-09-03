//
//  ViewController.swift
//  Todoey
//
//  Created by Neota Moe on 9/2/18.
//  Copyright © 2018 Neota Moe. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    var itemArray = [Item]()
//  var itemArray = ["Go to State Fair", "Find keeper jersey", "get umbrella"]
  
  let defaults = UserDefaults.standard
  
  override func viewDidLoad() {
    super.viewDidLoad()
      var newItem = Item()
      newItem.title = "Go to State Fair"
      itemArray.append(newItem)

      var newItem2 = Item()
      newItem2.title = "find keeper jersey"
      itemArray.append(newItem2)
    
      var newItem3 = Item()
      newItem3.title = "get umbrella"
      itemArray.append(newItem3)
    
//    if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
//      itemArray = items
//    }
  }
  
  //MARK - TableView Datasource Methods
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    
    let item = itemArray[indexPath.row]
    
    cell.textLabel?.text = item.title
    
    cell.accessoryType = item.done ? .checkmark : .none
    
    return cell
  }

  // MARK - TableView Delegate Methods
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
      itemArray[indexPath.row].done = !itemArray[indexPath.row].done
      tableView.reloadData()
    
      tableView.deselectRow(at: indexPath, animated: true)
  }
  
  // MARK - add new items
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
      var textField = UITextField()
    
      let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
    
      let action = UIAlertAction(title: "Add Item", style: .default) { (action) in

        let newItem = Item()
        newItem.title = textField.text!
        self.itemArray.append(newItem)
//        self.defaults.set(self.itemArray, forKey: "ToDoListArray")
        self.tableView.reloadData()
      }
    
      alert.addTextField { (alertTextField) in
        alertTextField.placeholder = "Create new item"
        textField = alertTextField
      }
    
      alert.addAction(action)
    
      present(alert, animated: true, completion: nil)
  }
  
}

