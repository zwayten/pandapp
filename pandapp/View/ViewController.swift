//
//  ViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 1/11/2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let email = UserDefaults.standard.string(forKey: "email")
        let password = UserDefaults.standard.string(forKey: "password")
        let token = UserDefaults.standard.string(forKey: "token")
        loginUser1(email: email!, password: password!)

        print("email :   ",email)
       // print("password :   ",password)
        print("token :   ",token)
        
    }
    
    func loginUser1(email: String, password: String){
        //var logg: LoginUser
        let parameters = ["email": email,
                          "password": password] as [String : Any]
        AF.request("http://192.168.109.1:3000/auth", method: .post, parameters: parameters).responseJSON {  response in
            let statusCode = response.response?.statusCode
            if statusCode == 200 {
                let login: LoginUser = try! JSONDecoder().decode(LoginUser.self, from: response.data!)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
                self.present(vc, animated: true)
            } else {
                self.popAlert(a: "Invalid Credentials", b: "Your credentials are invalid")
            }
        }
        
}
    /*
    func initiStoryBoard(emailDef: String, passwordDef: String) {
        loginUser1(email: emailDef, password: passwordDef, completionHandler: { (login,statusCode) in
    })
*/
   

    func popAlert(a: String, b: String) {
            let alert = UIAlertController(title: a, message: b, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        }
