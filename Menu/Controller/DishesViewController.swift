//
//  DishesViewController.swift
//  Menu
//
//  Created by Syimyk on 3/4/21.
//

import UIKit

class DishesViewController: UIViewController, DishManagerDelegate , UITabBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabBar: UITabBar!
    

        
        
        
    var dishManger = DishManager()
    var dishes = [DishModel]()
    var categoryID = ""
    var category = ""
    var dishesInCart : [DishModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dishManger.delegate = self
        dishManger.fetchCharacter(with: categoryID)
        navigationItem.backButtonTitle = ""
        title = category
        tableView.dataSource = self
        tableView.delegate = self
        tabBar.delegate = self
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


// MARK: - Table view data source
extension DishesViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        cell.textLabel?.text = dishes[indexPath.row].name
        cell.detailTextLabel?.text = "\(dishes[indexPath.row].price)c"
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dishesInCart.append(dishes[indexPath.row])
        tabBar.items?.first?.badgeValue = "\(dishesInCart.count)"
    }
}
