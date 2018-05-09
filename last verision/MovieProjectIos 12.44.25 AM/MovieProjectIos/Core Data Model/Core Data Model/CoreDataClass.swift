//
//  CoreDataClass.swift
//  MovieProjectIos
//
//  Created by Sayed Abdo on 4/3/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import CoreData

class CoreDataClass: NSObject {
    
    class func Insert_In_Core_Data(CoreDataName:String,ArrayDataStored:Array<movie>)
    {
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        
        let movieEntity = NSEntityDescription.entity(forEntityName:CoreDataName , in:manageContext )
        
        if(ArrayDataStored.count>0)
        {
        
            for index in 0...ArrayDataStored.count-1
            {
                let movie=NSManagedObject(entity: movieEntity!,insertInto: manageContext)
            
                movie.setValue(ArrayDataStored[index].title, forKey:"title")
            
                movie.setValue(ArrayDataStored[index].realse_date, forKey:"realse_date")
            
                movie.setValue(ArrayDataStored[index].movie_vote_average_rate, forKey:"movie_vote_average_rate")
            
                movie.setValue(ArrayDataStored[index].movie_overview, forKey:"movie_overview")
            
            
                movie.setValue(ArrayDataStored[index].pouplar_path_image, forKey:"imagepath")
            
                movie.setValue(ArrayDataStored[index].movie_id, forKey: "id")
            
                print("Movie Inserted in core Data")
                do
                {
                    try manageContext.save()
                
                }catch let error as NSError{
                    
                print (error.localizedDescription)
                }
            
       
            
        }
        }
        
        
    }

}

