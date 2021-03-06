//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Neota Moe on 9/4/18.
//  Copyright © 2018 Neota Moe. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
  
    var categories : Results<Category>?
  
    let realm = try! Realm()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        loadCategories()
      
        tableView.separatorStyle = .none
      
    }

    //MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return categories?.count ?? 1
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = super.tableView(tableView, cellForRowAt: indexPath)
      
      cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"
      
      if let cellBackgroundColor = categories?[indexPath.row].color {
          cell.backgroundColor = UIColor(hexString: cellBackgroundColor)
          cell.textLabel?.textColor = ContrastColorOf(UIColor(hexString: cellBackgroundColor)!, returnFlat: true)
      } else {
        cell.backgroundColor = UIColor(hexString: "80080")
        cell.textLabel?.textColor = ContrastColorOf(UIColor(hexString: "800080")!, returnFlat: true)
      }
      
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
      tableView.reloadData()
    }
  

    func loadCategories() {
      categories = realm.objects(Category.self)
      
      tableView.reloadData()
    }
  
  //MARK - Delete Data from Swipe
  override func updateModel(at indexPath: IndexPath) {
      if let categoryToDelete = categories?[indexPath.row] {
        do{
          try realm.write {
            print(categoryToDelete)
            realm.delete(categoryToDelete)
          }
        } catch {
          print("Error deleting category: \(error)")
        }
        tableView.reloadData()

      }
  }
  
    //MARK - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
      
        var textField = UITextField()
      
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        
        let newCategory = Category()
          newCategory.name = textField.text!
          newCategory.color = UIColor.randomFlat.hexValue()
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
