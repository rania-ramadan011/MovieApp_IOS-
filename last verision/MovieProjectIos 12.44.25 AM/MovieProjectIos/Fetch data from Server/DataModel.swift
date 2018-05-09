//
//  DataModel.swift
//  MovieProject
//
//  Created by Sayed Abdo on 4/1/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class DataModel: NSObject {

    
    
    class func FetchDataFromRequest(url:String , completion:@escaping (_ _arrayData:Array<movie>)->Void)
    {
        print("movie method")
       var arrayData=[movie]()
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
                        let movieObject=movie()
                        movieObject.title=dict["title"].string!
                        
                    movieObject.pouplar_path_image=RequestUrl.url_Image+dict["poster_path"].string!
                        movieObject.realse_date = dict["release_date"].string!
                        movieObject.movie_overview=dict["overview"].string!
                        movieObject.movie_vote_average_rate=dict["vote_average"].double!
                        
                      arrayData.append(movieObject)
                      print("object is addd")
                        
                        
                        
                    }
                    
                    completion(arrayData)
                   
        
                }
                
        }

   
    }
    
}
