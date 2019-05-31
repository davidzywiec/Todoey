//
//  ViewController.swift
//  Todoey
//
//  Created by David Zywiec on 5/17/19.
//  Copyright © 2019 SirHowardGrubb. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item] ()
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadData()
    }
    
    //MARK - Tableview Datasource Method
    
    //TODO - cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.accessoryType = (item.done ? .checkmark : .none)
        
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
        item.done = !item.done
        
        cell?.accessoryType = item.done ? .checkmark : .none
        
        saveDate()
        
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    //TODO - delete on swipe
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
//
//        saveDate()
//    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") {
            action, index in
            
            self.context.delete(self.itemArray[indexPath.row])
            self.itemArray.remove(at: indexPath.row)
            self.saveDate()
            
        }
        
        return [delete]
    }
    
    
    //MARK: Create todo item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "New Todoey Item", message: "Enter a new Todoey", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Submit Item", style: .default) { (alertAction) in
            
            if textfield.text != nil {
                
                let item = Item(context: self.context)
                item.title = textfield.text!
                item.done = false
                
                self.itemArray.append(item)
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
        
        do {
         try context.save()
        }
        catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    //MARK: Load data into item Array from encoded plist file.
    func loadData(){
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("request error /(error)")
        }
        
    }
    
 
}

