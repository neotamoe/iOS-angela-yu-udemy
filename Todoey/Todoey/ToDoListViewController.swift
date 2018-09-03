//
//  ViewController.swift
//  Todoey
//
//  Created by Neota Moe on 9/2/18.
//  Copyright © 2018 Neota Moe. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

  var itemArray = ["Go to State Fair", "Find keeper jersey", "get umbrella"]
  
  let defaults = UserDefaults.standard
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
      itemArray = items
    }
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    
    cell.textLabel?.text = itemArray[indexPath.row]
    
    return cell
  }

  // MARK - TableView Delegate Methods
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
      } else {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
      }
      tableView.deselectRow(at: indexPath, animated: true)
  }
  
  // MARK - add new items
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
      var textField = UITextField()
    
      let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
    
      let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        print("Success! " + textField.text!)
        self.itemArray.append(textField.text!)
        self.defaults.set(self.itemArray, forKey: "ToDoListArray")
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

