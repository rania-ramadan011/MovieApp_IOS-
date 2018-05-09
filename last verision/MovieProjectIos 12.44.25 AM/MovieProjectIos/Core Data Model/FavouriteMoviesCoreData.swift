//
//  FavouriteMoviesCoreData.swift
//  MovieProjectIos
//
//  Created by Sayed Abdo on 4/11/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import CoreData

class FavouriteMoviesCoreData: NSObject {
    
    
    class func Insert_In_Core_Data(CoreDataName:String,MovieObject:movie)
    {
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        
        let movieEntity = NSEntityDescription.entity(forEntityName:CoreDataName , in:manageContext )
        
        
        
            let movie=NSManagedObject(entity: movieEntity!,insertInto: manageContext)
            
            movie.setValue(MovieObject.title, forKey:"title")
            
            movie.setValue(MovieObject.realse_date, forKey:"realse_date")
            
            movie.setValue(MovieObject.movie_vote_average_rate, forKey:"movie_vote_average_rate")
            
            movie.setValue(MovieObject.movie_overview, forKey:"movie_overview")
            
            
            movie.setValue(MovieObject.pouplar_path_image, forKey:"imagepath")
        
            movie.setValue(MovieObject.movie_id, forKey: "id")
            
            print("Movie object add in core Data")
            do
            {
                try manageContext.save()
                
            }catch let error as NSError{
                print (error.localizedDescription)
            }
            
            
            
        }
    //Delete From core Data
    class func Delete_Movie_Core_Data(MovieObject:movie)
    {
        var moviesMangedObj:Array<NSManagedObject> = Array<NSManagedObject>();
        
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        let movieEntity = NSEntityDescription.entity(forEntityName:"FavouritesMovie" , in:manageContext )
        
       moviesMangedObj = RetriveDataFromCoreData.RetriveFromCoreData(CoreDataName: "FavouritesMovie")
        if(moviesMangedObj.count > 0)
        {
        
            for index in 0...moviesMangedObj.count-1
            {
                let id:Int = (moviesMangedObj[index].value(forKey: "id") as! Int);
                
                if( id == MovieObject.movie_id)
                {
                    manageContext.delete(moviesMangedObj[index])
                    print("Delete Object Suceess")
                    break
                }
            
            }
            
        }
        
         
        
        do
        {
            try manageContext.save()
            
        }catch let error as NSError{
            print (error.localizedDescription)
        }
        
        
        
        
    }
    
}




