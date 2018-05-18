//
//  MapViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/2.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
  
  @IBOutlet weak var customizeMapView: MKMapView!
  @IBOutlet weak var nearBranchesButton: UIButton!
  @IBOutlet weak var searchRegionButton: UIButton!
  
  var pickerView = UIPickerView()
  var myTextField = UITextField()
  var pickerViewDataArray = [String]()
  
  var contentArray = [String]()
  let locationManager = CLLocationManager()
  var previousCollectionCell: MapViewCollectionViewCell?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    contentArray = [NSLocalizedString("HwataiBranchesTitle", comment: ""),
                    NSLocalizedString("ATMTitle", comment: "")]
    
    setButtonRadious()
    prepareUseUserLocation()
    setPcikerViewAndToolBar()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    self.navigationItem.title = NSLocalizedString("NavigationControllerMapTitle", comment: "");
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func dimissButtonAction(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    myTextField.resignFirstResponder()
    
    searchRegionButton.backgroundColor = .white
    searchRegionButton.setTitleColor(Singleton.sharedInstance().getThemColorR234xG90xB90(), for: .normal)
    searchRegionButton.layer.borderColor = Singleton.sharedInstance().getThemColorR234xG90xB90().cgColor
    
    nearBranchesButton.backgroundColor = .white
    nearBranchesButton.setTitleColor(Singleton.sharedInstance().getThemColorR234xG90xB90(), for: .normal)
    nearBranchesButton.layer.borderColor = Singleton.sharedInstance().getThemColorR234xG90xB90().cgColor
  }
  
  // MARK: - SetButtonRadious
  
  func setButtonRadious() {
    searchRegionButton.layer.cornerRadius = 5
    searchRegionButton.layer.borderWidth = 2
    searchRegionButton.layer.borderColor = Singleton.sharedInstance().getThemColorR234xG90xB90().cgColor
    searchRegionButton.setTitle(NSLocalizedString("RegionSearchTitle", comment: ""), for: .normal)
    
    nearBranchesButton.layer.cornerRadius = 5
    nearBranchesButton.layer.borderWidth = 2
    nearBranchesButton.layer.borderColor = Singleton.sharedInstance().getThemColorR234xG90xB90().cgColor
    nearBranchesButton.setTitle(NSLocalizedString("NearPointTitle", comment: ""), for: .normal)
  }
  
  @IBAction func searchButtonAction(_ sender: Any) {
    myTextField.becomeFirstResponder()

    searchRegionButton.setTitleColor(.white, for: .normal)
    searchRegionButton.layer.borderColor = UIColor.white.cgColor
    searchRegionButton.backgroundColor = Singleton.sharedInstance().getThemColorR234xG90xB90()
    
    nearBranchesButton.backgroundColor = .white
    nearBranchesButton.setTitleColor(Singleton.sharedInstance().getThemColorR234xG90xB90(), for: .normal)
    nearBranchesButton.layer.borderColor = Singleton.sharedInstance().getThemColorR234xG90xB90().cgColor
  
    /*
    let searchControler = UISearchController.init(searchResultsController: nil)
    searchControler.searchBar.delegate = self
    self.present(searchControler, animated: true, completion: nil)*/
  }
  
  @IBAction func nearPointButtonAction(_ sender: Any) {
    myTextField.resignFirstResponder()

    searchRegionButton.backgroundColor = .white
    searchRegionButton.setTitleColor(Singleton.sharedInstance().getThemColorR234xG90xB90(), for: .normal)
    searchRegionButton.layer.borderColor = Singleton.sharedInstance().getThemColorR234xG90xB90().cgColor
    
    nearBranchesButton.setTitleColor(.white, for: .normal)
    nearBranchesButton.layer.borderColor = UIColor.white.cgColor
    nearBranchesButton.backgroundColor = Singleton.sharedInstance().getThemColorR234xG90xB90()
    
    //Get location
    let latitude = 25.034741
    let longitude = 121.524096
    
    //Create annotation
    let annotation = MKPointAnnotation()
    annotation.title = "Hello World!"
    annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
    customizeMapView.addAnnotation(annotation)
    
    //Zooming in on annotation
    let newcoordinate = CLLocationCoordinate2DMake(latitude, longitude)
    let span = MKCoordinateSpanMake(0.1, 0.1)
    let region = MKCoordinateRegionMake(newcoordinate,span)
    customizeMapView.setRegion(region, animated: true)
  }
  
  
  @IBAction func userTrackingModeButtonAction(_ sender: Any) {
    let button = sender as! UIButton
    switch button.tag {
    case 0:
      button.tag = 1
      customizeMapView.userTrackingMode = .none
      button.setImage(UIImage(named: "服務據點_定位"), for: .normal)
      break
    case 1:
      button.tag = 2
      customizeMapView.userTrackingMode = .follow
      button.setImage(UIImage(named: "服務據點_定位_按下"), for: .normal)
      break
    case 2:
      button.tag = 0
      customizeMapView.userTrackingMode = .followWithHeading
      button.setImage(UIImage(named: "服務據點_定位_方向"), for: .normal)
      break
    default:
      break
    }
  }
  
  // MARK: - SetPcikerViewAndToolBar
  
  func setPcikerViewAndToolBar() {
    pickerView.delegate = self
    pickerView.dataSource = self
    pickerViewDataArray = ["台北市","台中市","台南市","高雄"]
    myTextField.inputView = pickerView;
    self.view.addSubview(myTextField)
    
    let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
    toolBar.barTintColor = Singleton.sharedInstance().getThemeColorR226xG75xB91()
    
    let fiexbleSpaceButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
    
    let doneButton = UIBarButtonItem.init(title:
    NSLocalizedString("FinishTitle", comment: ""), style: .done, target: self, action: #selector(doneToSearchRegion))
    doneButton.tintColor = .white
    
    let cancelButton = UIBarButtonItem.init(title:
    NSLocalizedString("RegionSearchTitle", comment: ""), style: .done, target: self, action: #selector(cancelSearchRegion))
    cancelButton.tintColor = .white
    
    toolBar.setItems([cancelButton,fiexbleSpaceButton,doneButton], animated: true)
    
    myTextField.inputAccessoryView = toolBar
  }
  
  @objc func doneToSearchRegion() {
    myTextField.resignFirstResponder()
    
    searchRegionButton.backgroundColor = .white
    searchRegionButton.setTitleColor(Singleton.sharedInstance().getThemColorR234xG90xB90(), for: .normal)
    searchRegionButton.layer.borderColor = Singleton.sharedInstance().getThemColorR234xG90xB90().cgColor
    
    let regionListTableViewController =
      storyboard?.instantiateViewController(withIdentifier: "RegionListTableViewController") as! RegionListTableViewController
    navigationController?.pushViewController(regionListTableViewController, animated: true)
  }
  
  @objc func cancelSearchRegion() {
    //myTextField.resignFirstResponder()
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

// MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
  
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
}

// MARK: - UISearchBarDelegate

extension MapViewController: UISearchBarDelegate {
  
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
  
}

// MARK: - UICollectionViewDataSource

extension MapViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return contentArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let mapViewCollectionViewCell =
      collectionView.dequeueReusableCell(withReuseIdentifier:"MapViewCollectionViewCell",for:indexPath) as! MapViewCollectionViewCell
    
    if(previousCollectionCell == nil) {
      previousCollectionCell = mapViewCollectionViewCell
      
    } else {
      mapViewCollectionViewCell.customizeLabelTitle.textColor = Singleton.sharedInstance().getThemeColorR155xG155xB155()
      mapViewCollectionViewCell.customizeTopLineView.backgroundColor = Singleton.sharedInstance().getThemeColorR155xG155xB155()
    }
    mapViewCollectionViewCell.customizeLabelTitle.text = contentArray[indexPath.item]
    
    return mapViewCollectionViewCell
  }
}

