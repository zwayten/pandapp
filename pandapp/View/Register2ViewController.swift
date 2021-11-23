//
//  Register2ViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 22/11/2021.
//

import UIKit

class Register2ViewController: UIViewController {

    
    var segueClass: User?
    var segueClassClub: Clubs?
    var clubCheck: Bool?
    var userCheck: Bool?
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var PhoneNumber: UITextField!
    @IBOutlet var bio: UITextView!
    
    @IBOutlet var phonelbl: UILabel!
    
    
    
    override func viewDidLoad() {
        
        if clubCheck! == true && userCheck! == false {
            PhoneNumber.isHidden = true
            phonelbl.isHidden = true
        }
        if clubCheck! == false && userCheck! == true {
            PhoneNumber.isHidden = false
            phonelbl.isHidden = false
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
        let umodel = UserViewModel()
        let cmodel = ClubsViewModel()
        
        if clubCheck! == false && userCheck! == true {
            if let numtext = PhoneNumber.text {
                if let numInt = Int(numtext) {
                    segueClass!.setPhoneNumber(phoneNumber: numInt)
                }
                else { segueClass!.phoneNumber = 999 }
            }
            else { print("empty field") }
            
            
             umodel.registerUser(user: segueClass!)
        }
        if clubCheck! == true && userCheck! == false {
            
            cmodel.registerClub(club: segueClassClub!)
        }
        
        
    }
    
}

extension Register2ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
