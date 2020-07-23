//
//  ViewController.swift
//  TODOApp
//
//  Created by MACBOOKPRO on 20/07/20.
//  Copyright © 2020 MACBOOKPRO. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [item]()
    
    let defaults =  UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let newItem = item()
        newItem.title = "declare the task"
        //newItem.done =  true
        itemArray.append(newItem)
        
        let newItem2 = item()
        newItem2.title = "edit the task"
        itemArray.append(newItem2)
        
        let newItem3 = item()
        newItem3.title = "do the task"
        itemArray.append(newItem3)
        
        if let items = (defaults.array(forKey: "ToDoListArray") as? [item]){
            itemArray = items
        }
        
    }
    
//MARK - TABLEVIEW DATASOURCE METHODS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done == true ? .checkmark : .none
           
        return cell
    }
//MARK - TABLEVIEW DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
       
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // MARK - ADD NEW ITEMS
    
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Enter the new item in the list", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.setValue(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
       
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "enter item here"
            textField = alertTextField
        }
  alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

