//
//  ViewController.swift
//  ToDoey
//
//  Created by Keith Carter on 2/9/18.
//  Copyright © 2018 Keith Carter. All rights reserved.
//

import UIKit

class TodoeyTableViewController: UITableViewController {

    var itemArray = ["Code IOS", "Code Android"," Build a Website"]
    
    let defaultskc = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let itemskc = defaultskc.array(forKey: "TodoListArray") as? [String]{
            itemArray = itemskc
        }
    }
    
    //MARK: Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - Table View Delgate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{ tableView.cellForRow(at: indexPath)?.accessoryType = .none}else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    //MARK: Add new items
    
    @IBAction func addToList(_ sender: UIBarButtonItem) {
        var textFieldkc = UITextField()
        
        let alertkc = UIAlertController(title: "Add new list item", message: " What's next ", preferredStyle: .alert)
        
        let actionkc = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what happens when user clicks add item
            print(textFieldkc.text!)
            self.itemArray.append(textFieldkc.text!)
            
            self.defaultskc.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alertkc.addTextField { (alertTextFieldkc) in
            alertTextFieldkc.placeholder = "Enter next Item"
            textFieldkc = alertTextFieldkc
            
        }
        
       alertkc.addAction(actionkc)
        
        present(alertkc,animated: true, completion: nil)
    }
    
    
    
}
