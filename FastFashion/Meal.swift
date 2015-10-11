//
//  Meal.swift
//  FastFashion
//
//  Created by Nicholas Cai on 10/10/15.
//  Copyright © 2015 Nicholas Cai. All rights reserved.
//

import UIKit

class Meal {
    
    // MARK: Properties
    
    var name: String = ""
    var photo: UIImage?
    var rating: Int = 0
    var recipe: [String]
    
    
    
    // MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int, recipe: [String]) {
        self.name = name
        self.photo = photo
        self.rating = rating
        self.recipe = recipe
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0 || recipe.isEmpty {
            return nil
        }
    }
    
}

