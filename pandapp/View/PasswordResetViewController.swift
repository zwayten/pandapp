//
//  PasswordResetViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 5/11/2021.
//

import UIKit

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
    
    @IBAction func toggleOnMail(_ sender: Any) {
        ReusableFunctionsViewController.radioButtonToggleOn(radionButton: mailRadio, radioText: sendMailLabel)
        ReusableFunctionsViewController.radioButtonToggleOff(radionButton: smsRadion, radioText: sendSmsLabel)
    }
    
    @IBAction func toggleOnSms(_ sender: Any) {
        ReusableFunctionsViewController.radioButtonToggleOn(radionButton: smsRadion, radioText: sendSmsLabel)
        ReusableFunctionsViewController.radioButtonToggleOff(radionButton: mailRadio, radioText: sendMailLabel)
    
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
