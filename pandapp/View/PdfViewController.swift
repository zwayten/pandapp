//
//  PdfViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 28/11/2021.
//

import UIKit
import PDFKit

class PdfViewController: UIViewController {

    var fileSegue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pdfView = PDFView(frame: self.view.bounds)
                self.view.addSubview(pdfView)

                // Fit content in PDFView.
                pdfView.autoScales = true

                // Load Sample.pdf file.
                //let fileURL = Bundle.main.url(forResource: "Sample", withExtension: "pdf")
        let stringUrl = "http://192.168.109.1:3000/upload/download/\(fileSegue!)"
        let fileURL = URL(string: stringUrl)
                pdfView.document = PDFDocument(url: fileURL!)
            }
        
    

}
