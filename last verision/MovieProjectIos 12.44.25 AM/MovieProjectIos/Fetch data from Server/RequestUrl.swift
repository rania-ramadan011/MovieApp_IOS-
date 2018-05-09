//
//  RequestUrl.swift
//  MovieProject
//
//  Created by Sayed Abdo on 4/1/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit

class RequestUrl: NSObject {
    
 static var url_popular_movies:String="http://api.themoviedb.org/3/movie/popular?api_key=06f193cdda65e217638a56f7b2649d39"
    
 static var url_Image="http://image.tmdb.org/t/p/w185/"
    
 static var nowPlaying_movies:String="https://api.themoviedb.org/3/movie/now_playing?api_key=06f193cdda65e217638a56f7b2649d39"
    
 static  var url_rated_movie:String="http://api.themoviedb.org/3/discover/movie?sort_by=higestrated.%20desc&api_key=06f193cdda65e217638a56f7b2649d39"
    
static var movie_id=""
    
static var movie_videos="https://api.themoviedb.org/3/movie/"

static var key="?api_key=06f193cdda65e217638a56f7b2649d39"
    
static var All_Videso_Url=movie_videos+movie_id+"/videos"+key
    
//static var ALLreviews_url = movie_videos+movie_id+"/reviews"+key
    
 static var ALLreviews_url="https://api.themoviedb.org/3/movie/\(movie_id)/reviews?api_key=06f193cdda65e217638a56f7b2649d39"
    
    
    
    
  
    
    

}
