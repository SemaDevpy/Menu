//
//  DishesViewController.swift
//  Menu
//
//  Created by Syimyk on 3/4/21.
//

import UIKit

class DishesViewController: UIViewController, DishManagerDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
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
        tableView.dataSource = self
        
    }
    
    // MARK: - Table view data source
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
