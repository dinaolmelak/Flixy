//
//  DetailViewController.swift
//  Flixy
//
//  Created by Dinaol Melak on 12/2/19.
//  Copyright © 2019 Dinaol Melak. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    var movie: [String: Any]!
    var movieID = Int()
    var similarMovies = [[String: Any]]()
//    @IBOutlet weak var backgroundPosterImageView: UIImageView! // found in BGcell
//    @IBOutlet weak var posterImageView: UIImageView!  -|-> found in DetailCell
//    @IBOutlet weak var movieTitleLabel: UILabel!       |
//    @IBOutlet weak var movieOverviewLabel: UILabel!    |
//    @IBOutlet weak var movieDateLabel: UILabel!       _|
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // get the label
        //print(movie)
        tableView.delegate = self
        tableView.dataSource = self
        movieID = self.movie["id"] as! Int
        getSimilarMovies()
        
    }
    
    func movieDetail(){
//        movieOverviewLabel.text = movie["overview"] as? String
//        movieTitleLabel.text = movie["title"] as? String
//        movieDateLabel.text = movie["release_date"] as? String
//        // get the image
//        let baseUrl = "https://image.tmdb.org/t/p/w342"
//        if let posterPath = movie["poster_path"] as? String{
//            let posterURL = URL(string: baseUrl + posterPath)!
//            posterImageView.af_setImage(withURL: posterURL)
//        } else{
//            posterImageView.image =  UIImage(named: "Ice")
//        }
//
//        if let backdropPath = movie["backdrop_path"] as? String{
//            let backdropPosterURL = URL(string: "https://image.tmdb.org/t/p/w1280" + backdropPath)!
//            backgroundPosterImageView.af_setImage(withURL: backdropPosterURL)
//        } else{
//            backgroundPosterImageView.image =  UIImage(named: "Ice")
//        }
    }
    func getSimilarMovies(){
        let movieURL = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/similar?api_key=28f10e36fa09f2d464dd184da2a57b39&language=en-US&page=1")!
        let request = URLRequest(url: movieURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request){(data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                // get the array of movies
                // store the movies in a property to be used else where
                self.similarMovies  = dataDictionary["results"] as! [[String:Any]]
                // reload table view data
                
                self.tableView.reloadData()
                
            }
            
        }
        task.resume()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
////        posterImageView.alpha = 0.3
////        self.movieOverviewLabel.alpha = 0.3
////        self.movieDateLabel.alpha = 0.3
//    }
    
    func startUpAnimation(){
//        UIView.animate(withDuration: 2) {
//            self.posterImageView.alpha = 1.0
//        }
//        UIView.animate(withDuration: 1, animations: {
//            self.movieTitleLabel.center.y += 10.0
//        }) { (Bool) in
//            UIView.animate(withDuration: 1) {
//                self.movieTitleLabel.center.y -= 10.0
//            }
//        }
//        UIView.animate(withDuration: 2) {
//            self.movieOverviewLabel.alpha = 1.0
//            self.movieDateLabel.alpha = 1.0
//        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return similarMovies.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let baseUrl = "https://image.tmdb.org/t/p/w342"
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BGImageCell", for: indexPath) as! BGImageCell
            cell.movieTitleLabel.text = movie["title"] as? String
            cell.movieReleaseDateLabel.text = movie["release_date"] as? String
            cell.movieDescription.text = movie["overview"] as? String
            
            if let moviePoster = movie["poster_path"] as? String {
                let posterUrl = URL(string: baseUrl + moviePoster)!
                cell.posterImageView.af_setImage(withURL: posterUrl)
            } else {
                cell.posterImageView.image = UIImage(named: "Ice")
            }
            if let backdropPath = movie["backdrop_path"] as? String{
                let backdropPosterURL = URL(string: "https://image.tmdb.org/t/p/w1280" + backdropPath)!
                cell.backgroundPosterImageView.af_setImage(withURL: backdropPosterURL)
            } else{
                cell.backgroundPosterImageView.image =  UIImage(named: "Ice")
            }
            //cell.backgroundPosterImageView.af_setImage(withURL: "Ice")
            
            return cell
            
        }
        else if indexPath.section == 1 && similarMovies.count > 0{
            let cell = UITableViewCell()
            
            cell.textLabel?.text = "Similar Movies"
            
            return cell
        } else {
    
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell
            let movie = similarMovies[indexPath.section - 1]
            cell.movieTitleLabel.text = movie["title"] as? String
            cell.movieDateLabel.text = movie["release_date"] as? String
            cell.movieOverviewLabel.text = movie["overview"] as? String
                if let posterPath = movie["poster_path"] as? String{
                    let posterURL = URL(string: baseUrl + posterPath)!
                    cell.posterImageView.af_setImage(withURL: posterURL)
                } else{
                    cell.posterImageView.image =  UIImage(named: "Ice")
                }
            return cell

            
        }
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let trailerSegue = segue.destination as! TrailerViewController
        trailerSegue.movie = movie
        
    }
    

}
