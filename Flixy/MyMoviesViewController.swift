//
//  MyMoviesViewController.swift
//  Flixy
//
//  Created by Dinaol Melak on 12/21/19.
//  Copyright © 2019 Dinaol Melak. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class MyMoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var currentNumOfFavMovies = 0
    var movieIDs = [Int]()
    var myMovies = [[String:Any]]()
    var refresher: UIRefreshControl!
    @IBOutlet weak var myMoviesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myMoviesTableView.delegate = self
        myMoviesTableView.dataSource = self
        refresher = UIRefreshControl()
        self.myMoviesTableView.addSubview(refresher)
        myMoviesTableView.insertSubview(refresher, at: 0)
        // Do any additional setup after loading the view.
        self.refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        

        getMovieParseAndInfo()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if !UserDefaults.standard.bool(forKey: "isUser"){
            performSegue(withIdentifier: "SignoutSegue", sender: self)
        }
        
        
    }
    @IBAction func didTapLogout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isUser")
        performSegue(withIdentifier: "SignoutSegue", sender: self)
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return myMovies.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = myMoviesTableView.dequeueReusableCell(withIdentifier: "ProfileInfoCell") as! ProfileInfoCell
            cell.numMovies.text = String(myMovies.count)
            return cell
        }else{
            let cell = myMoviesTableView.dequeueReusableCell(withIdentifier: "FavoriteMoviesCell") as! FavoriteMoviesCell
            
            let movie = myMovies[indexPath.section - 1]
            
            //print("----->\(movie)")
            let movieTitle = movie["title"] as! String
            let movieCaption = movie["overview"] as! String
            cell.movieTitleLabel.text = movieTitle
            cell.movieDescriptionLabel.text = movieCaption
            let baseUrl = "https://image.tmdb.org/t/p/w342"
            if let posterPath = movie["poster_path"] as? String{
                let posterURL = URL(string: baseUrl + posterPath)!
                cell.movieProfilePic.af_setImage(withURL: posterURL)

            } else{
                cell.movieProfilePic.image = UIImage(named: "Ice")
            }
            
            
            
            return cell
        }
    }
    func getMovieParseAndInfo(){
        let userMovies = PFQuery(className: "MyMovies")
        userMovies.whereKeyExists("movie_id")
        userMovies.limit = 20
        userMovies.findObjectsInBackground { (movie, error) in
            if movie != nil{
                for ids in movie!{
                    //print(ids["movie_id"] as! Int)
                    self.movieIDs.append(ids["movie_id"] as! Int)
                    
                }
            }
        }

    }
    @objc func refreshData(){
        
        if currentNumOfFavMovies < movieIDs.count{
            for ids in movieIDs{
                getMovieInfo(ofID: ids)
            }
            self.currentNumOfFavMovies = self.movieIDs.count
        } else{
            refresher.endRefreshing()
        }
        

    }
    func getMovieInfo(ofID movieID: Int){
        let movieID = "https://api.themoviedb.org/3/movie/\(movieID)?api_key=28f10e36fa09f2d464dd184da2a57b39&language=en-US"
        let movie_id = URL(string: movieID)!
        let request = URLRequest(url: movie_id, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request){(data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                // get the array of movies
                // store the movies in a property to be used else where
                
                //print(dataDictionary)
                self.myMovies.append(dataDictionary)
                // reload table view data
                self.myMoviesTableView.reloadData()
                self.refresher.endRefreshing()
            }
            
        }
        task.resume()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
