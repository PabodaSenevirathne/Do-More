//
//  ViewController.swift
//  DoMore
//
//  Created by user234693 on 10/17/23.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {
    

    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "To Do List"
        view.addSubview(table)
        table.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self , action: #selector(addTapItem))
        // Do any additional setup after loading the view.
    }
    
    @objc private func addTapItem(){
        let alert = UIAlertController(title: "New Item", message: "Enter new to do list item!", preferredStyle: .alert)
        alert.addTextField{ field in field.placeholder = "Write an item"}
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(_) in
            
        }))
        
        present(alert, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }


}

