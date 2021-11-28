//
//  AddElearningViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 27/11/2021.
//

import UIKit
import MobileCoreServices

class AddElearningViewController: UIViewController {

    var dataPdf: Data?
    
    @IBOutlet var courseNameInput: UITextField!
    @IBOutlet var moduleInput: UITextField!
    @IBOutlet var classNameInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func getdata() -> Elearning {
        let classname = classNameInput.text!
        let module = moduleInput.text!
        let coursename = courseNameInput.text!
        
        let course = Elearning(publisheId: "me", publishedAt: "", className: classname, module: module, courseName: coursename, courseFile: "default.pdf")
        return course
    }
    
    @IBAction func sendPdf(_ sender: Any) {
        let uploadService = UploadImageService()
        uploadService.uploadFileToServer(pdf: dataPdf, elearning: getdata())
    }
    @IBAction func openDocPicker(_ sender: Any) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePlainText as String], in: .import)
                documentPicker.delegate = self
                documentPicker.allowsMultipleSelection = false
                present(documentPicker, animated: true, completion: nil)
       
    }
    
    

}
extension AddElearningViewController: UIDocumentPickerDelegate {
    
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let selectedFileURL = urls.first else {
            return
        }
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = dir.appendingPathComponent(selectedFileURL.lastPathComponent)
        
       
            
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                print(selectedFileURL)
                for url in urls {
                            dataPdf = try Data(contentsOf: url)
                    
                        }
               
               // controller.dismiss(animated: true, completion: nil)
                print("Copied file!")
            }
            catch {
                print("Error: \(error)")
            
        }
    }
    }
