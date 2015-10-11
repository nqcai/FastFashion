//
//  FetchResults.swift
//  FastFashion
//
//  Created by dan on 10/10/15.
//  Copyright © 2015 Nicholas Cai. All rights reserved.
//

import Foundation

class FetchResults {
    
    init?() {
        
    }

    func getResults(istore: ImageStore) {
        if (!istore.uploadStarted) {
            return
        }
        while (!istore.uploadFinished) {
            NSTimer.
        }
    }
    func getJSON(urlToRequest: String) -> NSData{
        return NSData(contentsOfURL: NSURL(string: urlToRequest))
    }
    
    func parseJSON(inputData: NSData) -> NSDictionary{
        var error: NSError?
        var boardsDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
        
        return boardsDictionary
    }
}