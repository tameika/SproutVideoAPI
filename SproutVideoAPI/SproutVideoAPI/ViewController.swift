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
    
    
    @IBOutlet weak var vidTitle: UILabel!
    @IBOutlet weak var vidDescription: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createVideo()
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
    
    
    func parseJson(answer: () -> Void) {
        
        getAPIResponse { (answerString) in
            print("this is the string called in viewdidload: \(String(describing: answerString))")
            guard let response = answerString else { print("unwrapping response failed"); return }
            guard let videos = response["videos"] as? [String: Any] else { return }
            for (_, _) in videos {
                guard let videoTitle = videos["title"] as? String else { return }
                guard let videoDescription = videos["description"] as? String else { return }
                self.vidTitle.text = videoTitle
                self.vidDescription.text = videoDescription
            }
        }
        print("🌶 outside api func")
    }
    
    
    func createVideo() {
        
        let chloe = NSURL(string: "https://api-files.sproutvideo.com/file/4c9addb31a1de4c4c4/7a801fcc936b0830/240.mp4")
        let player = AVPlayer(url:  chloe! as URL)
        let playerLayer = AVPlayerLayer()
        playerLayer.player = player
        playerLayer.frame = CGRect(x: 0.0, y: 0.0, width: 300.0, height: 300.0)
        playerLayer.frame = self.view.bounds
        playerLayer.backgroundColor = UIColor.lightGray.cgColor
        view.layer.addSublayer(playerLayer)
        player.play()
        player.allowsExternalPlayback = true
    }
    
}


















