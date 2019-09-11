//
//  HeadingTableViewCell.swift
//  Food Recipies
//
//  Created by admin on 9/11/19.
//  Copyright © 2019 kero. All rights reserved.
//

import UIKit
import SDWebImage

class HeadingTableViewCell: UITableViewCell {

    public static let nibName = "HeadingTableViewCell"
    public static let reuseIdentifier = "id_HeadingTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var myLabel: UILabel!
    
    func updateCell(image: URL?, label: String?){
        
        myImageView.sd_setImage(with: image, completed: nil)
        myLabel.text = label
    }
}
