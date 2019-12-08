//
//  MovieGridViewController.swift
//  Flixy
//
//  Created by Dinaol Melak on 12/6/19.
//  Copyright © 2019 Dinaol Melak. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    var movies = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        let movieURL = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=28f10e36fa09f2d464dd184da2a57b39&language=en-US&page=1")!
        let request = URLRequest(url: movieURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request){(data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                // get the array of movies
            
                //print(dataDictionary)
                // store the movies in a property to be used else where
                self.movies  = dataDictionary["results"] as! [[String:Any]]
                // reload table view data
                
                self.collectionView.reloadData()
            }
            
        }
        task.resume()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        let movie = movies[indexPath.item]
        let baseUrl = "https://image.tmdb.org/t/p/w342"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseUrl + posterPath)!
        
        cell.posterImageView.af_setImage(withURL: posterURL)
        
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let collectionViewCell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: collectionViewCell)!
        let movie = movies[indexPath.item]
        
        //print(movie["overview"] as! String)
        
        let detailSegue = segue.destination as! DetailViewController
        detailSegue.movie = movie
    }
    

}
