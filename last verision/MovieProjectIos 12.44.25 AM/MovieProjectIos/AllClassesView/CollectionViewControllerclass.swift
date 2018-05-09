//
//  CollectionViewControllerclass.swift
//  MovieProject
//
//  Created by Sayed Abdo on 3/30/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON
import SDWebImage
import Dropdowns






private let reuseIdentifier = "Cell"



class CollectionViewControllerclass:UIViewController , UICollectionViewDataSource ,UICollectionViewDelegate{
    
    //Initlization to variables
    let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0);
    let numberOfItemsPerRow : CGFloat = 2;
    var allMovieArray = Array<movie>();
    
    var moviesMangedObj:Array<NSManagedObject> = Array<NSManagedObject>()
    
    var movies:Array<movie> = Array<movie>()
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    //function view Didload
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
      
        
        if (CheckNetworkReachability.isConnectedToInternet() == true)
        {
            
               DataModelRequest.FetchDataFromRequest(url:RequestUrl.nowPlaying_movies, completion: { (arrayData2) in
                
                    self.allMovieArray=arrayData2
                    print("array copied")
                    print(self.allMovieArray.count)
                    print("Start Insert In coreData")
                    CoreDataClass.Insert_In_Core_Data(CoreDataName: "NowPlayingMovies", ArrayDataStored: arrayData2)
                    self.collectionview.reloadData();
                
            })
            
        }
        else
        {
                moviesMangedObj=RetriveDataFromCoreData.RetriveFromCoreData(CoreDataName: "NowPlayingMovies")
                allMovieArray=RetriveDataFromCoreData.CastRetrivedMoviesObject(Arr: moviesMangedObj)
                self.collectionview.reloadData();
                print(" else Not internet connection")
            
        }
        
        
       setupNavigationItem()
         
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

 

    // MARK: UICollectionViewDataSource

     func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        

        return self.allMovieArray.count;
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as!MyCell
             cell.layer.cornerRadius = 10
             cell.layer.borderWidth=2
             cell.layer.borderColor = UIColor.black.cgColor
        
         let image_url=NSURL(string:self.allMovieArray[indexPath.row].pouplar_path_image)
     
         cell.imageViewCell.sd_setImage(with: image_url as URL?, completed: nil)
       
       
    
        return cell
    }

   
    //Action to Cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
            secondViewController.movieObj = allMovieArray[indexPath.row];
            print("collectionview"+allMovieArray[indexPath.row].title)
        
            self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }

    

  
    
    
    //Setup  navigation controller
    func setupNavigationItem() {
        
        let items = ["Now Playing Movies","Popular Movies", "Top Rated Movies"]
        let titleView = TitleView(navigationController: navigationController!, title: "Now Playing Movies", items: items)
        titleView?.action = { [weak self] index in
            switch index {
            case 0:
                print("now playing case")
                
               if (CheckNetworkReachability.isConnectedToInternet() == true)
                    {
        
                        DataModelRequest.FetchDataFromRequest(url:RequestUrl.nowPlaying_movies, completion: { (arrayData2) in
                            self?.allMovieArray=arrayData2
                        
                            print(self?.allMovieArray.count)
                            print("Start Insert In coreData")
                            CoreDataClass.Insert_In_Core_Data(CoreDataName: "NowPlayingMovies", ArrayDataStored: arrayData2)
                            self?.collectionview.reloadData();
                        
                       })
                    
                    }
                    else
                    {
                        self?.moviesMangedObj=RetriveDataFromCoreData.RetriveFromCoreData(CoreDataName: "NowPlayingMovies")
                        self?.allMovieArray=RetriveDataFromCoreData.CastRetrivedMoviesObject(Arr: (self?.moviesMangedObj)!)
                            self?.collectionview.reloadData();
                            print(" else Not internet connection")
                    
                    }
                           break;
                
            case 1:
                
                    print("popular case")
                
                   if (CheckNetworkReachability.isConnectedToInternet() == true)
                    {
                        DataModelRequest.FetchDataFromRequest(url:RequestUrl.url_popular_movies, completion: { (arrayData2) in
                        
                            self?.allMovieArray=arrayData2
                        
                            CoreDataClass.Insert_In_Core_Data(CoreDataName: "PouplarMovies", ArrayDataStored: arrayData2)
                            self?.collectionview.reloadData();
                        
                    })
                    
                    
                    
                    
                    } else
                        
                   
                     {
                    self?.moviesMangedObj=RetriveDataFromCoreData.RetriveFromCoreData(CoreDataName: "PouplarMovies")
                    self?.allMovieArray=RetriveDataFromCoreData.CastRetrivedMoviesObject(Arr: (self?.moviesMangedObj)!)
                        self?.collectionview.reloadData();
                        print(" else Not internet connection")
                    
                    }
                            break;
                
                
            case 2:
                    print("top rated case")
                    
                    if (CheckNetworkReachability.isConnectedToInternet() == true)
                    {
                
                        DataModelRequest.FetchDataFromRequest(url:RequestUrl.url_rated_movie, completion: { (arrayData2) in
                        
                            self?.allMovieArray=arrayData2
                            CoreDataClass.Insert_In_Core_Data(CoreDataName: "TopRatedMovie", ArrayDataStored: arrayData2)
                            self?.collectionview.reloadData();
                        
                    })
                    
                    
                    
                    
                    }
                    else
                    {
                    self?.moviesMangedObj=RetriveDataFromCoreData.RetriveFromCoreData(CoreDataName: "TopRatedMovie")
                    self?.allMovieArray=RetriveDataFromCoreData.CastRetrivedMoviesObject(Arr: (self?.moviesMangedObj)!)
                        self?.collectionview.reloadData();
                        print(" else Not internet connection")
                    
                    }
                            break
            default:
                print("default")
                 if (CheckNetworkReachability.isConnectedToInternet() == true)
            
                    {
                        DataModelRequest.FetchDataFromRequest(url:RequestUrl.nowPlaying_movies, completion: { (arrayData2) in
                        
                            self?.allMovieArray=arrayData2
                       
                            CoreDataClass.Insert_In_Core_Data(CoreDataName: "NowPlayingMovies", ArrayDataStored: arrayData2)
                            self?.collectionview.reloadData();
                        
                    })
                }
                else
                {
                    self?.moviesMangedObj=RetriveDataFromCoreData.RetriveFromCoreData(CoreDataName: "NowPlayingMovies")
                    self?.allMovieArray=RetriveDataFromCoreData.CastRetrivedMoviesObject(Arr: (self?.moviesMangedObj)!)
                        self?.collectionview.reloadData();
                        print(" else Not internet connection")
                    
                }
                    break
                
            }
           
        }
        
        navigationItem.titleView = titleView
    }
}
// for spacingbetween cells...
extension CollectionViewControllerclass: UICollectionViewDelegateFlowLayout {
    //1
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (numberOfItemsPerRow);
        let availableWidth = view.frame.width - paddingSpace;
        let widthPerItem = availableWidth / numberOfItemsPerRow;
        
        return CGSize(width: widthPerItem, height: widthPerItem);
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets;
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left;
    }

    
    
}
