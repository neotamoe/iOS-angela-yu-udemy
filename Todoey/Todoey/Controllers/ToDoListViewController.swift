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
  
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
      loadItems()

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
    
      saveItems()
    
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
        
        self.saveItems()

      }
    
      alert.addTextField { (alertTextField) in
        alertTextField.placeholder = "Create new item"
        textField = alertTextField
      }
    
      alert.addAction(action)
    
      present(alert, animated: true, completion: nil)
  }
  
  // MARK - Model Manipulation Methods
  func saveItems() {
    let encoder = PropertyListEncoder()
    
    do{
      let data = try encoder.encode(itemArray)
      try data.write(to: dataFilePath!)
    } catch {
      print("error encoding item array, \(error)")
    }
    tableView.reloadData()
  }
  
  func loadItems() {
    if let data = try? Data(contentsOf: dataFilePath!) {
      let decoder = PropertyListDecoder()
      do {
        itemArray = try decoder.decode([Item].self, from: data)
      } catch {
        print("error decoding item array, \(error)")
      }
    }
  }
  
}
