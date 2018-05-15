//
//  QRCodeScanViewController.swift
//  huataiSwift
//
//  Created by 李昀 on 2018/5/11.
//  Copyright © 2018 U-Sync. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

  var captureSession: AVCaptureSession!
  var previewLayer: AVCaptureVideoPreviewLayer!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.black
    qrcodeScanner()
    addUI()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func qrcodeScanner(){
    captureSession = AVCaptureSession()

    guard let videoCaptureDevice =  AVCaptureDevice.default(for: .video) else { return }
    let videoInput: AVCaptureDeviceInput
    
    do {
      videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
    } catch {
      return
    }
    
    if (captureSession.canAddInput(videoInput)) {
      captureSession.addInput(videoInput)
    } else {
      failed()
      return
    }
    
    let metadataOutput = AVCaptureMetadataOutput()
    
    if (captureSession.canAddOutput(metadataOutput)) {
      captureSession.addOutput(metadataOutput)
      
      metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
      metadataOutput.metadataObjectTypes = [.qr]
    } else {
      failed()
      return
    }
    
    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer.frame = view.layer.bounds
    previewLayer.videoGravity = .resizeAspectFill
    view.layer.addSublayer(previewLayer)
    
    captureSession.startRunning()
  }
  
  func addUI() {
    addDescriptionLabelUI()
    addFocusImageView()
  }
  
  func addDescriptionLabelUI(){
    
    let descriptionLabel = UILabel()
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

    descriptionLabel.backgroundColor = nil
    descriptionLabel.text = "對準QRCode後，即能自動讀取"
    descriptionLabel.font = UIFont(name: "PingFangTC-Semibold", size: 14.0)
    descriptionLabel.textColor = UIColor.white
    descriptionLabel.textAlignment = .center
    
    descriptionLabel.layer.cornerRadius = 25.0
    descriptionLabel.layer.borderWidth = 1.0
    descriptionLabel.layer.borderColor = UIColor.white.cgColor

    let centerX = NSLayoutConstraint(item: descriptionLabel,
                                     attribute: .centerX,
                                     relatedBy: .equal,
                                     toItem: self.view,
                                     attribute: .centerX,
                                     multiplier: 1.0,
                                     constant: 0.0)
    
    let bottom = NSLayoutConstraint(item: descriptionLabel,
                                     attribute: .bottom,
                                     relatedBy: .equal,
                                     toItem: self.view,
                                     attribute: .bottom,
                                     multiplier: 1.0,
                                     constant: -55.0)
    
    let height = NSLayoutConstraint(item: descriptionLabel,
                                    attribute: .height,
                                    relatedBy: .equal,
                                    toItem: nil,
                                    attribute: .notAnAttribute,
                                    multiplier: 1.0,
                                    constant: 45.0)
    
    NSLayoutConstraint(item: descriptionLabel,
                       attribute: .width,
                       relatedBy: .equal,
                       toItem: nil,
                       attribute: .notAnAttribute,
                       multiplier: 1.0,
                       constant: 276.0).isActive = true
    
    
    self.view.addSubview(descriptionLabel)

    NSLayoutConstraint.activate([centerX, bottom, height])
  }
  
  func addFocusImageView(){
    let focusImageView = UIImageView()
    focusImageView.translatesAutoresizingMaskIntoConstraints = false
    
    focusImageView.image = UIImage(named: "ic_掃描qr")
    
    let top = NSLayoutConstraint(item: focusImageView,
                                 attribute: .top,
                                 relatedBy: .equal,
                                 toItem: self.view,
                                 attribute: .top,
                                 multiplier: 1.0,
                                 constant: 130.0)
    
    let centerX = NSLayoutConstraint(item: focusImageView,
                                   attribute: .centerX,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .centerX,
                                   multiplier: 1.0,
                                   constant: 0.0)

    let height = NSLayoutConstraint(item: focusImageView,
                                   attribute: .height,
                                   relatedBy: .equal,
                                   toItem: nil,
                                   attribute: .notAnAttribute,
                                   multiplier: 1.0,
                                   constant: 280.0)
    
    let width = NSLayoutConstraint(item: focusImageView,
                                   attribute: .width,
                                   relatedBy: .equal,
                                   toItem: nil,
                                   attribute: .notAnAttribute,
                                   multiplier: 1.0,
                                   constant: 280.0)

  
    
    self.view.addSubview(focusImageView)
    NSLayoutConstraint.activate([top, centerX, width, height])
  }
  
  func failed() {
    let ac = UIAlertController(title: "不支援掃描", message: "您的裝置不支援掃描，請使用允許照相機掃描的裝置。", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "確認", style: .default))
    present(ac, animated: true)
    captureSession = nil
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if (captureSession?.isRunning == false) {
      captureSession.startRunning()
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    if (captureSession?.isRunning == true) {
      captureSession.stopRunning()
    }
  }
  
  func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    captureSession.stopRunning()
    
    if let metadataObject = metadataObjects.first {
      guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
      guard let stringValue = readableObject.stringValue else { return }
      AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
      found(code: stringValue)
    }
    
    dismiss(animated: true)
  }
  
  func found(code: String) {
    print(code)
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .portrait
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
