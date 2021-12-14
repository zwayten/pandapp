//
//  UpdateUserViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 2/12/2021.
//

import UIKit
import Alamofire

class UpdateUserViewController: UIViewController {

    @IBOutlet var firstnamelbl: UITextField!
    @IBOutlet var lastnamelbl: UITextField!
    @IBOutlet var idlbl: UITextField!
    @IBOutlet var emailbl: UITextField!
    @IBOutlet var phonenumberlbl: UITextField!
    @IBOutlet var classlbl: UITextField!
    @IBOutlet var biolbl: UITextView!
    @IBOutlet var resetpasswordlbl: UITextField!
    @IBOutlet var resetnewpass: UITextField!
    @IBOutlet var verifiedAccount: UILabel!
    @IBOutlet var verifyButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    
    var users = [User]()
    var selectedImages : UIImage?
    
    override func viewDidLoad() {
        
        ReusableFunctionsViewController.customTextField(textfield: resetpasswordlbl)
        ReusableFunctionsViewController.customTextField(textfield: resetnewpass)
        ReusableFunctionsViewController.roundPicture(image: imageView)
        fetchUserProfile()
        super.viewDidLoad()
    }
    
    func fetchUserProfile() {
        let token = UserDefaults.standard.string(forKey: "token")
        
        let email = UserDefaults.standard.string(forKey: "email")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())user/userByEmail/\(email!)", method: .get, headers: headers).responseDecodable(of: [User].self) { [weak self] response in
            self?.users = response.value ?? []
            
            self?.firstnamelbl.text = self?.users[0].FirstName
            self?.lastnamelbl.text = self?.users[0].LastName
            self?.idlbl.text = self?.users[0].identifant
            self?.phonenumberlbl.text = String(self?.users[0].phoneNumber ?? 123)
            self?.emailbl.text = self?.users[0].email
            self?.classlbl.text = self?.users[0].className
            self?.biolbl.text = self?.users[0].description
            
            //print("el taswira", (self?.users[0].profilePicture)!)
            

            let strImageUrl = "\(ConnectionDb.baserequest())upload/download/" + (self?.users[0].profilePicture)!
            let urlImage = URL(string: strImageUrl)
            let imageData = try? Data(contentsOf: urlImage!)
            self?.imageView.image = UIImage(data: imageData!)
            
            if self?.users[0].verified == false {
                self?.verifiedAccount.text = "Account Not verified press the button to verify"
            }
            else {
                self?.verifiedAccount.text = "Account verified nothing to do here"
                self?.verifyButton.isEnabled = false
            }
         //   print(response)
          //  print(response.value)
            
        }
    }
    
    func uploadImageToServerUserupdate(imageOrVideo : UIImage?){
        //let token = UserDefaults.standard.string(forKey: "token")
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Content-type": "multipart/form-data"
        ]
        
        
            AF.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(imageOrVideo!.jpegData(compressionQuality: 0.5)!, withName: "file" , fileName: "file.png", mimeType: "image/png")
            },
                to: "\(ConnectionDb.baserequest())upload/file", method: .post , headers: headers)
            .responseJSON {  response in
                let imm: ImageReturn = try! JSONDecoder().decode(ImageReturn.self, from: response.data!)
                //print(imm.img)
                
                self.updateProfileUserWithPicure(imageupload: imm.img)
              
               // user.set(description: bio!.text)
                //print(imm.img)
                                
            }
    }
    
    func updateProfileUserWithPicure(imageupload: String) {
       // let token = UserDefaults.standard.string(forKey: "token")
        let email = UserDefaults.standard.string(forKey: "email")
        //let userpass = UserDefaults.standard.string(forKey: "password")
        
       let firstname = firstnamelbl.text
       let lastname = lastnamelbl.text
       //let id = idlbl.text
       //let emaill = emailbl.text
       //let phonenumber = Int(phonenumberlbl.text)
       let classe = classlbl.text
       let bio = biolbl.text
       let resetpassword = resetpasswordlbl.text
       let passconf = resetnewpass.text
       let profilepic = imageupload
        
        
        let resetconfirm = resetnewpass.text
        if resetpassword != "" && resetpassword == resetconfirm {
        let parameters = [//"email": email!,
                          "FirstName": firstname!,
                          "LastName": lastname!,
                          "password": resetpassword!,
                          //"identifant": id,
                          "className": classe!,
                          "profilePicture": profilepic,
                          "description": bio!
                        ] as [String : Any]
        AF.request("\(ConnectionDb.baserequest())user/\(email!)", method: .patch, parameters: parameters).responseJSON {  response in
            print("modif success")
        }
        } else if resetpassword == "" {
            let parameters = [//"email": email!,
                                "FirstName": firstname!,
                                "LastName": lastname!,
                                //"password": resetpassword,
                                //"identifant": id,
                                "className": classe!,
                                "profilePicture": profilepic,
                                "description": bio!
                              ] as [String : Any]
            AF.request("\(ConnectionDb.baserequest())user/\(email!)", method: .patch, parameters: parameters).responseJSON {  response in
                print("modif success")
            }
        }
    }
    
    func updateProfileUserNoPicture() {
       // let token = UserDefaults.standard.string(forKey: "token")
        let email = UserDefaults.standard.string(forKey: "email")
       // let userpass = UserDefaults.standard.string(forKey: "password")
        
       let firstname = firstnamelbl.text
       let lastname = lastnamelbl.text
       //let id = idlbl.text
       //let emaill = emailbl.text
       //let phonenumber = Int(phonenumberlbl.text)
       let classe = classlbl.text
       let bio = biolbl.text
       let resetpassword = resetpasswordlbl.text
       //let passconf = resetnewpass.text
      // let profilepic = imageupload
        
        
        let resetconfirm = resetnewpass.text
        if resetpassword != "" && resetpassword == resetconfirm {
        let parameters = [//"email": email!,
                          "FirstName": firstname!,
                          "LastName": lastname!,
                          "password": resetpassword!,
                          //"identifant": id,
                          "className": classe!,
                          //"profilePicture": profilepic,
                          "description": bio!
                        ] as [String : Any]
        AF.request("\(ConnectionDb.baserequest())user/\(email!)", method: .patch, parameters: parameters).responseJSON {  response in
            print("modif success")
        }
        } else if resetpassword == "" {
            let parameters = [//"email": email!,
                                "FirstName": firstname!,
                                "LastName": lastname!,
                                //"password": resetpassword,
                                //"identifant": id,
                                "className": classe!,
                                //"profilePicture": profilepic,
                                "description": bio!
                              ] as [String : Any]
            AF.request("\(ConnectionDb.baserequest())user/\(email!)", method: .patch, parameters: parameters).responseJSON {  response in
                print("modif success")
            }
        }
    }
    @IBAction func save(_ sender: UIButton) {
        if selectedImages == nil {
            updateProfileUserNoPicture()
        } else {
            uploadImageToServerUserupdate(imageOrVideo : selectedImages)
        }
    }
    

    @IBAction func upload(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
}
extension UpdateUserViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
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
