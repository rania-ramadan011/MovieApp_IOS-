//
//  GeTAllReviews.swift
//  MovieProjectIos
//
//  Created by Sayed Abdo on 4/9/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GeTAllReviews: NSObject {
    class func FetchReviews(url:String , completion:@escaping (_ _arrayData:Array<ReviewClass>)->Void)
    {
        print("movie method")
        var arrayData=[ReviewClass]()
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
                        let reviewsObject=ReviewClass()
                        
                        reviewsObject.AuthorName=dict["author"].string!
                        reviewsObject.Content=dict["content"].string!

                        
                        
                        arrayData.append(reviewsObject)
                        print("object is addd")
                        
                        
                        
                    
                  }
                    
                    completion(arrayData)
                    
                    
                }
                
        }
        
        
    }

}
