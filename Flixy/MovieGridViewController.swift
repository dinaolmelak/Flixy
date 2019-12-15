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
    var pageNumber = 1
    var results: Int!
    var refresher: UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(getMovies), for: .valueChanged)
        collectionView.addSubview(refresher)
        collectionView.insertSubview(refresher, at: 0)
        
        getMovies()
    }
    
    @objc func getMovies(){
        pageNumber = 1
        let movieURL = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=28f10e36fa09f2d464dd184da2a57b39&language=en-US&page=\(pageNumber)")!
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
                self.results = dataDictionary["total_results"] as? Int
                // reload table view data
                
                self.collectionView.reloadData()
                self.refresher.endRefreshing()
            }
            
        }
        task.resume()
    }
    func getMoreMovies(){
        pageNumber += 1
        let movieURL = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=28f10e36fa09f2d464dd184da2a57b39&language=en-US&page=\(pageNumber)")!
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
                self.movies  += dataDictionary["results"] as! [[String:Any]]
                print(self.movies)
                // reload table view data
                
                //self.collectionView.reloadData()
            }
            
        }
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.item + 1 == movies.count) && (movies.count < self.results) {
            //getMoreMovies()
            print("got more Heroes!...")
        }else{
            print("go Down")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        let movie = movies[indexPath.item]
        let baseUrl = "https://image.tmdb.org/t/p/w342"
        if let posterPath = movie["poster_path"] as? String {
            let posterURL = URL(string: baseUrl + posterPath)!
            cell.posterImageView.af_setImage(withURL: posterURL)
        } else{
            cell.posterImageView.image = UIImage(named: "Ice")
        }
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
