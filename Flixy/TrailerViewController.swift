//
//  TrailerViewController.swift
//  Flixy
//
//  Created by Dinaol Melak on 12/8/19.
//  Copyright © 2019 Dinaol Melak. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var trailerWebView: WKWebView!
    var movie: [String: Any]!
    var trailers = [[String:Any]]()
    var movieTrailerKey = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // print(movie)
        let movieID = movie["id"] as! Int
        // Do any additional setup after loading the view.
        // Here I make an API call to get the trailer key
        //print(movie)
        //print("Here it is \(movieID)")
        let movieURL = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=28f10e36fa09f2d464dd184da2a57b39&language=en-US")!
        let request = URLRequest(url: movieURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request){(data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                // get the array of movies
                self.trailers = dataDictionary["results"] as! [[String: Any]]
                
                let firstResult = self.trailers[0]
                self.movieTrailerKey = firstResult["key"] as! String
                
                print(self.trailers)
                print(self.movieTrailerKey)
                
                
                let trailerURL = URL(string: "https://www.youtube.com/watch?v=\(self.movieTrailerKey)")!
                let myRequest = URLRequest(url: trailerURL)
                self.trailerWebView.load(myRequest)

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
