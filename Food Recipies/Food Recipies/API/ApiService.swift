//
//  ApiService.swift
//  Food Recipies
//
//  Created by admin on 9/11/19.
//  Copyright © 2019 kero. All rights reserved.
//

import Foundation
import RxSwift
struct RecipeViewData {
    // normally it would be a mapping step but it is done here for the time being
    var imageUrl: URL?
    var sourceUrl: URL?
    var title: String?
    var source: String?
    var healthLabels: [String]?
    var ingredientLines: [String]?
}


protocol SearchApiService {
    func search( query: String, page: Int, pageSize: Int) -> Observable<[RecipeViewData]>
    
}

extension RecipeViewData : Codable{
    
}

class MockSearchApiService : SearchApiService{


    func search(query: String, page: Int, pageSize: Int) -> Observable<[RecipeViewData]> {
        
        let items = Array(getMockData().prefix(pageSize))
        return .just(items)
    }
    
    
    func getMockData() -> [RecipeViewData] {
        let jsonData = mockJsonString.data(using: .utf8)!
        var array = try! JSONDecoder().decode([RecipeViewData].self, from: jsonData)
//        print(array)
        array = array.map({ (item) -> RecipeViewData in
            var item = item
            item.ingredientLines = [ "Flour", "Milk", "Eggs" ]
            item.sourceUrl = URL(string: "http://nomnompaleo.com/post/1396914614/breakfast-dinner-tonight")
            
            item.imageUrl = URL(string:"https://ichef.bbci.co.uk/news/660/cpsprodpb/3DAD/production/_104898751_gettyimages-844466808.jpg")
            return item
        })
        return array
    }
    
    var mockJsonString = """
[
   {
      "imageUrl":"https://www.edamam.com/web-img/c24/c24cc37fca17aa896fd3aa071af91fb1.jpg",
      "title":"Chipotle Meat Loaf",
      "source":"My Recipes",
      "healthLabels":[
         "Sugar-Conscious",
         "Peanut-Free",
         "Tree-Nut-Free",
         "Alcohol-Free"
      ]
   },
   {
      "imageUrl":"https://www.edamam.com/web-img/94c/94c6856bb19ea3720e6bce0f252f6602.JPG",
      "title":"Dark Meat Turkey Panini with Montasio Cheese-Leftover Heaven",
      "source":"Food52",
      "healthLabels":[
         "Peanut-Free",
         "Tree-Nut-Free",
         "Alcohol-Free"
      ]
   },
   {
      "imageUrl":"https://www.edamam.com/web-img/229/229450fe09bb928c4df4416a219169f3",
      "title":"Cabbage Rolls with Meat Stuffing and Wild Mushroom Sauce recipes",
      "source":"Epicurious",
      "healthLabels":[
         "Peanut-Free",
         "Tree-Nut-Free"
      ]
   },
   {
      "imageUrl":"https://www.edamam.com/web-img/b8b/b8bb610672a1cf3df87b88225ea7e188.jpeg",
      "title":"Chicken Taco Meat Pizza",
      "source":"Food Network",
      "healthLabels":[
         "Peanut-Free",
         "Tree-Nut-Free",
         "Alcohol-Free"
      ]
   },
   {
      "imageUrl":"https://www.edamam.com/web-img/782/782a331e5c200b491e3021028a47e342.jpg",
      "title":"Meat Loaf",
      "source":"Men's Health",
      "healthLabels":[
         "Peanut-Free",
         "Tree-Nut-Free",
         "Alcohol-Free"
      ]
   },
   {
      "imageUrl":"https://www.edamam.com/web-img/5e3/5e324240a9e8e9087b14eec576d8cf14.jpg",
      "title":"The Best Meat Loaf",
      "source":"Delish",
      "healthLabels":[
         "Peanut-Free",
         "Tree-Nut-Free",
         "Alcohol-Free"
      ]
   },
   {
      "imageUrl":"https://www.edamam.com/web-img/b59/b59f1f19f329d554bfdc5f1469518d71.jpg",
      "title":"Meat Loaf Bolognese",
      "source":"My Recipes",
      "healthLabels":[
         "Sugar-Conscious",
         "Peanut-Free",
         "Tree-Nut-Free"
      ]
   }
]
"""
    
    
    
}

