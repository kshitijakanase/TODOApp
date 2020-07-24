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
      let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("myNewItem.plist")
//   let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ToDoApp.plist")
//    print(dataFilePath!)
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
         loadIteams()
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
        aFuncToSaveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // MARK - ADD NEW ITEMS
    
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        //
        var textField = UITextField()
        let alert = UIAlertController(title: "Enter the new item in the list", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
          
           self.aFuncToSaveItems()
          
        }
       
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "enter item here"
            textField = alertTextField
        }
  alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func aFuncToSaveItems(){
        let encoder = PropertyListEncoder()

                  do {
                      let data = try encoder.encode(itemArray)
                      try data.write(to: dataFilePath!)

                  }catch {
                      print ("error \(error)")
                  }

                  tableView.reloadData()
    }
    
    
    
    func loadIteams(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
            itemArray = try decoder.decode([item].self, from: data)
            }
            catch{
                print("ERROR DURRING PRINTING ITEMS FROM PLIST -\(error)")
            }
        }
    }
}

