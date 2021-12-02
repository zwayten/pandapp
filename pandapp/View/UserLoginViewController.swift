//
//  UserLoginViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 4/11/2021.
//

import UIKit
import Alamofire

class UserLoginViewController: UIViewController {
    var token = ""
    var email = ""
    var password = ""
    var phoneNumber = 99
    var profilePicture = ""
    var FirstName = ""
    var LastName = ""
    var verified = false
    var social = false
    var identifant = ""
    var role = ""
    var className = ""
    var loginas = "user"
    
    var loginUserr: LoginUser?
    
    @IBOutlet var userEmail: UITextField!
    @IBOutlet var userPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ReusableFunctionsViewController.customTextField(textfield: userEmail)
        ReusableFunctionsViewController.customTextField(textfield: userPassword)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func toggle(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 { loginas = "user"
            print("user")
        } else { loginas = "club"
            print("clubbbbb")
        }
    }
    
    @IBAction func passwordShowHideUserLogin(_ sender: Any) {
        userPassword.isSecureTextEntry.toggle()
    }
    
    func loginUser(email: String, password: String){
        
        let parameters = ["email": email,
                          "password": password] as [String : Any]
        AF.request("\(ConnectionDb.baserequest())auth", method: .post, parameters: parameters).responseJSON {  response in
            let login: LoginUser = try! JSONDecoder().decode(LoginUser.self, from: response.data!)
            //self.loginUserr! = login
            self.token = login.token
            self.email = login.email
            self.password = login.password
            self.phoneNumber = login.phoneNumber
            self.profilePicture = login.profilePicture
            self.FirstName = login.FirstName
            self.LastName = login.LastName
            self.verified = login.verified
            self.social = login.social
            self.identifant = login.identifant
            self.role = login.role
            self.className = login.className
            print(login.token)
            print(self.token)
        }
        print("test:###############", token)
        
        //print(loginUserr!.token)
        
       
    //print(token)
    // return token
    
}
    //

    
    func loginUser1(email: String, password: String, completionHandler: @escaping (LoginUser,Int?) -> ()){
        //var logg: LoginUser
        let parameters = ["email": email,
                          "password": password] as [String : Any]
        AF.request("\(ConnectionDb.baserequest())auth", method: .post, parameters: parameters).responseJSON {  response in
            let statusCode = response.response?.statusCode
            if statusCode == 200 {
                let login: LoginUser = try! JSONDecoder().decode(LoginUser.self, from: response.data!)
                completionHandler(login,statusCode )
            } else {
                ReusableFunctionsViewController.displayAlert(title: "Invalid Credentials", subTitle: "Your credentials are invalid")
            }
        }
}
    func loginClub(loginemail: String, password: String, completionHandler: @escaping (LoginClub,Int?) -> ()){
        //var logg: LoginUser
        let parameters = ["login": loginemail,
                          "password": password] as [String : Any]
        AF.request("\(ConnectionDb.baserequest())authClub", method: .post, parameters: parameters).responseJSON {  response in
            let statusCode = response.response?.statusCode
            if statusCode == 200 {
                let login: LoginClub = try! JSONDecoder().decode(LoginClub.self, from: response.data!)
                completionHandler(login,statusCode )
            } else {
                ReusableFunctionsViewController.displayAlert(title: "Invalid Credentials", subTitle: "Your credentials are invalid")
            }
        }
}
    
    
    
    func setUserLoginInstance(user : LoginUser) -> LoginUser {
        let log = LoginUser(token: user.token, email: user.email, password: user.password, phoneNumber: user.phoneNumber, profilePicture: user.profilePicture, FirstName: user.FirstName, LastName: user.LastName, verified: user.verified, identifant: user.identifant, className: user.className, role: user.role, social: user.social, description: user.description)
        return log
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        if loginas == "user" {
        loginUser1(email: userEmail.text ?? "123", password: userPassword.text ?? "777", completionHandler: { (login,statusCode) in

            let completeName = "\(login.FirstName) \(login.LastName)"
            UserDefaults.standard.set(completeName, forKey: "userName")
            UserDefaults.standard.set(login.email, forKey: "email")
            UserDefaults.standard.set(login.identifant, forKey: "identifant")
            UserDefaults.standard.set(login.password, forKey: "password")
            UserDefaults.standard.set(login.token, forKey: "token")
            UserDefaults.standard.set(self.loginas , forKey: "lastLoggedIn")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "customTabBarId")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)

            
        })
        }
        else if loginas == "club" {
            loginClub(loginemail: userEmail.text ?? "123", password: userPassword.text ?? "777", completionHandler: { (login,statusCode) in
                
                UserDefaults.standard.set(login.login, forKey: "login")
                UserDefaults.standard.set(login.password, forKey: "passwordClub")
                UserDefaults.standard.set(login.tokenClub, forKey: "tokenClub")
                UserDefaults.standard.set(login.clubName, forKey: "clubName")
                UserDefaults.standard.set(self.loginas, forKey: "lastLoggedIn")
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "customTabBarId")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            })
        }
    }

}
