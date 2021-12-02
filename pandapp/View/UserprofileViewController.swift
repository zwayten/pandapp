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
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "email": "\(email!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())user", method: .get, headers: headers).responseDecodable(of: [User].self) { [weak self] response in
            self?.users = response.value ?? []
            self?.userName.text = "\(self?.users[0].LastName) \(self?.users[0].FirstName)"
            let strImageUrl = "http://192.168.109.1:3000/upload/download/" + (self?.users[0].profilePicture)!
            let urlImage = URL(string: strImageUrl)
            let imageData = try? Data(contentsOf: urlImage!)
            self?.userImage.image = UIImage(data: imageData!)
            print(response)
            print(response.value)
            
        }
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
