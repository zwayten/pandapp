//
//  Register2ViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 22/11/2021.
//

import UIKit

class Register2ViewController: UIViewController {

    //var from Register 1 interface
        // classes user and clubs instantiated in "UserRegisterViewController"
        var segueClass: User?
 
        var segueClassClub: Clubs?

    
        // Bool vars to check if its user or club to register
        var clubCheck: Bool?
        var userCheck: Bool?
    // upload image vars
    var selectedImages : UIImage?
    var imageJsonReturnAf  = ""
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var PhoneNumber: UITextField!
    @IBOutlet var bio: UITextView!
    
    @IBOutlet var phonelbl: UILabel!
    
    
    
    override func viewDidLoad() {
        
        if clubCheck! == true && userCheck! == false {
            PhoneNumber.isHidden = true
            phonelbl.isHidden = true
            if segueClassClub!.clubLogo != "default.png" {
                let strImageUrl = segueClassClub!.clubLogo
                let urlImage = URL(string: strImageUrl)
                let imageData = try? Data(contentsOf: urlImage!)
                imageView.image = UIImage(data: imageData!)
            }
        }
        if clubCheck! == false && userCheck! == true {
            PhoneNumber.isHidden = false
            phonelbl.isHidden = false
            print("eeeeeeeeeeeeeeeee \(segueClass!.profilePicture)")
            if segueClass!.profilePicture != "default.png" {
                let strImageUrl = segueClass!.profilePicture
                let urlImage = URL(string: strImageUrl)
                let imageData = try? Data(contentsOf: urlImage!)
                imageView.image = UIImage(data: imageData!)
            }
        }
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func uploadImage(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func btnregister2(_ sender: Any) {
        //let umodel = UserViewModel()
        //let cmodel = ClubsViewModel()
        let uploadService = UploadImageService()
        
        if clubCheck! == false && userCheck! == true {
            if let numtext = PhoneNumber.text {
                if let numInt = Int(numtext) {
                    segueClass!.setPhoneNumber(phoneNumber: numInt)
                }
                else { segueClass!.phoneNumber = 123 }
            }
            else { print("empty field") }
            if segueClass!.profilePicture != "default.png" {
                uploadService.uploadImageToServer(imageOrVideo: imageView.image, user: segueClass!, bio: bio)
            }
            else {
             uploadService.uploadImageToServer(imageOrVideo: selectedImages, user: segueClass!, bio: bio)
            }
            print("debuggggggg")
            print(segueClass!.profilePicture)
            print("debuggggggg")
              //  segueClass!.setProfilepicture(profilePicture: imageJsonReturnAf)
            
            
            
             //umodel.registerUser(user: segueClass!)
        }
        if clubCheck! == true && userCheck! == false {
            if segueClassClub!.clubLogo != "default.png" {
                uploadService.uploadImageToServerClub(imageOrVideo: imageView.image, club: segueClassClub!, bio: bio)
            }
            else{
            uploadService.uploadImageToServerClub(imageOrVideo: selectedImages, club: segueClassClub!, bio: bio)
            }
        }
        
        
    }
    
}

extension Register2ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageView.image = image
            selectedImages = image
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
