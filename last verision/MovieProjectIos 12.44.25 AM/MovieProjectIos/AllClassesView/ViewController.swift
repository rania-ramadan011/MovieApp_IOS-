//
//  ViewController.swift
//  MovieProject
//
//  Created by Sayed Abdo on 3/30/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import CoreData

class ViewController:UIViewController ,UITableViewDataSource,UITableViewDelegate {
    
    // IBOulet from labels
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var MyTableView: UITableView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var RealseData: UILabel!
    @IBOutlet weak var movierating: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var fav: UIButton!
    
    // intilzation to variables
    var movieObj=movie()
    var Array_video_id_All=[String]()
    let cellSpacingHeight: CGFloat = 5
    static var doubleTap: Bool!
    static var checkElement: Bool!
    var  AllFavouitesMovieArray :[movie]=[]
    var moviesMangedObj:Array<NSManagedObject> = Array<NSManagedObject>();
    
    //Action to Buttons
    @IBAction func reviwButton(_ sender: Any)
    {
        
        let DisplayReviewsMoviesTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "DisplayReviewsMoviesTableViewController") as! DisplayReviewsMoviesTableViewController
        DisplayReviewsMoviesTableViewController.movie_id_review=String(movieObj.movie_id)
        
        self.navigationController?.pushViewController(DisplayReviewsMoviesTableViewController, animated: true)
        
        
    }
    //favourites Button
    @IBAction func FavouritesMovieButton(_ sender: Any) {
        
        if (ViewController.doubleTap)
        {
            
            //Second click
            print("Second click")
            FavouriteMoviesCoreData.Delete_Movie_Core_Data(MovieObject: movieObj)
                ViewController.doubleTap = false
            let btnImage = UIImage(named:"StarIconGold.png")
            fav.setImage(btnImage , for: UIControlState.normal)
            
        } else {
            
            //First click
            
            print("first click")
            moviesMangedObj = RetriveDataFromCoreData.RetriveFromCoreData(CoreDataName: "FavouritesMovie")
            
            
            if(moviesMangedObj.count > 0)
            
            {
                
                AllFavouitesMovieArray=RetriveDataFromCoreData.CastRetrivedMoviesObject(Arr:  moviesMangedObj)
                print("AllFavouitesMovieArray\(AllFavouitesMovieArray.count)")
                
            
                for index in 0...AllFavouitesMovieArray.count-1
                    
                {
                    
                    if(movieObj.movie_id == AllFavouitesMovieArray[index].movie_id)
                    {
                        
                        print("movie is exist")
                        
                        ViewController.checkElement=true
                        break
                        
                    }
                    else
                    {
                        
                           continue
                        
                       
                    }
                }
                if(ViewController.checkElement==false)
                {
                   FavouriteMoviesCoreData.Insert_In_Core_Data(CoreDataName:"FavouritesMovie", MovieObject: movieObj)
                       print("insert object to view")
                    let btnImage = UIImage(named:"Star.png")
                    fav.setImage(btnImage , for: UIControlState.normal)
                    
                }
                
            }else{
                
                        
            
                FavouriteMoviesCoreData.Insert_In_Core_Data(CoreDataName:"FavouritesMovie", MovieObject: movieObj)
                    let btnImage = UIImage(named:"Start.png")
                    fav.setImage(btnImage , for: UIControlState.normal)
                
                    print("First time insert")
            }
            
            ViewController.doubleTap = true
            
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AllFavouitesMovieArray =  Array<movie>();
        ViewController.doubleTap  = false
        ViewController.checkElement=false
        self.movieTitle.text = movieObj.title
        
        
        self.RealseData.text=movieObj.realse_date
        self.movierating.text=String(movieObj.movie_vote_average_rate)
        self.overview.text=movieObj.movie_overview
        let image_url=NSURL(string:movieObj.pouplar_path_image)
        self.movieImage.sd_setImage(with:image_url as! URL, completed: nil)
        self.movieImage.layer.borderColor=UIColor.black.cgColor
        self.movieImage.layer.cornerRadius = 10
        self.movieImage.layer.borderWidth  = 2
        self.title="Movie Details"
        if (CheckNetworkReachability.isConnectedToInternet() == false)
        {
        
        
            let alertController = UIAlertController(title: "Alert", message:  "No Vidoes Beacuse No Internet Connection", preferredStyle: .alert)
            
            
            let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
            
            
            alertController.addAction(defaultAction)
            
            
            
            self.present(alertController, animated: true, completion: nil)
        
        }
       
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        print(Array_video_id_All.count)
        return Array_video_id_All.count
    }

    //function view will load
    override func viewWillAppear(_ animated: Bool) {
       
        
        
        RequestUrl.movie_id = String(movieObj.movie_id)
        print("movie id review test")
        if(CheckNetworkReachability.isConnectedToInternet()==true)
        {
        
        Get_Video_From_Request.getAllVidesoToMovie(url:"https://api.themoviedb.org/3/movie/\(movieObj.movie_id)/videos?api_key=06f193cdda65e217638a56f7b2649d39") { (Array_video_id) in
            print(Array_video_id.count)
            
            self.Array_video_id_All=Array_video_id
            self.MyTableView.reloadData();
            print("sucess videos id")
            }
            
        }
        

    }
    
    

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
     
         var counter=indexPath.row+1
        cell.textLabel?.text = "Trailer"+String(counter)
        return cell
     }
 
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     print("cell is selecting")
        let DisplayVideosViewController  = self.storyboard?.instantiateViewController(withIdentifier: "DisplayVideosViewController") as! DisplayVideosViewController
        
        DisplayVideosViewController.video_id = Array_video_id_All[indexPath.row]
        
        print(Array_video_id_All[indexPath.row])
        self.navigationController?.pushViewController(DisplayVideosViewController, animated: true)
        
    }
   
    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
}

