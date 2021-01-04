//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
//    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(dataFilePath)
        
        let newItem = Item()
        newItem.title = "Buy PS5"
        newItem.done = true
        itemArray.append(newItem)
        let newItem2 = Item()
        newItem2.title = "Buy PS4"
        itemArray.append(newItem2)
        let newItem3 = Item()
        newItem3.title = "Buy PS3"
        itemArray.append(newItem3)
        
//        if let savedArray = defaults.array(forKey: "ToDoListArray") as? [Item] {
//            itemArray = savedArray
//        }
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//        tableView.reloadRows(at: [indexPath], with: .none)
        self.tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        var textField: UITextField?;
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let newItemTxt = textField?.text, !newItemTxt.isEmpty {
                let newItem = Item()
                newItem.title = newItemTxt
                self.itemArray.append(newItem)
                let encoder = PropertyListEncoder()
                do {
                    let data = try encoder.encode(self.itemArray)
                    try data.write(to: self.dataFilePath!)
                } catch {
                    print(error)
                }
                self.tableView.reloadData()
            }
        }
        alert.addTextField { (alertTextField) in
            textField = alertTextField
            alertTextField.placeholder = "Create new item"
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}


