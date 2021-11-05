//
//  UserLoginViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 4/11/2021.
//

import UIKit

class UserLoginViewController: UIViewController {

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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
