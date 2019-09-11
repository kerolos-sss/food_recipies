//
//  PecipePreviewTableViewCell.swift
//  RecipeSearch
//
//  Created by kero1 on 9/4/18.
//  Copyright © 2018 kero.dev. All rights reserved.
//

import UIKit
import SDWebImage

class RecipePreviewTableViewCell: UITableViewCell {

    public static let nibName = "RecipePreviewTableViewCell"
    public static let reuseIdentifier = "id_RecipePreviewTableViewCel"
    
    @IBOutlet weak var publisherLabel: UILabel!
    
    @IBOutlet weak var recipeTitleLabel: UILabel!
    
    @IBOutlet weak var healthLabelsStack: UIStackView!
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var ratingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        
    }

    func updateCell(item: RecipeViewData){
        
        self.recipeImage?.sd_setImage(with: item.imageUrl, completed: nil)
        self.publisherLabel.text = item.source
        self.recipeTitleLabel.text = item.title
        self.healthLabelsStack.arrangedSubviews.forEach({ $0.removeFromSuperview()})
        self.healthLabelsStack.subviews.forEach({ $0.removeFromSuperview()})
        
        item.healthLabels?.forEach({ (tag) in
            let l = UILabel();
            l.text = tag
            l.lineBreakMode = .byWordWrapping
            l.numberOfLines = 0
            
            self.healthLabelsStack.addArrangedSubview(l)
        })
        
        
    }
    
    
}
