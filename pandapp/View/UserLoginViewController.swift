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
    
    @IBOutlet var userEmail: UITextField!
    @IBOutlet var userPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ReusableFunctionsViewController.customTextField(textfield: userEmail)
        ReusableFunctionsViewController.customTextField(textfield: userPassword)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func passwordShowHideUserLogin(_ sender: Any) {
        userPassword.isSecureTextEntry.toggle()
    }
    
    func loginUser(email: String, password: String) {
        let parameters = ["email": email,
                          "password": password] as [String : Any]
        AF.request("http://192.168.109.1:3000/auth", method: .post, parameters: parameters).responseJSON {  response in
            let login: LoginUser = try! JSONDecoder().decode(LoginUser.self, from: response.data!)
            self.token = login.token
            print(login.token)
            /*
            if let data = response.data  {
                            
                let json = String(data: data, encoding: .utf8)
                print(json)
                
                        }
            */

            
            
           
            
            
        }
        print("test:###############")
        print(token)
    //print(token)
    // return token
    
}
    
    @IBAction func loginClicked(_ sender: UIButton) {
        loginUser(email: userEmail.text ?? "123", password: userPassword.text ?? "777")
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
