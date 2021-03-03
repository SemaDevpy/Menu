//
//  DishesTableViewController.swift
//  Menu
//
//  Created by Syimyk on 3/3/21.
//

import UIKit

class DishesTableViewController: UITableViewController, DishManagerDelegate {
    
    
   
    

    var dishManger = DishManager()
    var dishes = [DishModel]()
    var categoryID = ""
    var category = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dishManger.delegate = self
        dishManger.fetchCharacter(with: categoryID)
        navigationItem.backButtonTitle = ""
        title = category
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dishes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        cell.textLabel?.text = dishes[indexPath.row].name
        cell.detailTextLabel?.text = "\(dishes[indexPath.row].price)c"  
        return cell
    }
    
//MARK: - DishManager Delegate
    
    
    func didUpdateDishes(_ dishManager: DishManager, dishes: [DishModel]) {
            self.dishes = dishes
            tableView.reloadData()
        
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
    

}
