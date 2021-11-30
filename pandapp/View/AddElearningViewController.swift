//
//  AddElearningViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 27/11/2021.
//

import UIKit
import MobileCoreServices

class AddElearningViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    

    let modulesFirstYearInfo  = ["Mathematics", "French", "English", "C-Programing", "Electronics", "Multimedia", "System & Network"]
    let modulesSecondYearInfo  = ["Mathematics", "French", "English", "C++-Programing","Web-Developpement" ,"Communication-Network", "Database", "Microncontroller-Architecture"]
    let modulesThirdYearInfo  = ["Mathematics", "French", "English", "Java-Programing","Web-Developpement 2.0" ,"Network", "Database", "Finance","Mobile-Programming"]
    
    let pickerData = ["Mathematics", "French", "English", "C-Programing", "Electronics", "Multimedia", "System & Network"]
    
    var dataPdf: Data?
    
    @IBOutlet var courseNameInput: UITextField!
    @IBOutlet var moduleInput: UITextField!
    @IBOutlet var classNameInput: UITextField!

    @IBOutlet var pickerModule: UIPickerView!
    
    
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        ReusableFunctionsViewController.customTextField(textfield: courseNameInput)
        ReusableFunctionsViewController.customTextField(textfield: moduleInput)
        ReusableFunctionsViewController.customTextField(textfield: classNameInput)
        //pickerData = modulesFirstYearInfo
        pickerModule.delegate = self
        pickerModule.dataSource = self
        pickerModule.isHidden = true
        
        moduleInput.inputView = pickerModule
        

        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func modulechangeValuelistener(_ sender: UITextField) {
        pickerModule.isHidden = false
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
    
    override func didReceiveMemoryWarning() {
        print("ooooooooooooooooooooooooooo")
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
            return pickerData.count
        
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
       
            print("mochkla ########################")
            return pickerData[row]
        
        
       
    }
 
 func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     
         moduleInput.text = pickerData[row]
         moduleInput.resignFirstResponder()
     
   
     
     
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
