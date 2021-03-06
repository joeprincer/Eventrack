//
//  SignUpTVC.swift
//  Eventrack
//
//  Created by Jiazhou Liu on 20/5/17.
//  Version 3.0 9/6/2017
//  Copyright © 2017 Jiazhou Liu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpTVC: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var userImageView: UIImageView!
    
    var pickerView: UIPickerView!
    var countryArray = [String]()   // array to store countries
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // use country code from iOS system
        for code in NSLocale.isoCountryCodes{
            let locale = Locale(identifier: "en_EN") // Country names in English
            let countryName = locale.localizedString(forRegionCode: code)!
            countryArray.append(countryName)
        }
        
        // setup picker view
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        countryTF.inputView = pickerView
    }
    
    // pickerView configurations
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryTF.text = countryArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = NSAttributedString(string: countryArray[row], attributes: [NSForegroundColorAttributeName : UIColor.white])
        return title
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // when user taps on the image
    @IBAction func choosePicture(_ sender: Any) {
      
        let pickerController = UIImagePickerController();
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        // setup a new alert at the bottom to let user choose options
        let alertController = UIAlertController(title: "Add a Picture", message: "Choose From ", preferredStyle: .actionSheet)
        
        // pick image from camera
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                pickerController.sourceType = UIImagePickerControllerSourceType.camera
                self.present(pickerController, animated: true, completion: nil)
            }
        }
        
        // pick image from photo library
        let photosLibraryAction = UIAlertAction(title: "Photos Library", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
                self.present(pickerController, animated: true, completion: nil)
            }
        }
        
        // pick image from saved photo album
        let savedPhotoAction = UIAlertAction(title: "Saved Photo Album", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum) {
                pickerController.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
                self.present(pickerController, animated: true, completion: nil)
            }
        }
        
        // cancel option
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photosLibraryAction)
        alertController.addAction(savedPhotoAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // image picker controller handler when finish choose image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.dismiss(animated: true, completion: nil)
            self.userImageView.image = pickedImage
        }
    }

    // sign up function pressed
    @IBAction func signupPressed(_ sender: Any) {
        let imgData = UIImageJPEGRepresentation(self.userImageView.image!, 0.8)
        
        if let email = emailTF.text, let pass = passwordTF.text, let username = usernameTF.text, let country = countryTF.text, (email.characters.count > 0 && pass.characters.count > 0){   // check if email and password are filled
            //call the login service
            AuthService.instance.signup(email: email, username: username, password: pass, country: country, data: imgData! as NSData, onComplete: { (errMsg, data) in
                guard errMsg == nil else {  // error handler
                    let alert = UIAlertController(title: "Error Authentication", message: errMsg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
                    self.present(alert, animated:true, completion: nil)
                    return
                }
                // success signup and show it to user, then navigate back to root screen
                let alertController = UIAlertController(title: "Success", message: "You have successfully signed up!", preferredStyle: UIAlertControllerStyle.alert)
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
        else {  // error handling
            let alert = UIAlertController(title: "Email and Password Required", message: "You must enter both an email and a password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    }

}
