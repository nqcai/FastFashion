//
//  ImageStore.swift
//  FastFashion
//
//  Created by dan on 10/10/15.
//  Copyright © 2015 Nicholas Cai. All rights reserved.
//

import Foundation
import UIKit

class ImageStore {

// MARK: Status Variables
    var uploadStarted = false
    var uploadFinished = false
    
// MARK: Authentication

// If using a SAS token, fill it in here.  If using Shared Key access, comment out the following line.
var containerURL = "https://calhacks.blob.core.windows.net/imgst"
var usingSAS = false

// If using Shared Key access, fill in your credentials here and un-comment the "UsingSAS" line:
var connectionString = "DefaultEndpointsProtocol=https;AccountName=calhacks;AccountKey=mm7EmY+T+MGahePBDSDU5LHpZR5tRXuh4MSco4jFrzHovOPEf06e18c89pxtPIo4NDVhhjSeaQY/FQmKNxjjyA=="
var containerName = "imagestore"
//var usingSAS = false

// MARK: Properties

var blobs = [AZSCloudBlob]()
var container : AZSCloudBlobContainer
var continuationToken : AZSContinuationToken?
var blobId = ""
    
// MARK: Initializers

required init?() {
    
    if (usingSAS) {
        self.container = AZSCloudBlobContainer(url: NSURL(string: containerURL)!)
    }
    else {
        let storageAccount = AZSCloudStorageAccount(fromConnectionString: connectionString)
        
        let blobClient = storageAccount.getBlobClient()
        self.container = blobClient.containerReferenceFromName(containerName)
        
        let condition = NSCondition()
        var containerCreated = false
        
        self.container.createContainerIfNotExistsWithCompletionHandler { (error : NSError?, created) -> Void in
            condition.lock()
            containerCreated = true
            condition.signal()
            condition.unlock()
        }
        
        condition.lock()
        while (!containerCreated) {
            condition.wait()
        }
        condition.unlock()
    }
    self.continuationToken = nil

    
}
    
    func uploadImage(img: UIImage) {
        var imageData = UIImagePNGRepresentation(img)
        
        let b64Encoded = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        
        self.blobId = generateName(16)
        self.uploadBlob(self.blobId, contents: b64Encoded)
    }
    
    func generateName(len: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        var randomString : NSMutableString = NSMutableString(capacity: len)
        
        for (var i=0; i < len; i++){
            var length = UInt32 (letters.length)
            var rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString as String
    }
    
    func uploadBlob(title: String, contents: String) -> String {
       
            if (!title.isEmpty)
            {
                let blob = container.blockBlobReferenceFromName(title)
                self.uploadStarted = true
                
                blob.uploadFromText(contents ?? "",  completionHandler: { (error: NSError?) -> Void in
                    self.uploadFinished = true
                    print("Upload completed")
                    
                    var fr = FetchResults()
                    
                    fr!.sendBlobRecv(self.blobId) // server starts working
                })
            }
        return self.blobId
    }
}
