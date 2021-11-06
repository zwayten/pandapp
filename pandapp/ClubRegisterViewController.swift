//
//  ClubRegisterViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 5/11/2021.
//

import UIKit

class ClubRegisterViewController: UIViewController {

    @IBOutlet var clubRegisteremail: UITextField!
    @IBOutlet var clubRegisterPassword: UITextField!
    @IBOutlet var clubRegisterConfirmPassword: UITextField!
    @IBOutlet var clubRegisterClubName: UITextField!
    @IBOutlet var clubRegisterDescription: UITextField!
    @IBOutlet var clubRegisterIdentifier: UITextField!
    
    func initClubRegister(){
        ReusableFunctionsViewController.customTextField(textfield: clubRegisteremail)
        ReusableFunctionsViewController.customTextField(textfield: clubRegisterPassword)
        ReusableFunctionsViewController.customTextField(textfield: clubRegisterConfirmPassword)
        ReusableFunctionsViewController.customTextField(textfield: clubRegisterClubName)
        ReusableFunctionsViewController.customTextField(textfield: clubRegisterDescription)
        ReusableFunctionsViewController.customTextField(textfield: clubRegisterIdentifier)
        
    }
    override func viewDidLoad() {
        initClubRegister()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ShowPassword(_ sender: Any) {
        clubRegisterPassword.isSecureTextEntry.toggle()
    }
    
    @IBAction func showconfirmPassword(_ sender: Any) {
        clubRegisterConfirmPassword.isSecureTextEntry.toggle()
    }
    @IBAction func confirmPasswordListene(_ sender: Any) {
        if ReusableFunctionsViewController.validatePassword(textfield: clubRegisterPassword, textfieldConfirm: clubRegisterConfirmPassword) {
            ReusableFunctionsViewController.customTextFieldGreen(textfield: clubRegisterConfirmPassword)
            ReusableFunctionsViewController.customTextFieldGreen(textfield: clubRegisterPassword)
        }
        else {
            ReusableFunctionsViewController.customTextField(textfield: clubRegisterPassword)
            ReusableFunctionsViewController.customTextField(textfield: clubRegisterConfirmPassword)
            
        }
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
