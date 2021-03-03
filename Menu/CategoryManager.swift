//
//  CategoryManager.swift
//  Menu
//
//  Created by Syimyk on 3/2/21.
//

import Foundation
import Alamofire
import SwiftyJSON



protocol CategoryManagerDelegate {
    func didUpdateData(_ categoryManager : CategoryManager, categories : [String])
    func didFailWithError(error : Error)
}



struct CategoryManager {
    
    var delegate : CategoryManagerDelegate?
    
    let url =
        "https://delivery-test.timelysoft.org:8051/api/restaurants/b91ffc3a-3f80-44f1-94a6-08d89a7c3de5/menu/categories"
    
    
    func fetchCategories(){
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var arrayOfCategories = [String]()
                
                for (_, subjson) in json["data"]["categories"]{
                    for (_, value) in subjson["categories"]{
                        let category = value["name"].stringValue
                        arrayOfCategories.append(category)
                    }
                }
                
                self.delegate?.didUpdateData(self, categories: arrayOfCategories)
                
                
            case .failure(let error):
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
    
    
    
}

