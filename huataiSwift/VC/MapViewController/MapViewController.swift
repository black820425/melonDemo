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
  @IBOutlet weak var routeCollectionView: UICollectionView!
  
  var height:CGFloat!
  
  var pickerView = UIPickerView()
  var myTextField = UITextField()
  var pickerViewDataArray = [String]()
  
  var contentBranchTitleArray = [String]()
  var contentRouteTitleArray = [String]()
  let locationManager = CLLocationManager()
  
  //  var userLocation: MKUserLocation()
  var directionResponse = MKDirectionsResponse()
  var destinationCoordinate = CLLocationCoordinate2D()
  
  var previousCollectionCell: MapViewCollectionViewCell?
  var routePrevioudCollectionViewCell: RouteCollectionViewCell?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    contentRouteTitleArray = ["汽車","步行","公車"]
    
    contentBranchTitleArray = [
      LanguageTool.sharedInstance().customzieLocalizedString(key: "MapViewController_HwataiBranchesTitle", commit: ""),
      LanguageTool.sharedInstance().customzieLocalizedString(key: "MapViewController_ATMTitle", commit: "")]

    setButtonRadious()
    prepareUseUserLocation()
    setPcikerViewAndToolBar()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    self.navigationItem.title = LanguageTool.sharedInstance().customzieLocalizedString(key: "NavigaitonControllerTitle_MapTitle", commit: "")
  }
  
  override func viewDidLayoutSubviews() {
    height = UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.height
    routeCollectionView.frame = CGRect(x: 0, y: -height, width: routeCollectionView.frame.width, height: routeCollectionView.frame.height)
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
    
    UIView.animate(withDuration: 0.3) {
      self.routeCollectionView.frame = CGRect(x: 0, y: -self.height, width: self.routeCollectionView.frame.width, height: self.routeCollectionView.frame.height)
    }
  }
  
  // MARK: - SetButtonRadious
  
  func setButtonRadious() {
    searchRegionButton.layer.cornerRadius = 5
    searchRegionButton.layer.borderWidth = 2
    searchRegionButton.layer.borderColor = Singleton.sharedInstance().getThemColorR234xG90xB90().cgColor
    searchRegionButton.setTitle(LanguageTool.sharedInstance().customzieLocalizedString(key: "MapViewController_RegionSearchTitle", commit: ""), for: .normal)
    
    nearBranchesButton.layer.cornerRadius = 5
    nearBranchesButton.layer.borderWidth = 2
    nearBranchesButton.layer.borderColor = Singleton.sharedInstance().getThemColorR234xG90xB90().cgColor
    nearBranchesButton.setTitle(LanguageTool.sharedInstance().customzieLocalizedString(key: "MapViewController_NearPointTitle", commit: ""), for: .normal)
  }
  
  @IBAction func searchButtonAction(_ sender: Any) {
    
    let dic: [String: String] = ["Body":""]
    ProjectAPI.Object().connectAPIWithUrl(method: "GetRegionList", parmaterDic: dic) { (response) in
      
      
    }
    
    customizeMapView.removeOverlays(self.customizeMapView.overlays)
    
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
    customizeMapView.removeOverlays(self.customizeMapView.overlays)
    
    myTextField.resignFirstResponder()
    
    searchRegionButton.backgroundColor = .white
    searchRegionButton.setTitleColor(Singleton.sharedInstance().getThemColorR234xG90xB90(), for: .normal)
    searchRegionButton.layer.borderColor = Singleton.sharedInstance().getThemColorR234xG90xB90().cgColor
    
    nearBranchesButton.setTitleColor(.white, for: .normal)
    nearBranchesButton.layer.borderColor = UIColor.white.cgColor
    nearBranchesButton.backgroundColor = Singleton.sharedInstance().getThemColorR234xG90xB90()
    
    //Get location
    let latitude = 25.034741
    let longitude = 121.521724
    
    //Create annotation
    let annotation = MKPointAnnotation()
    //annotation.title = "古亭分行"
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
      NSLocalizedString("MapViewController_FinishTitle", comment: ""), style: .done, target: self, action: #selector(doneToSearchRegion))
    doneButton.tintColor = .white
    
    let cancelButton = UIBarButtonItem.init(title:
      NSLocalizedString("MapViewController_RegionSearchTitle", comment: ""), style: .done, target: self, action: #selector(cancelSearchRegion))
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
    locationManager.startUpdatingLocation()
    //追蹤座標模式
    customizeMapView.userTrackingMode = .follow
    
    if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) {
      //開始回報位置
      locationManager.startUpdatingLocation()
      
    } else if(UserDefaults.standard.bool(forKey: "FirstOpenMapViewBool")){
      let alertController = UIAlertController.init(title: "Title", message: "未開啟定位權限，請至設定開啟", preferredStyle: .alert)
      
      let confirm = UIAlertAction.init(title: NSLocalizedString("ConfirmTitle", comment: ""), style: .default) { (action) in
        guard let url = URL(string: UIApplicationOpenSettingsURLString) else {
          return
        }
        UIApplication.shared.open(url ,options: [:], completionHandler: nil)
      }
      
      alertController.addAction(confirm)
      
      let cancel = UIAlertAction.init(title: NSLocalizedString("CancelTitle", comment: ""), style: .default, handler: nil)
      alertController.addAction(cancel)
      
      self.present(alertController, animated: true, completion: nil)
    }
    
    UserDefaults.standard.set(true, forKey: "FirstOpenMapViewBool")
    UserDefaults.standard.synchronize()
  }
}

