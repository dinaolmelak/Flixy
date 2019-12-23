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
    @IBOutlet weak var signingButton: UIButton!
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
            signingButton.setTitle("Sign In", for: .normal)
            signUpStackView.isHidden = true
            signInStackView.isHidden = false
        } else{//means that it is on Sign Up
            signingButton.setTitle("Sign Up", for: .normal)
            signUpStackView.isHidden = false
            signInStackView.isHidden = true
        }
    }
    
    @IBAction func onTapSigning(_ sender: Any) {
        if signingSegment.selectedSegmentIndex == 0{
            if checkSignInTF() {
                print("ready to check auth")
                PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (currentPFUser, error) in
                    if error != nil{

                    }else{
                        print("signed in")
                        UserDefaults.standard.set(true, forKey: "isUser")
                        self.performSegue(withIdentifier: "UserSegue", sender: self)
                        
                        
                    }
                }
                
//                dismiss(animated: true, completion: nil)
//                navigationController?.popViewController(animated: true)
            } else {
                showAlert("Missing Info", "You are missing a Username or password")
            }
        }else{
            if(checkSignUPTF()){
                print("ready to check auth")
                let user = PFUser()
                user.username = signUpUNTextField.text!
                user.email = signUpEmailTextField.text!
                user.password = signUpPWTextField.text!

                user.signUpInBackground { (success, error) in
                    if error != nil{
                        print(error)
                    } else{
                        print("Sign up success")
                        
                        UserDefaults.standard.set(true, forKey: "isUser")
                        self.performSegue(withIdentifier: "UserSegue", sender: self)
                        
                    }
                }
                
//                dismiss(animated: true, completion: nil)
//                navigationController?.popViewController(animated: true)
            } else{
                showAlert("Missign Info", "You are missing a Username, Email or password")
            }
        }
        
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
    
    
    func showAlert(_ title: String,_ message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
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
