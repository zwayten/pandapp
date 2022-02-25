//
//  UserRegisterViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 4/11/2021.
//

import UIKit
import GoogleSignIn
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
    @IBOutlet var classFieldOne: UITextField!
    @IBOutlet var classFieldTwo: UITextField!
    @IBOutlet var classFieldThree: UITextField!
    @IBOutlet var claasOnePicker: UIPickerView!
    @IBOutlet var claasTwoPicker: UIPickerView!
    @IBOutlet var claasThreePicker: UIPickerView!
    @IBOutlet var imageGoogle: UITextField!
    
    @IBOutlet var tooltipCardView: UIView!
    
    let pickerOneData = ["1", "2", "3"]
    let pickerTwoData = ["Info", "Genie-Civile"]
    let pickerThreeData = ["1", "2"]
    
    let signInConfig = GIDConfiguration.init(clientID: "305921896289-684s0ca16d70o2mg2s5hf46dlujjj6fr.apps.googleusercontent.com")
    
    var toggleCardTooltip = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ReusableFunctionsViewController.customTextField(textfield: userEmailRegister)
        ReusableFunctionsViewController.customTextField(textfield: passwordUserRegister)
        ReusableFunctionsViewController.customTextField(textfield: passwordConfirmUserregister)
        ReusableFunctionsViewController.customTextField(textfield: lastNameUserRegister)
        ReusableFunctionsViewController.customTextField(textfield: FirstNameUserRegister)
        ReusableFunctionsViewController.customTextField(textfield: identifierUserRegister)
        ReusableFunctionsViewController.customTextField(textfield: classFieldOne)
        ReusableFunctionsViewController.customTextField(textfield: classFieldTwo)
        ReusableFunctionsViewController.customTextField(textfield: classFieldThree)
        
        claasOnePicker.delegate = self
        claasOnePicker.dataSource = self
        claasOnePicker.isHidden = true
        
        claasTwoPicker.delegate = self
        claasTwoPicker.dataSource = self
        claasTwoPicker.isHidden = true
        
        claasThreePicker.delegate = self
        claasThreePicker.dataSource = self
        claasThreePicker.isHidden = true

        classFieldOne.inputView = claasOnePicker
        classFieldTwo.inputView = claasTwoPicker
        classFieldThree.inputView = claasThreePicker
        
        tooltipCardView.frame = CGRect(x: 175, y: 470, width: self.view.bounds.width * 0.5, height: self.view.bounds.height * 0.13)

    }
    
    @IBAction func GoogleSignUp(_ sender: Any) {
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
           
            let userGoogle = User(email: emailAddress!, password:"" , phoneNumber: 123, profilePicture: urltoString!, FirstName: givenName!, LastName: familyName!, verified: true, identifant: "181JMT123", className: "4sim2", role: "user", social: false, description: "oo")
            
            
            let userGoogleStruct = GoogleSegue(user: userGoogle, profilePictureUrl: profilePicUrl!)
            
            self.userEmailRegister.text = emailAddress!
            self.lastNameUserRegister.text = familyName!
            self.FirstNameUserRegister.text = givenName!
            self.imageGoogle.text = urltoString!
            let uploadService = UploadImageService()
            let imageData = try? Data(contentsOf: profilePicUrl!)
            let image = UIImage(data: imageData!)
            
            let headers: HTTPHeaders = [
                //"Authorisation": "bearer \(token!)",
                "Content-type": "multipart/form-data"
            ]
            
                            AF.upload(
                    multipartFormData: { multipartFormData in
                        multipartFormData.append(image!.jpegData(compressionQuality: 0.5)!, withName: "file" , fileName: "file.png", mimeType: "image/png")
                },
                    to: "\(ConnectionDb.baserequest())upload/file", method: .post , headers: headers)
                .responseJSON {  response in
                  print("uploaded")
                    
                }
           // self.performSegue(withIdentifier: "fromUserSignupWithGoogle" , sender: userGoogleStruct)
            
          }
    }
    
    @IBAction func go(_ sender: Any) {
    }
    
    
    @IBAction func displayCardTooltip(_ sender: Any) {
        if toggleCardTooltip == false {
            toggleCardTooltip = true
            self.view.addSubview(tooltipCardView)
        }
        else {
            toggleCardTooltip = false
            tooltipCardView.removeFromSuperview()
        }
    }
    
    func getData() -> User {
        let mail = userEmailRegister.text!
        let password = passwordUserRegister.text!
        
        //passwordConfirmUserregister
        let lastName = lastNameUserRegister.text!
        let firstName = FirstNameUserRegister.text!
        let identifiant = identifierUserRegister.text!
        let class1 = classFieldOne.text!
        let class2 = classFieldTwo.text!
        let class3 = classFieldThree.text!
        let image = imageGoogle.text ?? "default.png"
        let className = "\(class1)\(class2)\(class3)"
        let user = User(email: mail, password: password, phoneNumber: 99, profilePicture: image, FirstName: firstName, LastName: lastName, verified: true, identifant: identifiant, className: className, role: "user", social: false, description: "")
        
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
    

    @IBAction func userConfirmPasswordListener(_ sender: Any) {
        if ReusableFunctionsViewController.validatePassword(textfield: passwordUserRegister, textfieldConfirm: passwordConfirmUserregister) {
            ReusableFunctionsViewController.customTextFieldGreen(textfield: passwordConfirmUserregister)
            ReusableFunctionsViewController.customTextFieldGreen(textfield: passwordUserRegister)
        }
        else {
            ReusableFunctionsViewController.customTextField(textfield: passwordConfirmUserregister)
            ReusableFunctionsViewController.customTextField(textfield: passwordUserRegister)
            
        }
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            classFieldOne.text = pickerOneData[row]
            classFieldOne.resignFirstResponder()
        }
        else if pickerView.tag == 2 {
            classFieldTwo.text = pickerTwoData[row]
            classFieldTwo.resignFirstResponder()
        }
        else {
            classFieldThree.text = pickerThreeData[row]
            classFieldThree.resignFirstResponder()
        }
        
    }

    
    @IBAction func filedoneclick(_ sender: Any) {
        claasOnePicker.isHidden = false
    }
    @IBAction func fieldtwoclick(_ sender: Any) {
        claasTwoPicker.isHidden = false
    }
    
    @IBAction func fieldthreeclick(_ sender: Any) {
        claasThreePicker.isHidden = false
    }
    
  

}
