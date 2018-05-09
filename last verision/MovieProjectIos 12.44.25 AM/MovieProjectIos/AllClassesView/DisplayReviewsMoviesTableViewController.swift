//
//  DisplayReviewsMoviesTableViewController.swift
//  MovieProjectIos
//
//  Created by Sayed Abdo on 4/9/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Alamofire

class DisplayReviewsMoviesTableViewController: UITableViewController {
    var allMoviesReviews  = Array<ReviewClass>();
    var movie_id_review:String=""
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(movie_id_review)
        
        tableView.delegate=self
        tableView.dataSource=self
        self.title="Reviews"
        

        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        if (CheckNetworkReachability.isConnectedToInternet() == true)
        {
        GeTAllReviews.FetchReviews(url:"https://api.themoviedb.org/3/movie/\(movie_id_review)/reviews?api_key=06f193cdda65e217638a56f7b2649d39", completion: { (allMoviesReviews2 ) in
            self.allMoviesReviews=allMoviesReviews2
            self.tableView.reloadData()
            
            
            
        });
        }
        else{
            
            let alertController = UIAlertController(title: "Alert", message:  "Check the Internet COnnection", preferredStyle: .alert)
            
            
            let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
            
            
            alertController.addAction(defaultAction)
            
            
            
             self.present(alertController, animated: true, completion: nil)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       
        return allMoviesReviews.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewcellmovie", for: indexPath)as!CustomTableCellTableViewCell

       
        cell.AuthorOult.text = allMoviesReviews[indexPath.row].AuthorName
        cell.Content.text=allMoviesReviews[indexPath.row].Content

        return cell
    }
    
    //method to height and width to row in cell
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
      return 80
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
        
    }
 

