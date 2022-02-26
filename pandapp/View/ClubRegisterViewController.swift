//
//  ClubRegisterViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 5/11/2021.
//

import UIKit
import GoogleSignIn

class ClubRegisterViewController: UIViewController {

    @IBOutlet var clubRegisteremail: UITextField!
    @IBOutlet var clubRegisterPassword: UITextField!
    @IBOutlet var clubRegisterConfirmPassword: UITextField!
    @IBOutlet var clubRegisterClubName: UITextField!
    @IBOutlet var clubRegisterOwner: UITextField!
    
    @IBOutlet var imageGoogle: UITextField!
    var gs: GoogleSegueClub?
    let signInConfig = GIDConfiguration.init(clientID: "305921896289-684s0ca16d70o2mg2s5hf46dlujjj6fr.apps.googleusercontent.com")
    
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
        let owner = clubRegisterOwner.text!
        let image = imageGoogle.text ?? "default.png"
        
        let club = Clubs(clubName: clubname, clubOwner: owner, clubLogo: image, verified: false, password: password, login: login, description: "", _id: "")
        return club
    }
    
    @IBAction func registerClubGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }
            // If sign in succeeded, display the app's main content View.
            
            let emailAddress = user.profile?.email
           // let fullName = user.profile?.name
                let givenName = user.profile?.givenName
                let familyName = user.profile?.familyName
                let profilePicUrl = user.profile?.imageURL(withDimension: 320)
            let urltoString = profilePicUrl?.absoluteString
            print(emailAddress!)
            
            let clubGoogle = Clubs(clubName: givenName!, clubOwner: "123", clubLogo: urltoString!, verified: true, password: "", login: emailAddress!, description: "", _id: "")
            
            
            
            self.clubRegisteremail.text = emailAddress!
            self.clubRegisterClubName.text = familyName!
            self.imageGoogle.text = urltoString!
            
           // self.performSegue(withIdentifier: "clubGoogleSignup" , sender: clubGoogleStruct)
            
          }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRegisterclub" {
                    let club = sender as! Clubs
                    let destination = segue.destination as! Register2ViewController
                    destination.segueClassClub = club
                    destination.clubCheck = true
                    destination.userCheck = false
                    
                }
        if segue.identifier == "clubGoogleSignup" {
            let clubGoogleStruct = sender as! GoogleSegueClub
            
            let destination = segue.destination as! ClubGoogleCompleteProfileViewController
            destination.clubGoogleSegue = clubGoogleStruct
            
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
