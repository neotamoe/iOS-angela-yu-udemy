//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Neota Moe on 9/4/18.
//  Copyright © 2018 Neota Moe. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CategoryViewController: UITableViewController {
  
    var categories : Results<Category>?
  
    let realm = try! Realm()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.rowHeight = 75.0
      
        loadCategories()
      

    }

    //MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return categories?.count ?? 1
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
      
      cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"
      
      cell.delegate = self
      
      return cell
    }
  
  
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      performSegue(withIdentifier: "goToItems", sender: self)
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      let destinationVC = segue.destination as! ToDoListViewController
      
      if let indexPath = tableView.indexPathForSelectedRow {
        destinationVC.selectedCategory = categories?[indexPath.row]
      }
    }
  
    //MARK - Data Manipulation Methods
  func save(category: Category) {
      
      do{
        try realm.write {
          realm.add(category)
        }
      } catch {
        print("Error saving context: \(error)")
      }
      self.tableView.reloadData()
    }
  

    func loadCategories() {
      categories = realm.objects(Category.self)
      
      tableView.reloadData()
    }
  
    //MARK - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
      
        var textField = UITextField()
      
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        
        let newCategory = Category()
        newCategory.name = textField.text!
        
          self.save(category: newCategory)
        
      }
      
      alert.addTextField { (alertTextField) in
        alertTextField.placeholder = "Create new category"
        textField = alertTextField
      }
      
      alert.addAction(action)
      
      present(alert, animated: true, completion: nil)
    }
  
}

// MARK: - Swipe Cell Delegate Methods
extension CategoryViewController: SwipeTableViewCellDelegate {
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
    guard orientation == .right else { return nil }
    
    let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
      // handle action by updating model with deletion
      if let category = self.categories?[indexPath.row] {
        do{
          try self.realm.write {
            print(category)
            self.realm.delete(category)
          }
        } catch {
          print("Error deleting category: \(error)")
        }

      }
      
    }
    
    // customize the action appearance
    deleteAction.image = UIImage(named: "delete-icon")
    
    return [deleteAction]
  }
  
  func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
    var options = SwipeOptions()
    options.expansionStyle = .destructive
    return options
  }
  
}
