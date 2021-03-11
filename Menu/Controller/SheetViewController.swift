//
//  SheetViewController.swift
//  Menu
//
//  Created by Syimyk on 3/5/21.
//

import UIKit

class SheetViewController: UIViewController {

    @IBOutlet weak var dish: UILabel!
    @IBOutlet weak var price: UILabel!
    
    private let dishModel : DishModel
    
    
    init(dish : DishModel) {
        self.dishModel = dish
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dish.text = dishModel.name
        price.text = "\(dishModel.price)c" 
    }

    
   
    
    
    @IBAction func addToCartPressed(_ sender: UIButton) {
//        NotificationCenter.default.post(name: Notification.Name("dish"), object: dishModel)
        dismiss(animated: true, completion: nil)
    }
    
}
