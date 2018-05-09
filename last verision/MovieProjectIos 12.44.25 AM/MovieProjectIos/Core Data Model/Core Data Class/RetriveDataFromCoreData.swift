//
//  RetriveDataFromCoreData.swift
//  MovieProjectIos
//
//  Created by Sayed Abdo on 4/3/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import CoreData

class RetriveDataFromCoreData: NSObject {
    
    class func RetriveFromCoreData(CoreDataName:String)->Array<NSManagedObject>
    {
        var movies:Array<NSManagedObject> = Array<NSManagedObject>()
        
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:CoreDataName);
        do{
            movies = try manageContext.fetch(fetchRequest)
            
        }catch let error as NSError
        {
            print (error)
        }
        
        return movies
    }
    
    //function to cast The Retrive movies from NsMangageObject To Movie Object
    
    class func CastRetrivedMoviesObject(Arr:[NSManagedObject])->[movie]
    {
        
            var moviesCasting=[movie]();
        
            if(Arr.count > 0)
            {
                for  index in 0...Arr.count-1
                
                {
                    let movieObject = movie()
        
                    movieObject.title=Arr[index].value(forKey: "title")!as!String
                
                        movieObject.realse_date = Arr[index].value(forKey: "realse_date")as!String
                
                    movieObject.movie_vote_average_rate=Arr[index].value(forKey: "movie_vote_average_rate")as!Double
                
                    movieObject.movie_overview=Arr[index].value(forKey: "movie_overview")as!String
                
                    movieObject.pouplar_path_image=Arr[index].value(forKey: "imagepath")as!String
                    movieObject.movie_id=Int(Arr[index].value(forKey: "id")as!Int64)
                
                    moviesCasting.append(movieObject);
        
            }
        }
                    print("Data retrive Cast Object")
    
    
                
                
        
                    return moviesCasting
            
        }

    }


