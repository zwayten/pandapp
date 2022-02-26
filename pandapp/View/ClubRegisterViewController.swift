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
        let club = Clubs(clubName: clubname, clubOwner: owner, clubLogo: "default.png", verified: false, password: password, login: login, description: "", _id: "")
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
