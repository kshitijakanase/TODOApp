//
//  ViewController.swift
//  TODOApp
//
//  Created by MACBOOKPRO on 20/07/20.
//  Copyright © 2020 MACBOOKPRO. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    let itemArray = ["declare the task","edit the task","do the task"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
//MARK - TABLEVIEW DATASOURCE METHODS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
//MARK - TABLEVIEW DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}

