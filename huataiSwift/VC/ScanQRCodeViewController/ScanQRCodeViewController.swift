//
//  ScanQRCodeViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/3.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit
import AVFoundation

class ScanQRCodeViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {

    var qrCodeFrameView:UIView!
    var captureSession:AVCaptureSession!
    var videoPreviewLayer:AVCaptureVideoPreviewLayer!
    
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var downImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var effectiveScanningRangeView: EffectiveScanningRangeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareScanView()
    }
    
    func prepareScanView() {
        /*準備偵測掃描顯示範圍框架
        qrCodeFrameView = UIView()
        qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
        qrCodeFrameView.layer.borderWidth = 2*/
        
        captureSession = AVCaptureSession()
        let device = AVCaptureDevice.default(for:.video)
        do {
            let input = try AVCaptureDeviceInput.init(device: device!)
            if (captureSession.canAddInput(input)) {
                captureSession.addInput(input)
            }
            
        } catch {
            print("AVCaptureDeviceInput Error --> \(error)")
            return
        }
        
        let output = AVCaptureMetadataOutput()
        if(captureSession.canAddOutput(output)) {
            captureSession.addOutput(output)
            
            output.rectOfInterest = CGRect(x:0.2, y:0.25, width:0.5, height:0.5)
            output.setMetadataObjectsDelegate(self, queue:DispatchQueue.main)
            output.metadataObjectTypes = [.qr]
        } else {
            return
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer.init(session: captureSession)
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.frame = self.view.bounds
        self.view.layer.addSublayer(videoPreviewLayer)
        self.view.addSubview(topImageView)
        self.view.addSubview(downImageView)
        self.view.addSubview(leftImageView)
        self.view.addSubview(rightImageView)
        captureSession.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else {return}
            guard let stringValue = readableObject.stringValue else { return }
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            print(stringValue)
            
            //captureSession.stopRunning()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
