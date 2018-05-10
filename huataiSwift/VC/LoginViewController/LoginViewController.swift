//
//  LoginViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/4.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  
  var contentArray = [String]()
  var previousCollectionCell: LoginViewCollectionViewCell!
  var loginViewPageViewController: LoginViewPageViewController!
  
  @IBOutlet weak var customizeCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    contentArray = [NSLocalizedString("GeneralLoginTitle", comment:"comment"),
                    NSLocalizedString("QuickLoginTitle", comment:"comment")]
  }
  override func viewWillAppear(_ animated: Bool) {
    self.navigationItem.setHidesBackButton(true, animated:true);
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return contentArray.count > 0 ? contentArray.count : 0
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let loginViewCollectionViewCell =
      collectionView.dequeueReusableCell(withReuseIdentifier:"LoginViewCollectionViewCell",for:indexPath) as! LoginViewCollectionViewCell
    
    if(previousCollectionCell == nil) {
      previousCollectionCell = loginViewCollectionViewCell
      
    } else {
      loginViewCollectionViewCell.customizeTitleLabel.textColor = Singleton.sharedInstance().getThemeColorR140xG140xB143()
      loginViewCollectionViewCell.cusotmzieUnderLineImageView.backgroundColor = Singleton.sharedInstance().getThemeColorR232xG232xB232()
    }
    
    let contentTitle = contentArray[indexPath.item]
    loginViewCollectionViewCell.customizeTitleLabel.text = contentTitle
    
    return loginViewCollectionViewCell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if(previousCollectionCell != nil) {
      UIView.animate(withDuration: 0.3) {
        self.previousCollectionCell?.customizeTitleLabel.textColor = Singleton.sharedInstance().getThemeColorR140xG140xB143()
        self.previousCollectionCell?.cusotmzieUnderLineImageView.backgroundColor = Singleton.sharedInstance().getThemeColorR232xG232xB232()
      }
    }
    
    let loginViewCollectionViewCell = collectionView.cellForItem(at: indexPath) as! LoginViewCollectionViewCell
    UIView.animate(withDuration: 0.3) {
      loginViewCollectionViewCell.customizeTitleLabel.textColor = Singleton.sharedInstance().getThemeColorR207xG18xB37()
      loginViewCollectionViewCell.cusotmzieUnderLineImageView.backgroundColor = Singleton.sharedInstance().getThemeColorR207xG18xB37()
    }
    
    loginViewPageViewController.showPage(index: indexPath.item)
    
    previousCollectionCell = loginViewCollectionViewCell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let selfViewWidth:Int = Int(customizeCollectionView.frame.width)
    let count = contentArray.count
    
    return CGSize(width:selfViewWidth/count,height:26)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // MARK: - Navigation
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if(segue.identifier == "LoginViewPageViewSegue") {
      loginViewPageViewController = segue.destination as! LoginViewPageViewController
    }
  }
  
  
}
