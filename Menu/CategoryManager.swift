//
//  CategoryManager.swift
//  Menu
//
//  Created by Syimyk on 3/2/21.
//

import Foundation
import Alamofire
import SwiftyJSON



struct CategoryModel {
    var categoryName : String
    var categoryID : String
}


protocol CategoryManagerDelegate {
    func didUpdateData(_ categoryManager : CategoryManager, categories : [CategoryModel])
    func didFailWithError(error : Error)
}



struct CategoryManager {
    
    var delegate : CategoryManagerDelegate?
    
    let url =
        "https://deliverycarbis-test.timelysoft.org:5096/api/Restaurants/c7b1a0d1-6928-4512-f859-08d8c13995d7/menu/categories"
    
    
    func fetchCategories(){
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var arrayOfCategories = [CategoryModel]()
                
                for (_, subjson) in json["data"]["categories"]{
                    let category = subjson["name"].stringValue
                    let id = subjson["id"].stringValue
                    let newModel = CategoryModel(categoryName: category, categoryID: id)
                    arrayOfCategories.append(newModel)
                    
                }
                
                self.delegate?.didUpdateData(self, categories: arrayOfCategories)
                
                
            case .failure(let error):
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
    
    
    
}

