//
//  CategoryViewController.swift
//  ToDoey
//
//  Created by Keith Carter on 2/22/18.
//  Copyright © 2018 Keith Carter. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [ListCategory]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ListCategory.plist")
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
 
    
    //MARK: TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name

        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    //MARK: TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    //MARK: Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textFieldkc = UITextField()
        
        let alertkc = UIAlertController(title: "Add new Category", message: " What's next ", preferredStyle: .alert)
        
        let actionkc = UIAlertAction(title: "Add Category", style: .default) { (action) in
            // what happens when user clicks add item
            
            
            let newCategory = ListCategory(context: self.context)
            
            newCategory.name = textFieldkc.text
            
            self.categoryArray.append(newCategory)
            
            //self.saveItems()
        
    }
  
    //MARK: Data Manipulation Methods
}
}
