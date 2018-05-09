//
//  Get Video From Request.swift
//  MovieProjectIos
//
//  Created by Sayed Abdo on 4/5/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class Get_Video_From_Request: NSObject {
    
    class func getAllVidesoToMovie(url:String , completion:@escaping (_ arrayVideoId:Array<String>)->Void)
    {
        var arrayVideoId=[String]()
       
       
        let url_request=url
        Alamofire.request(url_request, method: .get, parameters: nil, encoding:URLEncoding.default, headers: nil)
            .responseJSON{ response in
                print(response)
                switch response.result
                {
                case.failure:
                    print("error")
                    
                    
                    break
                case.success:
                    print("sucess")
                    
                    let json=JSON(response.value!)
                    var All_Values_in_json=json["results"].array
                    print(All_Values_in_json?.count)
                    //loop  to get all movies in Json Url
                
                
                    for index in 0...(All_Values_in_json?.count)!-1
                    {
                        var dict=All_Values_in_json![index]
                        print("iam in loop")
                        var video_id=dict["key"].string!
                        arrayVideoId.append(video_id)
                        
                      
                        
                    }
                
                    print ("all videso id returned video count")
                    print(arrayVideoId.count)
                    
                    completion(arrayVideoId)
                    
                    
                }
                
        }
        
        
    }
    
   
}
