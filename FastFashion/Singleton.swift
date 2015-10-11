//
//  Singleton.swift
//  FastFashion
//
//  Created by Clifford Lee on 10/11/15.
//  Copyright © 2015 Nicholas Cai. All rights reserved.
//

import Foundation

private let _sharedInstance = Singleton()
class Singleton {
    private init() {

    }
    class var sharedInstance: Singleton {
        return _sharedInstance
    }
    
    var mealDictionary:NSDictionary?
}
