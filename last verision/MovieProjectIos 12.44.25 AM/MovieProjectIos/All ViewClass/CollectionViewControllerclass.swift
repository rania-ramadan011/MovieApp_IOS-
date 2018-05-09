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
//import AZDropdownMenu




private let reuseIdentifier = "Cell"



class CollectionViewControllerclass:UIViewController , UICollectionViewDataSource ,UICollectionViewDelegate{
    var arrayData3 = Array<movie>();

    @IBOutlet weak var collectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
       collectionview.delegate = self
       collectionview.dataSource = self
         
            }
    override func viewWillAppear(_ animated: Bool) {
       
        if isConnectedToInternet() {
           
            DataModel.FetchDataFromRequest(url: "http://api.themoviedb.org/3/movie/popular?api_key=06f193cdda65e217638a56f7b2649d39", completion: { (arrayData2) in
              
               self.arrayData3=arrayData2
                print("array copied")
                print(self.arrayData3.count)
                self.collectionview.reloadData();
            })
           
            
         
            
        }
        else
        {
         print("Not internet connection")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.arrayData3.count)

        return self.arrayData3.count;
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("iam in cell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as!MyCell;         print("iam in cell")
         let image_url=NSURL(string:self.arrayData3[indexPath.row].pouplar_path_image)
     
     cell.imageViewCell.sd_setImage(with: image_url as URL?, completed: nil)
       
       
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    //function to get value from website
   // func getMovies(url:String) ->Array<movie> {
    /*func getMovies()
    {
    
        let urlrequest=URL(string:"http://api.themoviedb.org/3/movie/popular?api_key=06f193cdda65e217638a56f7b2649d39")
        let request=URLRequest(url: urlrequest!)
        let session=URLSession(configuration: URLSessionConfiguration.default)
        let task=session.dataTask(with: request) { (data, response, error) in
            do{
                let json=try JSONSerialization.jsonObject(with: data!, options: .allowFragments)as! Dictionary<String,AnyObject>
            
                 print (json["result"])
                 print("json returned")
                
                //for index in 1...json.count-1
                //{
                    
                    //var dict=json[index]
                    //let objectMovie = movie()
               // }
                
            }
            catch let error
            {
                print(error)
            }
            
            
        }.resume()
        
        

    }*/
    /*func getMovies()
    {
        print("movie method")
        let url_request="http://api.themoviedb.org/3/movie/popular?api_key=06f193cdda65e217638a56f7b2649d39"
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
                        
                        movieObject.pouplar_path_image=dict["poster_path"].string!
                        movieObject.realse_date = dict["release_date"].string!
                        movieObject.movie_overview=dict["overview"].string!
                        movieObject.movie_vote_average_rate=dict["vote_average"].double!
                        
                        self.arrayData.append(movieObject)
                        print("object is addd")
                        
                        
                        
                    }
                  // completion[nil,arrayData]
                   // RequestRetryCompletion
                    
                    
                }
        }
    }*/
    //**************Function Check connection to internet
    //function to connect to internet
    func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
