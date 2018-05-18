//
//  LoginViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/4.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  var contentArray = [String]()
  var previousCollectionCell: LoginViewCollectionViewCell!
  var loginViewPageViewController: LoginViewPageViewController!
  
  @IBOutlet weak var customizeCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    contentArray = [NSLocalizedString("GeneralLoginTitle", comment:"comment"),
                    NSLocalizedString("QuickLoginTitle", comment:"comment")]
    
    NotificationCenter.default.addObserver(self, selector: #selector(popLoginView), name: NSNotification.Name(rawValue: "TestLoginSuccessToPopLoginView"), object: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationItem.setHidesBackButton(true, animated:true);
    self.navigationItem.titleView = UIImageView(image:UIImage(named: "logo"))
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func popLoginView() {
    navigationController?.popViewController(animated: true)
  }
  
  // MARK: - Navigation
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if(segue.identifier == "LoginViewPageViewSegue") {
      loginViewPageViewController = segue.destination as! LoginViewPageViewController
    }
  }
}

extension LoginViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return contentArray.count
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
}

extension LoginViewController: UICollectionViewDelegate {
  
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
    previousCollectionCell = loginViewCollectionViewCell
    
    loginViewPageViewController.showPage(index: indexPath.item)
  }
}

extension LoginViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width:Int(customizeCollectionView.frame.width)/contentArray.count,height:26)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
