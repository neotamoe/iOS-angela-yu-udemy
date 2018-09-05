//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Neota Moe on 9/4/18.
//  Copyright © 2018 Neota Moe. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
  
    var categoryArray = [Category]()
  
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
      

    }

    //MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return categoryArray.count
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
      
      let category = categoryArray[indexPath.row]
      
      cell.textLabel?.text = category.name
      
      return cell
    }
  
    //MARK - Data Manipulation Methods
    func saveCategories() {
      
      do{
        try context.save()
      } catch {
        print("Error saving context: \(error)")
      }
      self.tableView.reloadData()
    }
  
    // this has an internal parameter name (with), an external parameter name (request), and a default parameter that will be used if none is provided
    func loadCategories(with request : NSFetchRequest<Category> = Category.fetchRequest()) {
      do {
        categoryArray = try context.fetch(request)
      } catch {
        print("error fetching data from context \(error)")
      }
      tableView.reloadData()
    }
  
    //MARK - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
      
        var textField = UITextField()
      
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        
        let newCategory = Category(context: self.context)
        newCategory.name = textField.text!
        self.categoryArray.append(newCategory)
        
        self.saveCategories()
        
      }
      
      alert.addTextField { (alertTextField) in
        alertTextField.placeholder = "Create new category"
        textField = alertTextField
      }
      
      alert.addAction(action)
      
      present(alert, animated: true, completion: nil)
    }
  
  
    //MARK - TableView Delegate Methods
  
}
