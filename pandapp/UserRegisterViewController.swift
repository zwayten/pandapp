//
//  UserRegisterViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 4/11/2021.
//

import UIKit

class UserRegisterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

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
    
    let pickerOneData = ["1", "2", "3", "4", "5"]
    let pickerTwoData = ["aaa", "C-Programming", "Electronics", "French", "English", "Algorithm", "Arduino"]
    let pickerThreeData = ["1", "2", "3", "4", "5","6","7","8","9","10"]
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
