//
//  CategoryTableViewController.swift
//  Menu
//
//  Created by Syimyk on 3/2/21.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    var categoryManager = CategoryManager()
    
    
    var categories  : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        categoryManager.delegate = self
        categoryManager.fetchCategories()
        title = "Выберите Категорию"
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        return cell
    }
    
    
}


extension CategoryTableViewController : CategoryManagerDelegate{
    func didUpdateData(_ categoryManager: CategoryManager, categories: [String]) {
        print("Im triggered")
        self.categories = categories
        tableView.reloadData()
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
    
    
}
