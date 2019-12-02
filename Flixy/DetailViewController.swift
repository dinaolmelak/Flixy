//
//  DetailViewController.swift
//  Flixy
//
//  Created by Dinaol Melak on 12/2/19.
//  Copyright © 2019 Dinaol Melak. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var movie: [String: Any]!
    @IBOutlet weak var backgroundPosterImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // print(movie["title"])
        // self.posterImageView.center.x -= self.view.bounds.width
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        UIView.animate(withDuration: 1) {
//            self.posterImageView.center.x += self.view.bounds.width
//        }
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
