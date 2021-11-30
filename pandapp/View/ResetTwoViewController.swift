//
//  ResetTwoViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 30/11/2021.
//

import UIKit
import Alamofire
class ResetTwoViewController: UIViewController {

    @IBOutlet var newPasswordConf: UITextField!
    @IBOutlet var newPassword: UITextField!
    @IBOutlet var codeLbl: UITextField!
    var seguemail: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        ReusableFunctionsViewController.customTextField(textfield: newPasswordConf)
        ReusableFunctionsViewController.customTextField(textfield: newPassword)
        ReusableFunctionsViewController.customTextField(textfield: codeLbl)
        // Do any additional setup after loading the view.
    }
    @IBAction func Resend(_ sender: Any){
        reSendCode(loginemail: seguemail!, password: newPassword.text!, code: codeLbl.text!)
    }
    
    func reSendCode(loginemail: String, password: String, code: String){
        //var logg: LoginUser
        let parameters = ["email": loginemail,
                          "password": password,
                          "code": code
        ] as [String : Any]
        AF.request("\(ConnectionDb.baserequest())auth/reset", method: .patch, parameters: parameters).responseJSON {  response in
            
            let statusCode = response.response?.statusCode
            if statusCode == 200 {
                print("resend code sucess")
            }

        }
}
   
    
    func sendResetCode(loginemail: String, password: String, code: String){
        //var logg: LoginUser
        let parameters = ["email": loginemail,
                          "password": password,
                          "code": code
        ] as [String : Any]
        AF.request("\(ConnectionDb.baserequest())auth/reset", method: .patch, parameters: parameters).responseJSON {  response in
            
            let statusCode = response.response?.statusCode
            if statusCode == 200 {
                self.performSegue(withIdentifier: "backTologin", sender: nil)
            }

        }
}
    @IBAction func submit(_ sender: Any) {
        if newPassword.text == newPasswordConf.text {
        sendResetCode(loginemail: seguemail!, password: newPassword.text!, code: codeLbl.text!)
        }
        else { ReusableFunctionsViewController.displayAlert(title: "error", subTitle: "passwords don't match !") }
    }
    
   
}
