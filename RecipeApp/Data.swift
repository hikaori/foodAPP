//
//  Data.swift
//  RecipeApp
//
//  Created by kaori hirata on 2017-09-29.
//  Copyright © 2017 kaori hirata. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

struct Data {
    var imageURL = String()
    var title = String()
    var recipeURL = String()
    var ingredientLines = [Any]()
    
    init(WithImageURL imageURL:String, title: String, recipeURL:String,ingredientLines:[Any]) {
        self.imageURL = imageURL
        self.title = title
        self.recipeURL = recipeURL
        self.ingredientLines = ingredientLines
    }
}

struct SetData {
    static func getData() -> [Data] {
        var dataList = [Data]()
        let id : String = "6c0aca51"
        let key: String = "4e8f81930e7546f41329dba38ffda943"
        let searchWord:String = "chicken"
        
        Alamofire.request("https://api.edamam.com/search?q=\(searchWord)&app_id=\(id)&app_key=\(key)").responseJSON { response in
            
            if let value = response.result.value {
                let json = JSON(value)
                
                //Getting data from json file
                for item in json["hits"].arrayValue {
                    var imageURL:String
                    var label:String
                    var RecipeURL:String
                    var ingredientLines: [Any]
                    print(item["recipe"]["image"].stringValue)
                    imageURL = item["recipe"]["image"].stringValue
                    label    = item["recipe"]["label"].stringValue
                    RecipeURL = item["recipe"]["url"].stringValue
                    ingredientLines = item["recipe"]["ingredientLines"].arrayValue
//                    print(Data(WithImageURL: imageURL, title: label, recipeURL: RecipeURL,ingredientLines: ingredientLines))
                    dataList.append(Data(WithImageURL: imageURL, title: label, recipeURL: RecipeURL,ingredientLines: ingredientLines))
                }
            }
            print("datalistBefore:\(dataList.count)")
        }
        print("datalistAfter:\(dataList.count)")
        return dataList
    }
}

