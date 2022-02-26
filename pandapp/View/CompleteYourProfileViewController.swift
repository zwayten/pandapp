//
//  CompleteYourProfileViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 5/12/2021.
//

import UIKit
import Alamofire

class CompleteYourProfileViewController: UIViewController {
    
   
    
    var userGoogleSegue: GoogleSegue?
    
    @IBOutlet var bio: UITextView!
    @IBOutlet var idlbl: UITextField!
    @IBOutlet var passwordConfirmlbl: UITextField!
    @IBOutlet var passwordlbl: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    func signupWithGoogleUser() {
        let password = passwordlbl.text!
        //let passwordConf = passwordConfirmlbl.text
        userGoogleSegue!.user.setPassword(password: password)
        
        
        let uploadService = UploadImageService()
        let imageData = try? Data(contentsOf: userGoogleSegue!.profilePictureUrl)
        let image = UIImage(data: imageData!)
        
        uploadService.uploadImageToServer(imageOrVideo: image, user: userGoogleSegue!.user, bio: bio)
    }
    
    
    @IBAction func save(_ sender: Any) {
        signupWithGoogleUser()
    }
    
    

}
