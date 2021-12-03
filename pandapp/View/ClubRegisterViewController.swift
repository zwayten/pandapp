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
    @IBOutlet var clubRegisterOwner: UITextField!
    

    
    func initClubRegister(){
        ReusableFunctionsViewController.customTextField(textfield: clubRegisteremail)
        ReusableFunctionsViewController.customTextField(textfield: clubRegisterPassword)
        ReusableFunctionsViewController.customTextField(textfield: clubRegisterConfirmPassword)
        ReusableFunctionsViewController.customTextField(textfield: clubRegisterClubName)
        ReusableFunctionsViewController.customTextField(textfield: clubRegisterOwner)

        
    }
    override func viewDidLoad() {
        initClubRegister()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func registerBtn(_ sender: UIButton) {
       let club = getData()
        performSegue(withIdentifier: "toRegisterclub", sender: club)
    }
    func getData() -> Clubs {
        let clubname = clubRegisteremail.text!
        let password  = clubRegisterPassword.text!
        let login = clubRegisteremail.text!
        let owner = Int(clubRegisterOwner.text!)
        
        let club = Clubs(clubName: clubname, clubOwner: owner!, clubLogo: "logo.png", verified: false, password: password, login: login, description: "", _id: "")
        return club
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRegisterclub" {
                    let club = sender as! Clubs
                    let destination = segue.destination as! Register2ViewController
                    destination.segueClassClub = club
                    destination.clubCheck = true
                    destination.userCheck = false
                    
                }
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
    
    
    @IBAction func unwindToUserRegister(_ sender: UIStoryboardSegue) {}
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
