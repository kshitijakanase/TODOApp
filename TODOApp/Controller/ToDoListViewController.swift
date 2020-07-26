//
//  ViewController.swift
//  TODOApp
//
//  Created by MACBOOKPRO on 20/07/20.
//  Copyright © 2020 MACBOOKPRO. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController  {
    
    var itemArray = [Item]()
    var selectedCategory : Category? {
        didSet{

            loadIteams()
        }
    }
     
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
   
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
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
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
       do {
                    try context.save()
        
       }catch {
                      print ("error \(error)")
                  }

                  tableView.reloadData()
    }
    
    
    
    func loadIteams(with request: NSFetchRequest<Item>  = Item.fetchRequest(),  predicate : NSPredicate? = nil){
  //  let request : NSFetchRequest<Item> = Item.fetchRequest()
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionPredicate])
        }else {
            request.predicate = categoryPredicate
        }
            do{
              itemArray  = try context.fetch(request)
            }
            catch{
                print("ERROR DURRING FETCHING DATA FROM NS -\(error)")
            }
        tableView.reloadData()
        }
}

extension ToDoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
       let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
         request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
       
        loadIteams(with: request, predicate: predicate)

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadIteams()
            DispatchQueue.main.async {
                 searchBar.resignFirstResponder()
            }
    }

    
}

}
