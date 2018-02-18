//
//  ViewController.swift
//  ToDoey
//
//  Created by Keith Carter on 2/9/18.
//  Copyright © 2018 Keith Carter. All rights reserved.
//

import UIKit
import CoreData

class TodoeyTableViewController: UITableViewController{

    var itemArray = [Itm]()
    
   // let defaultskc = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        loadItems()
        
       
    }
    
    //MARK: Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
//      Ternary operator
//      value = condition ? valueIftrue: valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    
    //MARK - Table View Delgate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        // remove from the array and data base  This and the add remvove a checkmark cannot be part of the same tap. Must create a different field to tap to mark as done or not.  current set up will cause Index out of range.
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
     
        //  itemArray[indexPath.row].setValue("Completed  \(itemArray[indexPath.row].title!)", forKey: "title")
        saveItems()

        //        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{ tableView.cellForRow(at: indexPath)?.accessoryType = .none}else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    //MARK: Dialog to  Add new items when plus button is pressed
    
    @IBAction func addToList(_ sender: UIBarButtonItem) {
        var textFieldkc = UITextField()
        
        let alertkc = UIAlertController(title: "Add new list item", message: " What's next ", preferredStyle: .alert)
        
        let actionkc = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what happens when user clicks add item
            print(textFieldkc.text!)
            
            
            
            let newItem = Itm(context: self.context)
           
            newItem.title = textFieldkc.text
            newItem.done = false
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
        
        //let encoder = PropertyListEncoder()
        do{
             try context.save()
        }catch{
            print("Error saving context,\(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems( with request:NSFetchRequest<Itm> = Itm.fetchRequest()) {
        // let request : NSFetchRequest<Itm> = Itm.fetchRequest()
      
        do{
        itemArray = try context.fetch(request)
        }catch {
            print("fetch error \(error)")
        }
    tableView.reloadData()
    }

}

// MARK: Search bar methods
    extension TodoeyTableViewController : UISearchBarDelegate {
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            
           let request : NSFetchRequest<Itm> = Itm.fetchRequest()

            let predicate = NSPredicate(format:"title CONTAINS[cd] %@", searchBar.text!)
            request.predicate = predicate

           let sortDescriptor = NSSortDescriptor(key:"title", ascending:true)
            request.sortDescriptors = [sortDescriptor]
            loadItems(with: request)
            
            func searchBar(_ searchBar: UISearchBar, textDidChange: String){
                if searchBar.text?.count == 0{
                loadItems()
                    DispatchQueue.main.async{
                        searchBar.resignFirstResponder()
                    }
                
                }
            }
        }
    }


