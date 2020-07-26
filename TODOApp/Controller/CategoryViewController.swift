//
//  CategoryViewController.swift
//  TODOApp
//
//  Created by MACBOOKPRO on 25/07/20.
//  Copyright © 2020 MACBOOKPRO. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
loadCategories()
     
    }
    
    func loadCategories(){
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do{
           categories = try context.fetch(request)
        }catch{
            print("THERE IS ERROR LOADING CATEGOIES - \(error)")
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return categories.count
       }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories[indexPath.row]
        }
        
    }
    
       
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
           
          // let item = categories[indexPath.row]
        
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
               let alert = UIAlertController(title: " Add New Category ", message: "", preferredStyle: .alert)
               
               let action = UIAlertAction(title: "Add", style: .default) { (action) in
                 
                let newCategory = Category(context: self.context)
                newCategory.name = textField.text
                self.categories.append(newCategory)
                self.saveCategory()
        }
        alert.addAction(action)
        
        alert.addTextField { (field) in
                   field.placeholder = "enter category here"
                   textField = field
               }
      present(alert, animated: true, completion: nil)
}
    func saveCategory(){
        do{
            try context.save()
        }catch{
            print("ERROR WHILE SAVING THE DATA TO PERSISTENT-  \(error)")
        }
        tableView.reloadData()
    }
}
