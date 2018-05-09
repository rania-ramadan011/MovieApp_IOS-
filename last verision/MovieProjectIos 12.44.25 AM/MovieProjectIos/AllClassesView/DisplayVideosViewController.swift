//
//  DisplayVideosViewController.swift
//  MovieProjectIos
//
//  Created by Sayed Abdo on 4/8/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Alamofire

class DisplayVideosViewController: UIViewController {
    
    
    @IBOutlet weak var videoWebView: UIWebView!
    var video_id:String=""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title="Play Videos"
        if(CheckNetworkReachability.isConnectedToInternet() == true)
        {
        
        getVideo(video_code: video_id)
        }
        else{
            
            let alertController = UIAlertController(title: "Alert", message:  "Check the Internet COnnection", preferredStyle: .alert)
            
            
            let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
            
            
             alertController.addAction(defaultAction)
            
            
            
            self.present(alertController, animated: true, completion: nil)
            
        }
      

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getVideo(video_code:String)
    {
        let url=URL(string:"https://www.youtube.com/embed/\(video_code)")
        print(url!)
        videoWebView.loadRequest(URLRequest(url:url!))
    }
    
    
    

}

