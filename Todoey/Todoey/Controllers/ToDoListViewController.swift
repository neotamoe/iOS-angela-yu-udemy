//
//  ViewController.swift
//  Todoey
//
//  Created by Neota Moe on 9/2/18.
//  Copyright © 2018 Neota Moe. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class ToDoListViewController: SwipeTableViewController {
  
  let realm = try! Realm()
  var todoItems : Results<Item>?
  
  var selectedCategory : Category? {
    didSet{
      loadItems()
    }
  }
  
  @IBOutlet weak var searchBar: UISearchBar!
  
  //  let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.separatorStyle = .none

  }
  
  override func viewWillAppear(_ animated: Bool) {
    title = selectedCategory?.name

    guard let colorHex = selectedCategory?.color else { fatalError() }
    
    updateNavBar(withHexCode: colorHex)

  }
  
  override func viewWillDisappear(_ animated: Bool) {
    updateNavBar(withHexCode: "1D9BF6")
  }
  
  //MARK - NavBar Setup Methods
  func updateNavBar(withHexCode colorHexCode: String) {
    guard let navBar = navigationController?.navigationBar else {
      fatalError("Navigation controller does not exist")}
    
    
    guard let navBarColor = UIColor(hexString: colorHexCode) else { fatalError() }
    
    navBar.barTintColor = navBarColor
    
    searchBar.barTintColor = navBarColor
    
    navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
    
    navBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : ContrastColorOf(navBarColor, returnFlat: true)]
  }
  
  //MARK - TableView Datasource Methods
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todoItems?.count ?? 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = super.tableView(tableView, cellForRowAt: indexPath)
    
    if let item = todoItems?[indexPath.row]{
    
      cell.textLabel?.text = item.title
      cell.accessoryType = item.done ? .checkmark : .none
      
      if let color = UIColor(hexString: selectedCategory!.color)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(todoItems!.count)) {

        cell.backgroundColor = color
        cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
      }
      
    } else {
      
      cell.textLabel?.text = "No Items Added"
    
    }
    
    return cell
  }

  // MARK - TableView Delegate Methods
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let item = todoItems?[indexPath.row] {
      do {
        try realm.write {
          item.done = !item.done
          // if we wanted to delete on click instead of checking it as done
          // realm.delete(item)
        }
      } catch {
        print("error saving done status, \(error)")
      }
    }
    tableView.reloadData()
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  // MARK - add new items
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
      var textField = UITextField()
    
      let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
    
      let action = UIAlertAction(title: "Add Item", style: .default) { (action) in

          if let currentCategory = self.selectedCategory {
              do{
                  try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                  }
              } catch {
                  print("Error saving new item: \(error)")
              }
          }
        
          self.tableView.reloadData()

      }
    
      alert.addTextField { (alertTextField) in
        alertTextField.placeholder = "Create new item"
        textField = alertTextField
      }
    
      alert.addAction(action)
    
      present(alert, animated: true, completion: nil)
  }
  
  //MARK - Delete Data from Swipe
  override func updateModel(at indexPath: IndexPath) {
    if let itemToDelete = todoItems?[indexPath.row] {
      do{
        try realm.write {
          print(itemToDelete)
          realm.delete(itemToDelete)
        }
      } catch {
        print("Error deleting category: \(error)")
      }
      tableView.reloadData()
      
    }
  }
  
  
  // MARK - Model Manipulation Methods

  func loadItems() {
    todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
  }
  
}

//MARK: - Search bar methods
extension ToDoListViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

//    todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
    todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
    tableView.reloadData()

  }

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchBar.text?.count == 0 {
      loadItems()
      
      DispatchQueue.main.async {
        searchBar.resignFirstResponder()
      }
      
    }
  }

}

