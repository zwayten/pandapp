//
//  PasswordResetViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 5/11/2021.
//

import UIKit
import Alamofire

class PasswordResetViewController: UIViewController {

    @IBOutlet var sendMailLabel: UILabel!
    @IBOutlet var sendSmsLabel: UILabel!
    @IBOutlet var emailRecovery: UITextField!
    @IBOutlet var mailRadio: UIButton!
    
    
    @IBOutlet var smsRadion: UIButton!
    
    
    
    func initRadioButtons(){
        ReusableFunctionsViewController.radioButtonToggleOn(radionButton: mailRadio, radioText: sendMailLabel)
        ReusableFunctionsViewController.radioButtonToggleOff(radionButton: smsRadion, radioText: sendSmsLabel)
        sendSmsLabel.text = "Send reset code via phone number"
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        ReusableFunctionsViewController.customTextField(textfield: emailRecovery)
        initRadioButtons()
        // Do any additional setup after loading the view.
    }
    
    func sendResetCode(loginemail: String){
        //var logg: LoginUser
        let parameters = ["email": loginemail] as [String : Any]
        AF.request("\(ConnectionDb.baserequest())auth/reset", method: .post, parameters: parameters).responseJSON {  response in
            
            
            let _: String = try! JSONDecoder().decode(String.self, from: response.data!)
                
            
        }
}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCode" {
                    let mail = sender as! String
                    let destination = segue.destination as! ResetTwoViewController
                    destination.seguemail = mail
                    
                    
                }
    }
    
    
    
    @IBAction func submit(_ sender: Any) {
        let email = emailRecovery.text
        sendResetCode(loginemail: email!)
        
        
        performSegue(withIdentifier: "toCode", sender: emailRecovery.text)
        
    }
    @IBAction func toggleOnMail(_ sender: Any) {
        ReusableFunctionsViewController.radioButtonToggleOn(radionButton: mailRadio, radioText: sendMailLabel)
        ReusableFunctionsViewController.radioButtonToggleOff(radionButton: smsRadion, radioText: sendSmsLabel)
    }
    
    @IBAction func toggleOnSms(_ sender: Any) {
        ReusableFunctionsViewController.radioButtonToggleOn(radionButton: smsRadion, radioText: sendSmsLabel)
        ReusableFunctionsViewController.radioButtonToggleOff(radionButton: mailRadio, radioText: sendMailLabel)
    
    }
    

}
