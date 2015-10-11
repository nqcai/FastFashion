//
//  RecipeTableViewCell.swift
//  FastFashion
//
//  Created by Nicholas Cai on 10/10/15.
//  Copyright © 2015 Nicholas Cai. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    // MARK: Properties

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
//    @IBOutlet weak var ratingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        print("Touched Cell View")
//    }

}
