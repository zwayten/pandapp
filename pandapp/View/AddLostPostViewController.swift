//
//  AddLostPostViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 28/11/2021.
//

import UIKit

class AddLostPostViewController: UIViewController {

    @IBOutlet var typelbl: UITextField!
    @IBOutlet var placelbl: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var objectlbl: UITextField!
    
    var selectedImages : UIImage?
    var imageJsonReturnAf  = ""
    var currSegue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        typelbl.text = currSegue!
    }
    
    
   
    
    
    func getdata() -> LostPost {
        let typelost = typelbl.text!
        let placelost = placelbl.text!
        let objectlost = objectlbl.text!
        let userName = UserDefaults.standard.string(forKey: "userName")
        let lostpost = LostPost(publisheId: userName!, state: false, type: typelost, object: objectlost, place: placelost, image: "default.png")
        return lostpost
    }

    @IBAction func getImage(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func savelostPost(_ sender: Any) {
        
            let uploadService = UploadImageService()
            uploadService.uploadImageToServerLostPost(imageOrVideo: selectedImages, lostPost: getdata())
       
        
       
    }
    
}
extension AddLostPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
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
