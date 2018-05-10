//
//  ViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/4/4.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit
import LocalAuthentication

var menuView:UIView?
var fullScreenBounds:CGRect?
var menuViewOriginX:CGFloat?
var menuViewOriginY:CGFloat?

var panGestureRecognizer:UIPanGestureRecognizer?

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullScreenBounds = UIScreen.main.bounds;
        setCustomizeMenuView()
        setCustomizeTableView()
        setCustomziePanGestureRecognizer()
//        let proejectAPI = ProjectAPI()
//        proejectAPI.connectAPIWithUrl { (array) in
//            //..
//        }
    }
    
    func encryptUseDES2(plainText:String) {
//        var ciphertext:String?
//        var textBytes:Character = []
    }
    
    @IBAction func callCustomizeSliderMenuButtonAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            menuView?.center = CGPoint(x:menuViewOriginX!, y:menuViewOriginY!)
        }
    }
    
    // MARK: - prepare TableView Delegate And DataSource.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "Menu")
        tableViewCell.textLabel?.text = "Hello"
        
        return tableViewCell
    }
    
    func setCustomizeMenuView() {
        let statusBarWindow : UIView = UIApplication.shared.value(forKey: "statusBarWindow") as! UIView
        let statusBar : UIView = statusBarWindow.value(forKey: "statusBar") as! UIView
        let window:UIWindow = ((UIApplication.shared.delegate?.window)!)!
        
        menuView = UIView.init(frame: CGRect(x: 0, y: statusBar.frame.size.height, width: 300, height:self.view.frame.size.height-statusBar.frame.size.height))
        menuView?.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        window.addSubview(menuView!)

        menuViewOriginX = menuView?.center.x
        menuViewOriginY = menuView?.center.y
        
        menuView?.center = CGPoint(x:-((fullScreenBounds?.width)!/2), y:menuViewOriginY!)
    }
    
    func setCustomizeTableView() {
        let customizeTableView = UITableView.init(frame: CGRect(x: 0, y: 44, width: (menuView?.frame.size.width)!, height: (menuView?.frame.size.height)!-44))
        customizeTableView.delegate = self
        customizeTableView.dataSource = self
        customizeTableView.separatorStyle = .none
        menuView?.addSubview(customizeTableView)
    }
    
    func setCustomziePanGestureRecognizer() {
        //panGestureRecognizer = UIPanGestureRecognizer.init(target: self, action:Selector)
        panGestureRecognizer = UIPanGestureRecognizer.init(target: self, action:#selector(handlePan))
        
        menuView?.addGestureRecognizer(panGestureRecognizer!)
    }
    
    @objc func handlePan(recognizer:UIPanGestureRecognizer) {
        let transition:CGPoint = recognizer.translation(in: menuView)
        var x = ((menuView?.center.x)! + transition.x*0.5)
        
        if let value = menuViewOriginX {
            if(x > value) {
                x = value;
            }
        }
        menuView?.center = CGPoint(x:x,y:menuViewOriginY!)

        if(recognizer.state == .ended) {
            UIView.animate(withDuration: 0.3) {
                if(x < 0.0) {
                    menuView?.center = CGPoint(x:-((fullScreenBounds?.width)!/2), y:menuViewOriginY!)
                
                } else {
                    menuView?.center = CGPoint(x:menuViewOriginX!, y:menuViewOriginY!)
                }
            }
        }
    }
    
//    - (void)handlePan:(UIPanGestureRecognizer *)recognizer {
//    CGPoint translation =  [recognizer translationInView:self.customizeSliderLeftMenuView];
//    float x = self.customizeSliderLeftMenuView.center.x + translation.x;
//
//    if(x > self.customizeSliderLeftMenuViewOriginX) {
//    x = self.customizeSliderLeftMenuViewOriginX;
//    }
//    self.customizeSliderLeftMenuView.center = CGPointMake(x,self.customizeSliderLeftMenuViewOriginY);
//
//    if(recognizer.state == UIGestureRecognizerStateEnded) {
//    [UIView animateWithDuration:0.3 animations:^{
//    if(x < 0.0) {
//    self.customizeSliderLeftMenuView.center = CGPointMake(-(self.fullScreenBounds.size.width/2),self.customizeSliderLeftMenuViewOriginY);
//
//    self.maskMainView.alpha = 0.0;
//    } else {
//    self.customizeSliderLeftMenuView.center = CGPointMake(self.customizeSliderLeftMenuViewOriginX,self.customizeSliderLeftMenuViewOriginY);
//    self.maskMainView.alpha = 0.4;
//    }
//    }];
//    }
//    }
    
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

