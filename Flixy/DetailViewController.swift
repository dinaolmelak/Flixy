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
        
        movieDetail()
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
    
    override func viewDidAppear(_ animated: Bool) {
        //self.startUpAnimation()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        posterImageView.alpha = 0.3
//        self.movieOverviewLabel.alpha = 0.3
//        self.movieDateLabel.alpha = 0.3
    }
    
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
        return similarMovies.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return similarMovies.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell
        
        
        return cell
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
