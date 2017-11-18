//
//  RatingListViewController.swift
//  demosetup
//
//  Created by Nikunj on 09/10/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit
import FloatRatingView
import SwiftyJSON

class RatingListViewController: UIViewController {


    // MARK: - VARIABLES -
    
    var objRateList = [RateList]()
    
    // MARK: - OUTLETS -
    
    
    @IBOutlet weak var tblList: UITableView!
    
    // MARK: - METHODS -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callRatelistAPI()
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - VOID METHODS -
    
    func callRatelistAPI()
    {
        let param : [String : String] =
            [
                p_action : "get_all_rate",
                ]
        
        print(param)
        
        AlamofireModel.GetDataFromServerGET(parameter: param as NSDictionary, URL: APIAction.ratelist.rawValue, handler: { response in
            
            let dict = JSON(response)
            print(dict)
            
            for (_ ,value) in dict["data"]
            {
                let obj = RateList(data : value)
                self.objRateList.append(obj)
            }
            
            if self.objRateList.count > 0
            {
                self.tblList.isHidden = false
                self.tblList.reloadData()
            }else{
                self.tblList.isHidden = true
                Utilities.showMessage(text: ValidMsg.nodetailsfound.rawValue)
            }
            
        })
    }
    
    
    func callSwitchAPI(rate_status : String, rate_id : String, teacher_id : String)
    {
        let param : [String : String] =
            [
                p_action : "update_rate",
                p_rate_status : rate_status,
                p_rate_id : rate_id,
                p_teacher_id : teacher_id
            ]
        
        print(param)
        
        AlamofireModel.GetDataFromServerGET(parameter: param as NSDictionary, URL: APIAction.ratelist.rawValue, showloader: false, handler: { response in
            
            let dict = JSON(response)
            print(dict)
            
          
        })
    }
    
    
    
    // MARK: - CLICKED EVENTS -
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
    
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    

}

// MARK: - EXTENSION -

extension RatingListViewController : UITableViewDataSource, UITableViewDelegate//, EDStarRatingProtocol
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objRateList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RatelistTableViewCell
        
        cell.selectionStyle = .none
        
        cell.lbltext.text = "\(objRateList[indexPath.row].stu_username) gave rate to \(objRateList[indexPath.row].tea_username)"
        
        
        cell.ratingView.editable = false
        cell.ratingView.emptyImage = #imageLiteral(resourceName: "ic_StarUnSelected")
        cell.ratingView.fullImage = #imageLiteral(resourceName: "ic_StarSelected")
        cell.ratingView.floatRatings = true
        cell.ratingView.maxRating = 5
        cell.ratingView.rating = Float(objRateList[indexPath.row].rate)!;

        cell.btnSwitch.tag = indexPath.row
        
        if objRateList[indexPath.row].is_approved == "1"
        {
            cell.btnSwitch.isOn = true
        }else{
            cell.btnSwitch.isOn = false
        }
        
        
        cell.btnSwitch.addTarget(self, action : #selector(switchChanged), for: .valueChanged)
        
        return cell
        
    }
    
    
    func switchChanged(mySwitch: UISwitch) {
    
        print(mySwitch.tag)
        
        if mySwitch.isOn
        {
            
            callSwitchAPI(rate_status : "1", rate_id : objRateList[mySwitch.tag].rate_id, teacher_id : objRateList[mySwitch.tag].tea_id)
            
        }else{
            
            callSwitchAPI(rate_status : "0", rate_id : objRateList[mySwitch.tag].rate_id, teacher_id : objRateList[mySwitch.tag].tea_id)
            
        }
     }
  
}


