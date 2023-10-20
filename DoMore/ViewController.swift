//
//  ViewController.swift
//  DoMore
//
//  Created by user234693 on 10/17/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    var items = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = UserDefaults.standard.stringArray(forKey: "items") ?? []
        title = "To Do List"
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self , action: #selector(addTapItem))
        // Do any additional setup after loading the view.
    }
    
    @objc private func addTapItem(){
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        alert.addTextField{ field in field.placeholder = "Write an item"}
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {[weak self] (_) in
            if let field = alert.textFields?.first{
                if let text = field.text, !text.isEmpty{
                    DispatchQueue.main.async {
                        var currentItems = UserDefaults.standard.stringArray(forKey: "items") ?? []
                        currentItems.append(text)
                        UserDefaults.standard.setValue(currentItems, forKey:"items")
                        self?.items.append(text)
                        self?.table.reloadData()                    }
                    
                }
            }
            
        }))
        
        present(alert, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
   
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            //items.remove(at: indexPath.row)
            let deletedItem = items.remove(at: indexPath.row)
            deleteItem(items: deletedItem)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
        
      
    }
    
    func deleteItem(items:String){
        if var savedItems = UserDefaults.standard.stringArray(forKey: "items"){
            if let index = savedItems.firstIndex(of: items){
                savedItems.remove(at: index)
                UserDefaults.standard.set(savedItems,forKey:"items")
                
            }
        }
        
        
    }
   
    


}

