//
//  EdmamSearchApi.swift
//  Food Recipies
//
//  Created by admin on 9/11/19.
//  Copyright © 2019 kero. All rights reserved.
//

import Foundation
import RxSwift

class EdmamSearchApi: SearchApiService  {

    
    
    
    func search(query: String, page: Int, pageSize: Int) -> Observable<[RecipeViewData]> {
        
        let from = page * pageSize
        return search(query: query, from: from, pageSize: pageSize).map({ (input) -> [RecipeViewData] in
            return input ?? []
        })
        
    }

    private static let utilityQueue = DispatchQueue.global(qos: .utility)


// my plan
// https://api.edamam.com/search?q=chicken&from=0&to=100&app_id=ec100871&app_key=2edb933daf51f1726c94e12dd5f4db7f
// their plan //https://api.edamam.com/search?q=chicken&app_id=89193820&app_key=b0c4f8afaa13f79ee3219775e0d90d23

    let baseURL = "https://api.edamam.com"
    //search//" //?
    let id = "ec100871"
    let key = "2edb933daf51f1726c94e12dd5f4db7f" //&q=chicken /

    func search(query: String, from: Int, pageSize: Int) -> Observable<[RecipeViewData]?> {
        let publishSubject = PublishSubject<[RecipeViewData]?>()
        
        var components = URLComponents(string: baseURL + "/" + "search" )
        
        //        components?.path = "search"
        components?.queryItems = [URLQueryItem(name: "app_id", value: id),
                                  URLQueryItem(name: "app_key", value: key),
                                  URLQueryItem(name: "q", value: query),
                                  URLQueryItem(name: "from", value: "\(from)"),
                                  URLQueryItem(name: "to", value: "\( from + pageSize)")]
        
        
        
        Provider.sessionManager.request( (components?.url)!).responseJSON(queue: EdmamSearchApi.utilityQueue) { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            print("requesting url")
            print(components?.url ?? "nil")
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                let val = EdmamSearchApi.getMappedResponse(json: json as? [String : Any])
                publishSubject.onNext( val )
                publishSubject.onCompleted()
                return
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
            
            
            publishSubject.onError((response.error ?? nil)!)
        }
        
        return publishSubject.asObservable()
    }
    
    private static func getMappedResponse(json: [String: Any]?) -> [RecipeViewData]?{
        guard let hits = json?["hits"] as? [[String:Any]]
        else {
            return nil
        }
        let mapped = hits.map { (dict) -> RecipeViewData in
            let recipe = dict["recipe"] as! [String: Any]
            let mappedRecipe = RecipeViewData(imageUrl: URL(string: recipe["image"] as? String ?? ""),
                           sourceUrl: URL(string: recipe["url"] as? String ?? ""),
                           title: recipe["label"] as? String,
                           source: recipe["label"] as? String,
                           healthLabels: recipe["healthLabels"] as? [String],
                           ingredientLines: recipe["ingredientLines"] as? [String])
            return mappedRecipe
        }
        
        return mapped
    }


}




/*
 
 sample
 
 "hits": [
 {
 "recipe": {
 "uri": "http://www.edamam.com/ontologies/edamam.owl#recipe_4a13fb7f35ec1e82ac8f12532ac4eee9",
 "label": "Spinach Meat Stew",
 "image": "https://www.edamam.com/web-img/76c/76c416a0011f31c094566bf2a30555ab.jpg",
 "source": "PBS Food",
 "url": "http://www.pbs.org/food/recipes/spinach-meat-stew/",
 "shareAs": "http://www.edamam.com/recipe/spinach-meat-stew-4a13fb7f35ec1e82ac8f12532ac4eee9/meat",
 "yield": 6.0,
 "dietLabels": [
 "Low-Carb"
 ],
 "healthLabels": [
 "Sugar-Conscious",
 "Peanut-Free",
 "Tree-Nut-Free",
 "Alcohol-Free"
 ],
 "cautions": [],
 "ingredientLines": [
 "10 oz chopped spinach",
 "1 red bell pepper",
 "1 or more jamaican red peppers",
 "1 ripe tomato",
 "3 tablespoons vegetable oil",
 "1 ib boneless beef",
 "1 whiting fish"
 ],
 
 
 
 
 
*/
