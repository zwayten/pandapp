//
//  UserprofileViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 4/11/2021.
//

import UIKit
import Alamofire

class UserprofileViewController: UIViewController {

    //Circular image user profile:
    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var userName: UILabel!
    
    @IBOutlet var userBio: UITextView!
    
    var users = [User]()
    
    
    func initProfile(){
        userImage.layer.borderWidth = 0
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
        
    }
    
    func fetchClubProfile() {
        let token = UserDefaults.standard.string(forKey: "token")
        let userName = UserDefaults.standard.string(forKey: "userName")
        let email = UserDefaults.standard.string(forKey: "email")
        print(userName!)
        print(email!)
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())user/userByEmail/\(email!)", method: .get, headers: headers).responseDecodable(of: [User].self) { [weak self] response in
            self?.users = response.value ?? []
            print(self?.users.count)
            self?.userName.text = "\((self?.users[0].LastName)!) \((self?.users[0].FirstName)!)"
            self?.userBio.text = (self?.users[0].description)!
            let strImageUrl = "http://192.168.109.1:3000/upload/download/" + (self?.users[0].profilePicture)!
            let urlImage = URL(string: strImageUrl)
            let imageData = try? Data(contentsOf: urlImage!)
            self?.userImage.image = UIImage(data: imageData!)
            print(response)
            print(response.value)
            
        }
    }
    @IBAction func logoutUser(_ sender: UIButton) {
        let menu = UIMenu(title: "", children: [
            UIAction(title: "Edit your profile", image: UIImage(systemName: "pencil.and.ellipsis.rectangle"), handler: { (_) in
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let updateprofile = storyboard.instantiateViewController(withIdentifier: "userUpdateProfileId")
                //vc.modalPresentationStyle = .fullScreen
                self.present(updateprofile, animated: true)
            }),
            UIAction(title: "Logout", image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), handler: { (_) in
                UserDefaults.standard.set("", forKey: "userName")
                UserDefaults.standard.set("", forKey: "email")
                UserDefaults.standard.set("", forKey: "identifant")
                UserDefaults.standard.set("", forKey: "password")
                UserDefaults.standard.set("", forKey: "token")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "initialNavigation")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            })
        ])

        sender.menu = menu
        sender.showsMenuAsPrimaryAction = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initProfile()
        fetchClubProfile()
        // Do any additional setup after loading the view.
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
