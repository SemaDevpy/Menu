//
//  CategoryTableViewController.swift
//  Menu
//
//  Created by Syimyk on 3/2/21.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    var categoryManager = CategoryManager()
    
    
    var categories  : [CategoryModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        categoryManager.delegate = self
        categoryManager.fetchCategories()
        title = "Выберите Категорию"
    }

// MARK: - Table view data source and delegates
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].categoryName
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDishes", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DishesTableViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.categoryID = categories[indexPath.row].categoryID
        }
        
    }
    
    
}



//MARK: - CategoryManagerDelegate
extension CategoryTableViewController : CategoryManagerDelegate{
    func didUpdateData(_ categoryManager: CategoryManager, categories: [CategoryModel]) {
        self.categories = categories
        tableView.reloadData()
    }
    
    
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
    
    
}
