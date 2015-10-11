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
    
    func sendBlobRecv(blobId: String) -> NSDictionary {
        print(blobId)
        Alamofire.request(.POST, "https://nameless-cliffs-9474.herokuapp.com/bbb", parameters: ["blob_id": blobId]).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            let resstr = NSString(data: response.data!, encoding: NSUTF8StringEncoding)
            print(resstr)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                
                print("JSON: \(JSON)")
            }
        
        }
        
    }
    
    func parseJSON(inputData: NSData) {
        let request = NSURLRequest(URL: NSURL(string: "http://bytearray.org/wp-content/projects/json/colors.json")!)
        let loader = NSURLConnection(request: request, delegate: self, startImmediately: true)

            }
}