//
//  AccountInfoViewController.swift
//  Flixy
//
//  Created by Dinaol Melak on 12/21/19.
//  Copyright © 2019 Dinaol Melak. All rights reserved.
//

import UIKit
import Parse

class AccountInfoViewController: UIViewController {

    @IBOutlet weak var signUpPWTextField: UITextField!
    @IBOutlet weak var signUpEmailTextField: UITextField!
    @IBOutlet weak var signUpUNTextField: UITextField!
    @IBOutlet weak var signUpStackView: UIStackView!
    @IBOutlet weak var signInStackView: UIStackView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var signingButton: UIBarButtonItem!
    @IBOutlet weak var signingSegment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        toggleSigningSegment()
    }
    
    @IBAction func onSigningSegment(_ sender: Any) {
        toggleSigningSegment()
        
    }
    
    func toggleSigningSegment(){
        if signingSegment.selectedSegmentIndex == 0 {// means that it is on Sign In
            signingButton.title = "Sign In"
            signUpStackView.isHidden = true
            signInStackView.isHidden = false
        } else{//means that it is on Sign Up
            signingButton.title = "Sign Up"
            signUpStackView.isHidden = false
            signInStackView.isHidden = true
        }
    }
    
    @IBAction func onTapSigning(_ sender: Any) {
        print(checkSignInTF())
        
    }
    func checkSignInTF() -> Bool{
        if usernameTextField.text != "" && passwordTextField.text != ""{
            return true
        }else{
            return false
        }
    }
    func checkSignUPTF() -> Bool{
        if signUpUNTextField.text != "" && signUpPWTextField.text != "" && signUpEmailTextField.text != ""{
            return true
        }else{
            return false
        }
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
