//
//  API.swift
//  SproutVideoAPI
//
//  Created by Tameika Lawrence on 10/13/17.
//  Copyright © 2017 Tameika Lawrence. All rights reserved.
//

import Foundation


    
    
    // handle all the data or download tasks we give it and call our blocks with the result
    let session = URLSession(configuration: URLSessionConfiguration.default)
    
    // simplest configuration just takes a URL and defaults to the GET method
    let request = URLRequest(url: NSURL(string: "https://api-files.sproutvideo.com/file/4c9addb31a1de4c4c4/7a801fcc936b0830/240.mp4")! as URL)
    
    // contains the block that will fire when we get the results from the request. We’ll get back three optionals: NSData containing the raw body data from the response, an NSURLResponse object with metadata from the response and maybe an NSError.
    let task = session.dataTask(with: request) { (data, response, error) in
        if let data = data {
            let response = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            print(response as Any)
        }
    }
    
    //task.resume()
    




