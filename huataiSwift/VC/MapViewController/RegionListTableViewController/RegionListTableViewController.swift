//
//  RegionListTableViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/17.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class RegionListTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationItem.title = NSLocalizedString("NavigationControllerMapTitle", comment: "");
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  @IBAction func popButtonAction(_ sender: Any) {
    navigationController?.popViewController(animated: true)
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

extension RegionListTableViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let regionListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RegionListTableViewCell") as! RegionListTableViewCell
    return regionListTableViewCell
  }
}

