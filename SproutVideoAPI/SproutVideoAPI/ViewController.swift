//
//  ViewController.swift
//  SproutVideoAPI
//
//  Created by Tameika Lawrence on 10/13/17.
//  Copyright © 2017 Tameika Lawrence. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var videoPreviewLayer: UIView!
    
    @IBOutlet weak var vidTitle: UILabel!
    @IBOutlet weak var vidDescription: UILabel!
    
    
    var player = AVPlayer()
    var avpController = AVPlayerViewController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseJson {
            print("parsing json")
        }
        
        
       
        
    }
  
    
    func getAPIResponse(completion: @escaping ([String: Any]?) -> Void) {
        
        // handle all the data or download tasks we give it and call our blocks with the result
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        // simplest configuration just takes a URL and defaults to the GET method
        var request = URLRequest(url: NSURL(string: "https://api.sproutvideo.com/v1/videos")! as URL)
        request.addValue("eaf946732cb7ab7dd5a07951001bc81e", forHTTPHeaderField: "SproutVideo-Api-Key")
        
        // contains the block that will fire when we get the results from the request. We’ll get back three optionals: NSData containing the raw body data from the response, an NSURLResponse object with metadata from the response and maybe an NSError.
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
//                let response = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                do {
                    let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print("👀", response as Any)
                    completion(response)
                } catch let error {
                    print(error)
                }
                
            }
        }
        
        task.resume()
        
    }
    
    func parseJson(response: () -> Void) {
        
        getAPIResponse { (answerString) in
            print("this is the string called in viewdidload: \(answerString)")
        }
    }
    
    
    
    
    

}













