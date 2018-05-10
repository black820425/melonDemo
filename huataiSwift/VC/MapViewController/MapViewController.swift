//
//  MapViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/2.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,CLLocationManagerDelegate,UISearchBarDelegate,
UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  
  var contentArray = [String]()
  let locationManager = CLLocationManager()
  
  var previousCollectionCell:MapViewCollectionViewCell?
  
  @IBOutlet weak var customizeMapView: MKMapView!
  @IBOutlet weak var nearBranchesButton: UIButton!
  @IBOutlet weak var searchRegionButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    contentArray = ["華泰分行","ATM"]
    prepareUseUserLocation()
    setButtonRadious()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationItem.title = NSLocalizedString("NavigationControllerMapTitle", comment: "");
  }
  
  @IBAction func searchButtonAction(_ sender: Any) {
    let searchControler = UISearchController.init(searchResultsController: nil)
    searchControler.searchBar.delegate = self
    self.present(searchControler, animated: true, completion: nil)
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    let searchRequest = MKLocalSearchRequest()
    searchRequest.naturalLanguageQuery = searchBar.text
    let activeSearch = MKLocalSearch.init(request: searchRequest)
    
    activeSearch.start { (response, error) in
      if(error != nil) {
        return
        
      } else {
        //Remove annotation
        self.customizeMapView.removeAnnotations(self.customizeMapView.annotations)
        //Get location
        if let latitude = response?.boundingRegion.center.latitude {
          if let longitude = response?.boundingRegion.center.longitude {
            
            //Create annotation
            let annotation = MKPointAnnotation()
            annotation.title = searchBar.text
            annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            self.customizeMapView.addAnnotation(annotation)
            //Zooming in on annotation
            let newcoordinate = CLLocationCoordinate2DMake(latitude, longitude)
            let span = MKCoordinateSpanMake(0.1, 0.1)
            let region = MKCoordinateRegionMake(newcoordinate, span)
            self.customizeMapView.setRegion(region, animated: true)
          }
        }
        self.dismiss(animated:true, completion: nil)
      }
    }
  }
  
  @IBAction func dimissButtonAction(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return contentArray.count > 0 ? contentArray.count : 0
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let mapViewCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:"MapViewCollectionViewCell",for:indexPath) as! MapViewCollectionViewCell
    
    if(previousCollectionCell == nil) {
      previousCollectionCell = mapViewCollectionViewCell
      
    } else {
      mapViewCollectionViewCell.customizeLabelTitle.textColor = Singleton.sharedInstance().getGrayColor()
      mapViewCollectionViewCell.customizeTopLineView.backgroundColor = Singleton.sharedInstance().getGrayColor()
    }
    
    mapViewCollectionViewCell.customizeLabelTitle.text = contentArray[indexPath.item]
    
    
    return mapViewCollectionViewCell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if(previousCollectionCell != nil) {
      UIView.animate(withDuration: 0.5) {
        self.previousCollectionCell?.customizeLabelTitle.textColor = Singleton.sharedInstance().getGrayColor()
        self.previousCollectionCell?.customizeTopLineView.backgroundColor = Singleton.sharedInstance().getGrayColor()
      }
    }
    let mapViewCollectionViewCell = collectionView.cellForItem(at: indexPath) as! MapViewCollectionViewCell
    UIView.animate(withDuration: 0.5) {
      mapViewCollectionViewCell.customizeLabelTitle.textColor = Singleton.sharedInstance().getThemColorR234xG90xB90()
      mapViewCollectionViewCell.customizeTopLineView.backgroundColor = Singleton.sharedInstance().getThemColorR234xG90xB90()
    }
    
    previousCollectionCell = mapViewCollectionViewCell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let selfViewWidth:Int = Int(self.view.frame.width)
    
    if(contentArray.count > 0) {
      return CGSize(width:selfViewWidth/contentArray.count,height:49)
    }
    
    return CGSize(width:0,height:0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func prepareUseUserLocation() {
    //給授權者
    locationManager.delegate = self;
    //詢問使用者
    locationManager.requestAlwaysAuthorization()
    //設定準確性
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    //設定類型
    locationManager.activityType = .otherNavigation
    //准許於背景執行
    //locationManager.allowsBackgroundLocationUpdates = true
    //開始回報位置
    locationManager.startUpdatingLocation()
    //追蹤座標模式
    customizeMapView.userTrackingMode = .follow
  }
  
  func setButtonRadious() {
    searchRegionButton.layer.cornerRadius = 5
    searchRegionButton.layer.borderWidth = 2
    searchRegionButton.layer.borderColor = UIColor.white.cgColor
    
    nearBranchesButton.layer.cornerRadius = 5
    nearBranchesButton.layer.borderWidth = 2
    nearBranchesButton.layer.borderColor =
      UIColor(red: 234.0/255.0, green: 90.0/255.0, blue: 90.0/255.0, alpha: 1.0).cgColor
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
