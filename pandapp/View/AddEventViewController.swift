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
    @IBOutlet var eventDescriptionInput: UITextView!
    @IBOutlet var eventPlaceInput: UITextField!
    @IBOutlet var imageView: UIImageView!
    
    var selectedImages : UIImage?
    var imageJsonReturnAf  = ""
    
    override func viewDidLoad() {
      

        eventDatePicker.isHidden = true
        eventTimePicker.isHidden = true
        
        eventDateInput.inputView = eventDatePicker
        eventTimeInput.inputView = eventTimePicker
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func uploadImage(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    
    func getData() -> EventPost {
        let eventname = eventNameInput.text!
        let price = eventPriceInput.text!
        //let date = eventDateInput.text!
        let time =  eventTimeInput.text!
        let description =  eventDescriptionInput.text!
        let place = eventPlaceInput.text!
        let cName = UserDefaults.standard.string(forKey: "clubName")
        let event = EventPost(publisheId: cName!, state: true, type: "Event", place: place, banner: "default.png", Time: time, price: Double(price) ?? 14.4, rate: 0, title: eventname, description: description,_id: "")
        return event
    }
    
    
    @IBAction func btnsaveEvent(_ sender: UIButton) {
       
        
        let uploadService = UploadImageService()
        let event = getData()
        uploadService.uploadImageToServer(imageOrVideo: selectedImages, eventPost: event)
       
        //eventPostModel.addEventPost(eventPost: event)
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
   
    

}
extension AddEventViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageView.image = image
            selectedImages = image
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