extension MapViewController: MKMapViewDelegate {
  
  func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
    
  }
  
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    
    dinstaceCalculate(view: view)
  }
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard !(annotation is MKUserLocation) else {
      return nil
    }
    
    let annotationIdentifier = "Identifier"
    var annotationView: MKAnnotationView?
    if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
      annotationView = dequeuedAnnotationView
      annotationView?.annotation = annotation
    }
    else {
      annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
      //annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    }
    
    if let annotationView = annotationView {
      
      annotationView.canShowCallout = true
      annotationView.image = UIImage(named: "icon_pinBank")
    }
    
    configureDetailView(annotationView: annotationView!)
    
    return annotationView
  }
  
  
  func configureDetailView(annotationView: MKAnnotationView) {
    
    let customizeCalloutAccessoryView = CustomizeCalloutAccessoryView()
    
    let views = ["customizeCalloutAccessoryView": customizeCalloutAccessoryView]
    customizeCalloutAccessoryView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[customizeCalloutAccessoryView(278)]", options: [], metrics: nil, views: views))
    customizeCalloutAccessoryView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[customizeCalloutAccessoryView(135)]", options: [], metrics: nil, views: views))
    
    annotationView.detailCalloutAccessoryView = customizeCalloutAccessoryView
    
    customizeCalloutAccessoryView.routeButton.addTarget(self, action: #selector(startRoute), for: .touchDown)
  }
  
  @objc func startRoute() {
    
    UIView.animate(withDuration: 0.3) {
      self.routeCollectionView.frame = CGRect(x: 0, y: self.height, width: self.routeCollectionView.frame.width, height: self.routeCollectionView.frame.height)
    }
    
  }
  
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    let route = overlay
    let routeRenderer = MKPolylineRenderer.init(polyline: route as! MKPolyline)
    routeRenderer.strokeColor = Singleton.sharedInstance().getThemeColorR226xG75xB91()
    routeRenderer.lineWidth = 5.0;
    
    return routeRenderer;
  }
  
  func showRoute(index: Int) {
    customizeMapView.removeOverlays(self.customizeMapView.overlays)
    
    let endPlacemark = MKPlacemark.init(coordinate: destinationCoordinate)
    let startItem = MKMapItem.forCurrentLocation()
    let endItem = MKMapItem.init(placemark: endPlacemark)
    
    let request = MKDirectionsRequest()
    request.source = startItem;
    request.destination = endItem
    
    switch index {
    case 0:
      request.transportType = .automobile
      break
    case 1:
      request.transportType = .walking
      break
    default:
      break
    }
    
    request.requestsAlternateRoutes = true
    
    let directions = MKDirections.init(request: request)
    directions.calculate { (response, error) in
      if let response = response {
        self.directionResponse = response
      }
      
      let route = self.directionResponse.routes[0]
      self.customizeMapView.add(route.polyline, level: .aboveRoads)
      
      //      let newcoordinate = CLLocationCoordinate2DMake(<#T##latitude: CLLocationDegrees##CLLocationDegrees#>, <#T##longitude: CLLocationDegrees##CLLocationDegrees#>)
      //      for (MKRoute *route in response.routes) {
      //        if (!value) {
      //          [self.MapView addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
      //          CLLocationCoordinate2D userCoordinate;
      //          userCoordinate = myuserlocation.coordinate;
      //
      //          NSLog(@"startItem:%f",(userCoordinate.latitude+coordinate.latitude)/2);
      //          NSLog(@"endItem:%f",(userCoordinate.longitude+coordinate.longitude)/2);
      //
      //          CLLocationCoordinate2D newcoordinate;
      //          MKCoordinateSpan span;
      //          MKCoordinateRegion region;
      //          newcoordinate.latitude = (userCoordinate.latitude+coordinate.latitude)/2;
      //          newcoordinate.longitude = (userCoordinate.longitude+coordinate.longitude)/2;
      //          span = MKCoordinateSpanMake((fabs(userCoordinate.latitude-coordinate.latitude)*1.3),
      //                                      fabs(userCoordinate.longitude-coordinate.longitude)*1.3);
      //          region = MKCoordinateRegionMake(newcoordinate, span);
      //          [_MapView setRegion:region animated:true];
      //          CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
      //          [self annotationInformation:location];
      //        }
      //      }
    }
  }
  
  func dinstaceCalculate(view: MKAnnotationView) {
    destinationCoordinate = CLLocationCoordinate2DMake((view.annotation?.coordinate.latitude)!, (view.annotation?.coordinate.longitude)!)
    let customizeCalloutAccessoryView = view.detailCalloutAccessoryView as! CustomizeCalloutAccessoryView
    var distance = ""
    let endPlacemark = MKPlacemark.init(coordinate: destinationCoordinate)
    let startItem = MKMapItem.forCurrentLocation()
    let endItem = MKMapItem.init(placemark: endPlacemark)
    let request = MKDirectionsRequest()
    
    request.source = startItem;
    request.destination = endItem
    request.transportType = .automobile
    
    request.requestsAlternateRoutes = true
    
    let directions = MKDirections.init(request: request)
    directions.calculate { (response, error) in
      if(error != nil) {
        print("directions error --> \(String(describing: error))")
        return
      }
      
      if let response = response {
        self.directionResponse = response
        print("response --> \(response)")
        
        let route = self.directionResponse.routes[0]
        let distanceInMeters = route.distance
        let seconds = route.expectedTravelTime
        let minutes = seconds/60
        
        if(distanceInMeters > 1000) {
          let miles = distanceInMeters/1000
          distance = String(format: "%1.0fkm", miles)
          
        } else {
          distance = String(format: "%1.0fm", distanceInMeters)
        }
        
        if(minutes > 60) {
          let hours = minutes/60
          print("%d小時又%d分鐘",hours,minutes-(hours*60))
          
        } else {
          print("%d分鐘",minutes)
        }
        
        customizeCalloutAccessoryView.distanceTitleLabel.text = distance
      }
    }
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
    
    switch collectionView.tag {
    case 0:
      return contentRouteTitleArray.count
    default:
      return contentBranchTitleArray.count
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    switch collectionView.tag {
    case 0:
      let routeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RouteCollectionViewCell", for: indexPath) as! RouteCollectionViewCell
      routeCollectionViewCell.customizeImageView.image = UIImage(named: contentRouteTitleArray[indexPath.item])
      return routeCollectionViewCell
      
    default:
      let mapViewCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:"MapViewCollectionViewCell",for:indexPath) as! MapViewCollectionViewCell
      
      if(previousCollectionCell == nil) {
        previousCollectionCell = mapViewCollectionViewCell
        
      } else {
        mapViewCollectionViewCell.customizeLabelTitle.textColor = Singleton.sharedInstance().getThemeColorR155xG155xB155()
        mapViewCollectionViewCell.customizeTopLineView.backgroundColor = Singleton.sharedInstance().getThemeColorR155xG155xB155()
      }
      mapViewCollectionViewCell.customizeLabelTitle.text = contentBranchTitleArray[indexPath.item]
      
      return mapViewCollectionViewCell
    }
  }
}

extension MapViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    switch collectionView.tag {
    case 0:
      if(routePrevioudCollectionViewCell != nil) {
        UIView.animate(withDuration: 0.5) {
          self.routePrevioudCollectionViewCell?.cusotmzieUnderLineImageView.backgroundColor = UIColor.clear
        }
      }
      
      let routeCollectionViewCell = collectionView.cellForItem(at: indexPath) as! RouteCollectionViewCell
      UIView.animate(withDuration: 0.5) {
        routeCollectionViewCell.cusotmzieUnderLineImageView.backgroundColor = .white
      }
      
      showRoute(index: indexPath.item)
      
      routePrevioudCollectionViewCell = routeCollectionViewCell
      break
    default:
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
}

extension MapViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let selfViewWidth = Int(self.view.frame.width)
    
    switch collectionView.tag {
    case 0:
      return CGSize(width:selfViewWidth/contentRouteTitleArray.count,height:60)
    default:
      return CGSize(width:selfViewWidth/contentBranchTitleArray.count,height:49)
    }
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
    
  }
  
  
  
  
  
  
}
