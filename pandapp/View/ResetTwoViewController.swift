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

        // Do any additional setup after loading the view.
    }
    
    
   
    
    func sendResetCode(loginemail: String, password: String, code: String){
        //var logg: LoginUser
        let parameters = ["email": loginemail,
                          "password": password,
                          "code": code
        ] as [String : Any]
        AF.request("http://192.168.109.1:3000/auth/reset", method: .patch, parameters: parameters).responseJSON {  response in
            
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
        else { popAlert(a: "error", b: "password is incorect ")}
    }
    
    func popAlert(a: String, b: String) {
            let alert = UIAlertController(title: a, message: b, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
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
