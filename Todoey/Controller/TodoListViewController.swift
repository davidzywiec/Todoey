//
//  ViewController.swift
//  Todoey
//
//  Created by David Zywiec on 5/17/19.
//  Copyright © 2019 SirHowardGrubb. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item] ()
    
   let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
    }
    
    //MARK - Tableview Datasource Method
    
    //TODO - cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.accessoryType = (item.checked ? .checkmark : .none)
        
        cell.textLabel?.text = item.title
        
        return cell
        
        
    }
    
    //TODO - numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //TODO - override did select cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        let item = itemArray[indexPath.row]
        item.checked = !item.checked
        
        cell?.accessoryType = item.checked ? .checkmark : .none
        
        saveDate()
        
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    
    //MARK: Create todo item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "New Todoey Item", message: "Enter a new Todoey", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Submit Item", style: .default) { (alertAction) in
            
            if textfield.text != nil {
                self.itemArray.append(Item(titleData: textfield.text!))
                self.saveDate()
                
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
    
    //MARK: Save Data into encoded file
    func saveDate(){
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: documentURL!)
        }
        catch {
            print("Error found encoding. \(error)")
        }
        
        tableView.reloadData()
    }
    
    //MARK: Load data into item Array from encoded plist file.
    func loadData(){
        
        if let data = try? Data(contentsOf: documentURL!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            }
            catch {
                print("Error decoding \(error)")
            }
        }
        
    }
    
 
}

