//
//  UserRegisterViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 4/11/2021.
//

import UIKit

class UserRegisterViewController: UIViewController {

    @IBOutlet var userEmailRegister: UITextField!
    @IBOutlet var passwordUserRegister: UITextField!
    @IBOutlet var passwordConfirmUserregister: UITextField!
    @IBOutlet var lastNameUserRegister: UITextField!
    @IBOutlet var FirstNameUserRegister: UITextField!
    @IBOutlet var identifierUserRegister: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        ReusableFunctionsViewController.customTextField(textfield: userEmailRegister)
        ReusableFunctionsViewController.customTextField(textfield: passwordUserRegister)
        ReusableFunctionsViewController.customTextField(textfield: passwordConfirmUserregister)
        ReusableFunctionsViewController.customTextField(textfield: lastNameUserRegister)
        ReusableFunctionsViewController.customTextField(textfield: FirstNameUserRegister)
        ReusableFunctionsViewController.customTextField(textfield: identifierUserRegister)
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func passwordShowHideUserRegister(_ sender: Any) {
        passwordUserRegister.isSecureTextEntry.toggle()
    }
    @IBAction func passwordConfirmShowHideUserRegister(_ sender: Any) {
        passwordConfirmUserregister.isSecureTextEntry.toggle()
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
