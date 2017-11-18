//
//  TeacherListViewController.swift
//  demosetup
//
//  Created by Nikunj on 18/09/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit

class TeacherListViewController: UIViewController, MyContainerViewControllerDelegate {

    // MARK: - OUTLETS -
    
    
    @IBOutlet var containerView: UIView!
    
    
    // MARK: - VARIABLEs -
    
    var vc1 : TeacherApprovedListViewController!
    var vc2 : TeacherPendingListViewController!
    
    var selectedIndex : Int = 0
    
    var slidingContainerViewController : MyContainerViewController!
    
    
    // MARK: - METHODS -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        //set slider head
        setSlidingControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - VOID METHODS -
    func setSlidingControllers()
    {
        
        vc1 = Utilities.viewController(name: "TeacherApprovedListViewController", onStoryboard: Sbname.Home.rawValue) as! TeacherApprovedListViewController
        vc2 = Utilities.viewController(name: "TeacherPendingListViewController", onStoryboard: Sbname.Home.rawValue) as! TeacherPendingListViewController
        slidingContainerViewController = MyContainerViewController (
            parent: self,
            contentViewControllers: [vc1, vc2],
            titles: [ValidMsg.approved.rawValue, ValidMsg.pending.rawValue])
        
        slidingContainerViewController.view.frame = self.containerView.bounds
        containerView.addSubview(slidingContainerViewController.view)
        slidingContainerViewController.delegate = self
        //appearance Of Selector
        slidingContainerViewController.sliderView.appearance.outerPadding = 0
        slidingContainerViewController.sliderView.appearance.innerPadding = 50
        slidingContainerViewController.sliderView.appearance.fixedWidth = true
        slidingContainerViewController.sliderView.appearance.backgroundColor = .white
        slidingContainerViewController.sliderView.selector.backgroundColor = UIColor.green //UIColor(colorLiteralRed: 255.0/255, green: 102.0/255, blue: 52.0/255, alpha: 1.0)
        slidingContainerViewController.setCurrentViewControllerAtIndex(0)
        
    }
    //MARK: - Sliding Container Delegate Method -
    func MyContainerViewControllerDidMoveToViewController(_ MyContainerViewController: MyContainerViewController, viewController: UIViewController, atIndex: Int) {
        
        self.selectedIndex = atIndex
        
        if atIndex == 0
        {
            vc1.callAPI()
        }else if atIndex == 1
        {
            vc2.callAPI()
        }
        
    }
    
    
    // MARK: - CLICKED EVENTS -
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
}
