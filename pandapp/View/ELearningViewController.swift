//
//  ELearningViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 7/11/2021.
//

import UIKit

class ELearningViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
   
    @IBOutlet var gradelbl: UITextField!
    @IBOutlet var modulePicker: UIPickerView!
    
    let grades = ["First Grade", "Second Grade", "Third Grade", "Fourth Grade", "Last Grade"]
    let gradesBusiness = ["First Grade", "Second Grade", "Third Grade"]
    let specialites = ["it","business","prepa","electromeca","genicivile"]
    
    var gradeString = "First Grade"
    
    override func viewDidLoad() {
        
        
        
        modulePicker.delegate = self
        modulePicker.dataSource = self
        modulePicker.isHidden = true
        
        gradelbl.inputView = modulePicker

        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
           return grades.count
       }
       
       // The data to return fopr the row and component (column) that's being passed in
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return grades[row]
       }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
            gradelbl.text = grades[row]
            gradeString = grades[row]
            gradelbl.resignFirstResponder()
        
        
        
    }
    
    @IBAction func fsd(_ sender: UITextField) {
        modulePicker.isHidden = false
    }
    

    

}
extension ELearningViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return specialites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "elearningCell", for: indexPath)
        
        let contentView = cell.contentView.viewWithTag(1)
        
        let image = contentView!.viewWithTag(2) as! UIImageView
        let modulesCount = contentView!.viewWithTag(3) as! UILabel
        let filesCount = contentView!.viewWithTag(4) as! UILabel
        
        
        image.image = UIImage(named: specialites[indexPath.row])
        modulesCount.text = "45 learning modules"
        filesCount.text = "45 files uploaded"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let index = indexPath
        performSegue(withIdentifier: "toLearningModules", sender: index)
    
}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toLearningModules" {
                let index = sender as! IndexPath
                let destination = segue.destination as! ModuleElearningViewController
                destination.gradeSegue = grades[index.row]
                destination.branchSegue = specialites[index.row]
            }
        }

}
