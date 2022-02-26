//
//  UpdateClubProfileViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 2/12/2021.
//

import UIKit
import Alamofire

class UpdateClubProfileViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var clubNamelbl: UITextField!
    @IBOutlet var clubownerlbl: UITextField!
    @IBOutlet var clubloginlbl: UITextField!
    @IBOutlet var resetpasswordlbl: UITextField!
    @IBOutlet var resetnewpass: UITextField!
    @IBOutlet var clubdescription: UITextView!
    @IBOutlet var verifiedAccount: UILabel!
    @IBOutlet var verifyButton: UIButton!
    
    var clubs = [Clubs]()
    var selectedImages : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ReusableFunctionsViewController.customTextField(textfield: clubNamelbl)
        ReusableFunctionsViewController.customTextField(textfield: clubownerlbl)
        ReusableFunctionsViewController.customTextField(textfield: clubloginlbl)
        ReusableFunctionsViewController.customTextField(textfield: resetpasswordlbl)
        ReusableFunctionsViewController.customTextField(textfield: resetnewpass)
        ReusableFunctionsViewController.roundPicture(image: imageView)
        
        fetchClubProfile()
        
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func uploadimage(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    
    func fetchClubProfile() {
        let token = UserDefaults.standard.string(forKey: "tokenClub")
        let clubName = UserDefaults.standard.string(forKey: "clubName")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())club/clubByName/\(clubName!)", method: .get, headers: headers).responseDecodable(of: [Clubs].self) { [weak self] response in
            self?.clubs = response.value ?? []
            self?.clubNamelbl.text = self?.clubs[0].clubName
            self?.clubdescription.text = self?.clubs[0].description
            self?.clubownerlbl.text = self?.clubs[0].clubOwner
            self?.clubloginlbl.text = self?.clubs[0].login

            let strImageUrl = "\(ConnectionDb.baserequest())/upload/download/" + (self?.clubs[0].clubLogo)!
            let urlImage = URL(string: strImageUrl)
            let imageData = try? Data(contentsOf: urlImage!)
            self?.imageView.image = UIImage(data: imageData!)
            
            if self?.clubs[0].verified == false {
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
    
    func uploadImageToServerClubupdate(imageOrVideo : UIImage?){
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
                
                self.updateProfileClubWithPicure(imageupload: imm.img)
              
               // club.set(description: bio!.text)
                //print(imm.img)
                                
            }
    }
    
    func updateProfileClubWithPicure(imageupload: String) {
        //let token = UserDefaults.standard.string(forKey: "tokenClub")
        let clubName = UserDefaults.standard.string(forKey: "clubName")
        let clubpass = UserDefaults.standard.string(forKey: "passwordClub")
        
        let newClubName = clubNamelbl.text
        //let newClubOwner = Int(clubownerlbl.text!)
        let newClubLogin = clubloginlbl.text
        let resetpassword = resetpasswordlbl.text
        let newDescription = clubdescription.text
        //let passconf = resetnewpass.text
        let newLogo = imageupload
        let resetconfirm = resetnewpass.text
        if resetpassword != "" && resetpassword == resetconfirm {
        let parameters = ["login": newClubLogin!,
                          "password": resetpassword ?? "tt",
                          //"clubOwner": newClubOwner,
                          "clubName": newClubName!,
                          //"clubLogo": newLogo,
                          "description": newDescription!
                        ] as [String : Any]
        AF.request("\(ConnectionDb.baserequest())club/\(clubName!)", method: .patch, parameters: parameters).responseJSON {  response in
            print("modif success")
        }
        } else if resetpassword == "" {
            let parameters = ["login": newClubLogin!,
                              "password": clubpass!,
                              //"clubOwner": newClubOwner,
                              "clubName": newClubName!,
                              "clubLogo": newLogo,
                              "description": newDescription!
                            ] as [String : Any]
            AF.request("\(ConnectionDb.baserequest())club/\(clubName!)", method: .patch, parameters: parameters).responseJSON {  response in
                print("modif success")
            }
        }
    }
    
    func updateProfileClubNoPicture() {
        _ = UserDefaults.standard.string(forKey: "tokenClub")
        let clubName = UserDefaults.standard.string(forKey: "clubName")
        let clubpass = UserDefaults.standard.string(forKey: "passwordClub")
        
        let newClubName = clubNamelbl.text
        //let newClubOwner = Int(clubownerlbl.text!)
        let newClubLogin = clubloginlbl.text
        let resetpassword = resetpasswordlbl.text
        let newDescription = clubdescription.text
        _ = resetnewpass.text
        _ = "default.png"
        let resetconfirm = resetnewpass.text
        if resetpassword != "" && resetpassword == resetconfirm {
        let parameters = ["login": newClubLogin!,
                          "password": resetpassword!,
                          //"clubOwner": newClubOwner,
                          "clubName": newClubName!,
                          //"clubLogo": newLogo,
                          "description": newDescription!
                        ] as [String : Any]
        AF.request("\(ConnectionDb.baserequest())club/\(clubName!)", method: .patch, parameters: parameters).responseJSON {  response in
            print("modif success")
        }
        } else if resetpassword == "" {
            let parameters = ["login": newClubLogin!,
                              "password": clubpass!,
                              //"clubOwner": newClubOwner,
                              "clubName": newClubName!,
                              //"clubLogo": newLogo,
                              "description": newDescription!
                            ] as [String : Any]
            AF.request("\(ConnectionDb.baserequest())club/\(clubName!)", method: .patch, parameters: parameters).responseJSON {  response in
                print("modif success")
            }
        }
    }
    
    @IBAction func saveChanges(_ sender: UIButton) {
        if selectedImages == nil {
            updateProfileClubNoPicture()
        } else {
            uploadImageToServerClubupdate(imageOrVideo : selectedImages)
        }
            
    }
    
    
}
extension UpdateClubProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
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
