//
//  DetailsViewController.swift
//  Food Recipies
//
//  Created by admin on 9/11/19.
//  Copyright © 2019 kero. All rights reserved.
//

import UIKit
import SafariServices

extension DetailsViewController: DataReceiver{
    func setData(_ data: Any) {
        recipe = data as? RecipeViewData
    }
    
    
}
/*
 Details:
 a. When I select one recipe (row) a new screen should appear showing the following recipe details:
     i. Recipe’s image ii. Recipe title
     iii. Recipe ingredients each on a separate line. “ingredientLines”
     iv. Link to the recipe from the publisher’s website “url” .
 b. When I click on the publisher’s website link , the web page should open in a
 ‘SFSafariViewController’.
 */

class DetailsViewController: UIViewController {
    var recipe: RecipeViewData!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibH = UINib(nibName: HeadingTableViewCell.nibName, bundle: nil)
        tableView.register( nibH, forCellReuseIdentifier:HeadingTableViewCell.reuseIdentifier )
        
        
        let nibI = UINib(nibName: IngredientTableViewCell.nibName, bundle: nil)
        tableView.register( nibI, forCellReuseIdentifier:IngredientTableViewCell.reuseIdentifier )

        
        tableView.dataSource = self
        tableView.delegate = self
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension DetailsViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // heading tile
            return 1
        }
        if section == 2{
            // footing tile
            return 1
        }
        return recipe.ingredientLines?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // heading
            let cell = tableView.dequeueReusableCell(withIdentifier: HeadingTableViewCell.reuseIdentifier) as! HeadingTableViewCell
            
            cell.updateCell(image: self.recipe.imageUrl, label: recipe.title)
            
            return cell
            
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: IngredientTableViewCell.reuseIdentifier) as! IngredientTableViewCell
        // this could be made once only
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        
        
        if indexPath.section == 2 {
            
            cell.textLabel?.text = recipe.source
            cell.textLabel?.textColor = .blue
            
            return cell
        }
        cell.textLabel?.textColor = .black
        cell.textLabel?.text = recipe.ingredientLines?[indexPath.item]
        
        
        // ingredient
 


        
        
        return cell
    }
    
    
}

extension DetailsViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 2{
            guard let url = recipe.sourceUrl else { return }
            let svc = SFSafariViewController(url: url)
            self.present(svc, animated: true, completion: nil)
            
        }
    }
}
