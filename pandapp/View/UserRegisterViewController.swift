//
//  UserRegisterViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 4/11/2021.
//

import UIKit
import Alamofire

class UserRegisterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var gs: GoogleSegue?
    var testgoogle: Bool?
    @IBOutlet var userEmailRegister: UITextField!
    @IBOutlet var passwordUserRegister: UITextField!
    @IBOutlet var passwordConfirmUserregister: UITextField!
    @IBOutlet var lastNameUserRegister: UITextField!
    @IBOutlet var FirstNameUserRegister: UITextField!
    @IBOutlet var identifierUserRegister: UITextField!
    
    @IBOutlet var classFieldTwo: UITextField!
    
    @IBOutlet var imageGoogle: UITextField!
    
    
    
    let pickerOneData = ["1", "2", "3"]
    let pickerTwoData = ["Info", "Genie-Civile"]
    let pickerThreeData = ["1", "2"]
    

    var toggleCardTooltip = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        
        
        
        
        

    }
    
  
    
    @IBAction func go(_ sender: Any) {
    }
    
    
    
    
    func getData() -> User {
        let mail = userEmailRegister.text!
        let password = passwordUserRegister.text!
        
        //passwordConfirmUserregister
        let lastName = lastNameUserRegister.text!
        let firstName = FirstNameUserRegister.text!
        let identifiant = identifierUserRegister.text!
        
        let class2 = classFieldTwo.text!
        
        
        
        let user = User(email: mail, password: password, phoneNumber: 99, profilePicture: "default.png", FirstName: firstName, LastName: lastName, verified: true, identifant: identifiant, className: class2, role: "user", social: false, description: "")
        
        return user
       
    }
    
    @IBAction func btnregister(_ sender: Any) {
        if passwordUserRegister.text == passwordConfirmUserregister.text {
        let user = getData()
        performSegue(withIdentifier: "toRegister2", sender: user)
        }
        else {
            ReusableFunctionsViewController.displayAlert(title: "Invalid Credentials", subTitle: "Your credentials are invalid")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRegister2" {
                    let user = sender as! User
                    let destination = segue.destination as! Register2ViewController
                    destination.segueClass = user
                    destination.clubCheck = false
                    destination.userCheck = true
                    
                }
        if segue.identifier == "fromUserSignupWithGoogle" {
            let userGoogleStruct = sender as! GoogleSegue
            
            let destination = segue.destination as! CompleteYourProfileViewController
            destination.userGoogleSegue = userGoogleStruct
            
        }
    }
    
    // Toggle view/hide password field
    @IBAction func passwordShowHideUserRegister(_ sender: Any) {
        passwordUserRegister.isSecureTextEntry.toggle()
    }
    // Toggle view/hide ConfirmPassword field
    @IBAction func passwordConfirmShowHideUserRegister(_ sender: Any) {
        passwordConfirmUserregister.isSecureTextEntry.toggle()
    }
    

 
    
    override func didReceiveMemoryWarning() {
        
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }

       // Number of columns of data
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       // The number of rows of data
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           if pickerView.tag == 1 {
               return pickerOneData.count
           }
           else if pickerView.tag == 2 {
               return pickerTwoData.count
           }
           else {
               return pickerThreeData.count
           }
       }
       
       // The data to return fopr the row and component (column) that's being passed in
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           if pickerView.tag == 1 {
               return pickerOneData[row]
           }
           else if pickerView.tag == 2 {
               return pickerTwoData[row]
           }
           else {
               return pickerThreeData[row]
           }
       }
    
   
    
  

}
