//
//  FavouriteMoviesViewController.swift
//  MovieProjectIos
//
//  Created by Sayed Abdo on 4/9/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage

class FavouriteMoviesViewController:UIViewController,UICollectionViewDataSource ,UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var allFavouriteMovies:[movie]=[];
    
    var moviesMangedObj:Array<NSManagedObject> = Array<NSManagedObject>();
    let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0);
    let numberOfItemsPerRow : CGFloat = 2;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allFavouriteMovies = Array<movie>();
             collectionView.dataSource=self
             collectionView.delegate=self
             self.title="Favourites Movies"
    }

    override func viewWillAppear(_ animated: Bool) {
        
        moviesMangedObj=RetriveDataFromCoreData.RetriveFromCoreData(CoreDataName: "FavouritesMovie")
        if(moviesMangedObj.count>0)
        {
         allFavouriteMovies=RetriveDataFromCoreData.CastRetrivedMoviesObject(Arr: moviesMangedObj)
        
            collectionView.reloadData()
        }
        else{
            print("No Movies Found")
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return allFavouriteMovies.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cellfav", for: indexPath) as!MyCell
    
        
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth=2
        cell.layer.borderColor = UIColor.black.cgColor
        let image_url=NSURL(string:self.allFavouriteMovies[indexPath.row].pouplar_path_image)
          print(image_url)
        
        cell.imageViewFavourite.sd_setImage(with: image_url as URL?, completed: nil)
        
        
        
        return cell
    }
    

}
// for spacingbetween cells...
extension FavouriteMoviesViewController: UICollectionViewDelegateFlowLayout {
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
