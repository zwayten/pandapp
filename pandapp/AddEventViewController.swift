//
//  AddEventViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 8/11/2021.
//

import UIKit

class AddEventViewController: UIViewController {

    
    @IBOutlet var eventPriceInput: UITextField!
    @IBOutlet var eventNameInput: UITextField!
    @IBOutlet var eventDateInput: UITextField!
    @IBOutlet var eventTimeInput: UITextField!
    @IBOutlet var eventDatePicker: UIDatePicker!
    @IBOutlet var eventTimePicker: UIDatePicker!
    
    override func viewDidLoad() {
        ReusableFunctionsViewController.customTextField(textfield: eventNameInput)
        ReusableFunctionsViewController.customTextField(textfield: eventPriceInput)
        ReusableFunctionsViewController.customTextField(textfield: eventDateInput)
        ReusableFunctionsViewController.customTextField(textfield: eventTimeInput)

        eventDatePicker.isHidden = true
        eventTimePicker.isHidden = true
        
        eventDateInput.inputView = eventDatePicker
        eventTimeInput.inputView = eventTimePicker
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func displayDtaePicker(_ sender: Any) {
        eventDatePicker.isHidden = false
    }
    
    @IBAction func displayTimePicker(_ sender: Any) {
        eventTimePicker.isHidden = false
    }
    
    @IBAction func dateSelectedFromDatePicker(_ : AnyObject) {
        let formater = DateFormatter()
        formater.dateFormat = "dd-MM-yyyy"
        eventDateInput.text = formater.string(from:eventDatePicker.date)
    }
    
    @IBAction func timeSelectedFromDatePicker(_ : AnyObject) {
        let formater = DateFormatter()
        formater.dateFormat = "hh-MM-A"
        eventTimeInput.text = formater.string(from:eventTimePicker.date)
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
