//
//  CheckNetworkReachability.swift
//  MovieProjectIos
//
//  Created by Sayed Abdo on 4/12/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Alamofire

class CheckNetworkReachability: NSObject {
    
    class func isConnectedToInternet() ->Bool
    {
        return NetworkReachabilityManager()!.isReachable
    }
    
   

   
}