extension MapViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if(previousCollectionCell != nil) {
      UIView.animate(withDuration: 0.5) {
        self.previousCollectionCell?.customizeLabelTitle.textColor = Singleton.sharedInstance().getThemeColorR155xG155xB155()
        self.previousCollectionCell?.customizeTopLineView.backgroundColor = Singleton.sharedInstance().getThemeColorR155xG155xB155()
      }
    }
    
    
    
    let mapViewCollectionViewCell = collectionView.cellForItem(at: indexPath) as! MapViewCollectionViewCell
    UIView.animate(withDuration: 0.5) {
      mapViewCollectionViewCell.customizeLabelTitle.textColor = Singleton.sharedInstance().getThemColorR234xG90xB90()
      mapViewCollectionViewCell.customizeTopLineView.backgroundColor = Singleton.sharedInstance().getThemColorR234xG90xB90()
    }
    
    previousCollectionCell = mapViewCollectionViewCell
  }
}

extension MapViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let selfViewWidth = Int(self.view.frame.width)
    
    return CGSize(width:selfViewWidth/contentArray.count,height:49)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}

// MARK: - UIPickerViewDataSource

extension MapViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerViewDataArray.count
  }
}

extension MapViewController: UIPickerViewDelegate {
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerViewDataArray[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    //..
  }
}
