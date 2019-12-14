//
//  MoviesViewController.swift
//  Flixy
//
//  Created by Dinaol Melak on 11/28/19.
//  Copyright © 2019 Dinaol Melak. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var movies = [[String:Any]]()
    var pageNumber = 1
    var refresher: UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        refresher = UIRefreshControl()
        self.refresher.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        self.tableView.addSubview(refresher)
        tableView.insertSubview(refresher, at: 0)
        
        getMovies()

    }
    @objc func onRefresh(){
        
        getMovies()
        print("Refresh")
        refresher.endRefreshing()
    }
    func getMovies(){
        pageNumber = 1
        let movieURL = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=28f10e36fa09f2d464dd184da2a57b39&language=en-US&page=\(pageNumber)")!
        let request = URLRequest(url: movieURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request){(data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                // get the array of movies
                // store the movies in a property to be used else where
                self.movies  = dataDictionary["results"] as! [[String:Any]]
                
                // reload table view data
                self.tableView.reloadData()
            }
            
        }
        task.resume()
    }
    func getMoreMovies(){
        pageNumber += 1
        let movieURL = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=28f10e36fa09f2d464dd184da2a57b39&language=en-US&page=\(pageNumber)")!
        let request = URLRequest(url: movieURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request){(data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                // get the array of movies
                // store the movies in a property to be used else where
                self.movies += dataDictionary["results"] as! [[String:Any]]
                
                // reload table view data
                self.tableView.reloadData()
            }
            
        }
        task.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        //get the movie title and description
        let movie = movies[indexPath.row]
        let movieTitle = movie["title"] as! String
        let movieCaption = movie["overview"] as! String
        
        cell.movieTitleLabel.text = movieTitle
        cell.movieDescriptionLabel.text = movieCaption
        // get the movie poster
        let baseUrl = "https://image.tmdb.org/t/p/w342"
        if let posterPath = movie["poster_path"] as? String{
            let posterURL = URL(string: baseUrl + posterPath)!
            cell.movieImageView.af_setImage(withURL: posterURL)
        } else{
            cell.movieImageView.image = #imageLiteral(resourceName: "Ice")
        }
        
        
        
        
        
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //print("here")
        if(indexPath.row + 1 == movies.count ){
            getMoreMovies()
            print("Got it!...")
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("This row is selected \(indexPath.row)")
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let tableViewCell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: tableViewCell)!
        let movie = movies[indexPath.row]
        print(movie["overview"] as! String)
        
        let detailSegue = segue.destination as! DetailViewController
        detailSegue.movie = movie
        
        tableView.deselectRow(at: indexPath, animated: false)
        print("loading")
    }
    

}
