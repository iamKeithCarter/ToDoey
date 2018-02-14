//
//  ViewController.swift
//  ToDoey
//
//  Created by Keith Carter on 2/9/18.
//  Copyright © 2018 Keith Carter. All rights reserved.
//

import UIKit

class TodoeyTableViewController: UITableViewController {

    var itemArray = [Itm]()
    
    let defaultskc = UserDefaults.standard
    
    let dateFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
       // print(dateFilePath!)
        
        let newItem = Itm()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Itm()
        newItem2.title = "stop Mike"
        itemArray.append(newItem2)
        
        let newItem3 = Itm()
        newItem3.title = "capture Mike"
        itemArray.append(newItem3)
        
//        if let itemskc = defaultskc.array(forKey: "TodoListArray") as? [Itm]{
//            itemArray = itemskc
//        }
    }
    
    //MARK: Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
//      Ternary operator
//      value = condition ? valueIftrue: valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    
    //MARK - Table View Delgate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
       
        saveItems()

        //        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{ tableView.cellForRow(at: indexPath)?.accessoryType = .none}else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    //MARK: Add new items
    
    @IBAction func addToList(_ sender: UIBarButtonItem) {
        var textFieldkc = UITextField()
        
        let alertkc = UIAlertController(title: "Add new list item", message: " What's next ", preferredStyle: .alert)
        
        let actionkc = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what happens when user clicks add item
            print(textFieldkc.text!)
            
            let newItem = Itm()
            newItem.title = textFieldkc.text!
            
            self.itemArray.append(newItem)
            // adding to plist and not user defaults
            //self.defaultskc.set(self.itemArray, forKey: "TodoListArray")
            
            self.saveItems()
            
            
        }
        
        alertkc.addTextField { (alertTextFieldkc) in
            alertTextFieldkc.placeholder = "Enter next Item"
            textFieldkc = alertTextFieldkc
            
        }
        
       alertkc.addAction(actionkc)
        
        present(alertkc,animated: true, completion: nil)
    }
    
    
    //MARK: - Model Manipulation Methods
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(
                itemArray)
            try data.write(to: dateFilePath!)
        }catch{
            print("Error encoding item array,\(error)")
        }
        self.tableView.reloadData()
    }
    
}
