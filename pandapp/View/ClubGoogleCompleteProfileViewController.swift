//
//  ClubGoogleCompleteProfileViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 5/12/2021.
//

import UIKit

class ClubGoogleCompleteProfileViewController: UIViewController {

    var clubGoogleSegue: GoogleSegueClub?
    
    @IBOutlet var clubnamelbl: UITextField!
    @IBOutlet var bio: UITextView!
    @IBOutlet var passwordConfirmlbl: UITextField!
    @IBOutlet var passwordlbl: UITextField!
    @IBOutlet var clubOwnerlbl: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ReusableFunctionsViewController.customTextField(textfield: clubnamelbl)
        ReusableFunctionsViewController.customTextField(textfield: passwordConfirmlbl)
        ReusableFunctionsViewController.customTextField(textfield: passwordlbl)
        ReusableFunctionsViewController.customTextField(textfield: clubOwnerlbl)
        clubnamelbl.text = clubGoogleSegue!.club.clubName
        clubOwnerlbl.text = clubGoogleSegue!.club.clubOwner
    }
    
    func signupWithGoogleClub() {
        let password = passwordlbl.text!
       // let passwordConf = passwordConfirmlbl.text
        clubGoogleSegue!.club.set(password: password)
        
        
        let uploadService = UploadImageService()
        let imageData = try? Data(contentsOf: clubGoogleSegue!.profilePictureUrl)
        let image = UIImage(data: imageData!)
        
        uploadService.uploadImageToServerClub(imageOrVideo: image, club: clubGoogleSegue!.club, bio: bio)
    }
  
    @IBAction func saveClub(_ sender: Any) {
        signupWithGoogleClub()
    }
    
}
