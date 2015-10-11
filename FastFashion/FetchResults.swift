//
//  FetchResults.swift
//  FastFashion
//
//  Created by dan on 10/10/15.
//  Copyright © 2015 Nicholas Cai. All rights reserved.
//

import Foundation
import Alamofire

class FetchResults {
    
    init?() {
        
    }

    func getResults(istore: ImageStore) {
        if (!istore.uploadStarted) {
            return
        }
    }
    
    func sendBlobRecv(blobId: String) {
        print(blobId)
        
        Alamofire.request(.GET, "http://httpbin.org/get", parameters: ["foo": "bar"])
            .responseJSON { response in
                print(response)
        }
        
    }
    
    func parseJSON(inputData: NSData) {
        let request = NSURLRequest(URL: NSURL(string: "http://bytearray.org/wp-content/projects/json/colors.json")!)
        let loader = NSURLConnection(request: request, delegate: self, startImmediately: true)

            }
}