//
//  LoginVC.swift
//  Eventrack
//
//  Created by Jiazhou Liu on 5/5/17.
//  Version 3.0 9/6/2017
//  Copyright © 2017 Jiazhou Liu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {

    // IBOutlets
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var forgotPwdBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // navigation bar text color
        UINavigationBar.appearance().tintColor = UIColor.white

        // login button design
        loginBtn.layer.cornerRadius = 10
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.borderColor = UIColor.white.cgColor
        
        // Button frame modification
        var userFrameRect: CGRect = usernameTF.frame
        userFrameRect.size.height = 50
        usernameTF.frame = userFrameRect
        var passwordFrameRect: CGRect = passwordTF.frame
        passwordFrameRect.size.height = 50
        passwordTF.frame = passwordFrameRect
        
        
        // Do any additional setup after loading the view.
    }
    
    // back button to root screen
    @IBAction func loginCancelled(_ sender: Any) {
        self.performSegue(withIdentifier: "loginCancel", sender: nil)
    }
    @IBAction func loginCancelledByX(_ sender: Any) {
        self.performSegue(withIdentifier: "loginCancel", sender: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // login button pressed
    @IBAction func loginPressed(_ sender: Any) {
        if let email = usernameTF.text, let pass = passwordTF.text, (email.characters.count > 0 && pass.characters.count > 0){
            //call the login service
            AuthService.instance.login(email: email, password: pass, onComplete: { (errMsg, data) in    // use login using auth service
                guard errMsg == nil else {  // handle error
                    let alert = UIAlertController(title: "Error Authentication", message: errMsg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
                    self.present(alert, animated:true, completion: nil)
                    return
                }
                
                // alert to show message to user about successfully logged in
                let alertController = UIAlertController(title: "Success", message: "You have successfully logged in!", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                    if let storyboard = self.storyboard {
                        let vc = storyboard.instantiateInitialViewController()
                        self.present(vc!, animated: true, completion: nil)
                    }
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            })
        }
        else {  // error log in
            let alert = UIAlertController(title: "Username and Password Required", message: "You must enter both a username and a password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    }

    @IBAction func forgotPwdPressed(_ sender: Any) {
        // push segue already working
    }
    
    
    // toast function for notification
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height/2, width: 300, height: 100))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.numberOfLines = 3
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }

}
