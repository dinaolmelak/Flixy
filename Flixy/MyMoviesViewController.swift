//
//  MyMoviesViewController.swift
//  Flixy
//
//  Created by Dinaol Melak on 12/21/19.
//  Copyright © 2019 Dinaol Melak. All rights reserved.
//

import UIKit
import AlamofireImage

class MyMoviesViewController: UIViewController {

    var requestToken = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setRequestToken()
    }
    override func viewDidAppear(_ animated: Bool) {
        if !UserDefaults.standard.bool(forKey: "isUser"){
            performSegue(withIdentifier: "UserSegue", sender: self)
        }
    }
    @IBAction func didTapLogout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isUser")
        performSegue(withIdentifier: "UserSegue", sender: self)
        
        
    }
    
    func setRequestToken(){
        let movieURL = URL(string: "https://api.themoviedb.org/3/authentication/token/new?api_key=28f10e36fa09f2d464dd184da2a57b39")!
        let request = URLRequest(url: movieURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request){(data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                // get the array of movies
                // store the movies in a property to be used else where
                self.requestToken = dataDictionary["request_token"] as! String
                print(self.requestToken)
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
