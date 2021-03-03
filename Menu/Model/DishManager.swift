//
//  DishManager.swift
//  Menu
//
//  Created by Syimyk on 3/3/21.
//

import Foundation
import Alamofire
import SwiftyJSON

struct DishModel{
    var name : String
    var price : String
}


protocol DishManagerDelegate {
    func didUpdateDishes(_ dishManager : DishManager, dishes : [DishModel])
    func didFailWithError(error : Error)
}



struct DishManager{

    
    var delegate : DishManagerDelegate?
    
    func fetchCharacter(with id : String){
        let url = "https://deliverycarbis-test.timelysoft.org:5096/api/Restaurants/menu/categories/\(id)/items"
        performRequest(with: url)
    }
    
    
    
    
    
    func performRequest(with urlString : String){
        AF.request(urlString, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var listOfDishes = [DishModel]()
                for (_, subjson) in json["data"]["items"]{
                    let name = subjson["name"].stringValue
                    let price = subjson["price"].stringValue
                    let dish = DishModel(name: name, price: price)
                    listOfDishes.append(dish)
                }
                self.delegate?.didUpdateDishes(self, dishes: listOfDishes)
                
            case .failure(let error):
                print(error)
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
}
