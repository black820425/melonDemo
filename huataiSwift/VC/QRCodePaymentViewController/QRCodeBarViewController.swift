//
//  QRCodeBarViewController.swift
//  huataiSwift
//
//  Created by 李昀 on 2018/5/11.
//  Copyright © 2018 U-Sync. All rights reserved.
//

import UIKit

class QRCodeBarViewController: UIViewController {
  
  @IBOutlet weak var qrcodeImageView: UIImageView!
  override func viewDidLoad() {
    super.viewDidLoad()
    qrcodeImageView.image = generateQRCode(from: "url://YOU.Know")
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func generateQRCode(from string: String) -> UIImage? {
    let data = string.data(using: String.Encoding.ascii)
    
    if let filter = CIFilter(name: "CIQRCodeGenerator") {
      filter.setValue(data, forKey: "inputMessage")
      filter.setValue("H", forKey: "inputCorrectionLevel")
      let transform = CGAffineTransform(scaleX: 3, y: 3)
      
      if let output = filter.outputImage?.transformed(by: transform) {
        return UIImage(ciImage: output)
      }
    }
    
    return nil
  }

  
  @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
    _ = navigationController?.popViewController(animated: true)
  }
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
