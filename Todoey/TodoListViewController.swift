//
//  ViewController.swift
//  Todoey
//
//  Created by David Zywiec on 5/17/19.
//  Copyright © 2019 SirHowardGrubb. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Item1","Item2","Item3"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let items = defaults.array(forKey: "itemArrayTodoey") as? [String] {
            itemArray = items
        }
    }
    
    //MARK - Tableview Datasource Method
    
    //TODO - cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
        
    }
    
    //TODO - numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //TODO - override did select cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        
        if cell?.accessoryType == UITableViewCell.AccessoryType.none {
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    //MARK: Create todo item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "New Todoey Item", message: "Enter a new Todoey", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Submit Item", style: .default) { (alertAction) in
            
            
            if textfield.text != nil {
                self.itemArray.append(textfield.text!)
                self.tableView.reloadData()
                self.defaults.set(self.itemArray, forKey: "itemArrayTodoey")

            } else {
                print("No value input")
            }
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertText) in
            alertText.placeholder = "Enter Item"
            textfield = alertText
        }
        
        present(alert, animated: true, completion: nil)
        
        
        
    }
    
    


}

