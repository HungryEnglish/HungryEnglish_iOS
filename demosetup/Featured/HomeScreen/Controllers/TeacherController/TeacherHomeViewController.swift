//
//  TeacherHomeViewController.swift
//  demosetup
//
//  Created by Nikunj on 06/10/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit
import SwiftyJSON

class TeacherHomeViewController: UIViewController, UIScrollViewDelegate {

    // MARK: - OUTLETS -
    
    @IBOutlet weak var lblres1: UILabel!
    
    @IBOutlet weak var lbllink1: UILabel!
    
    @IBOutlet weak var lblres2: UILabel!
    
    @IBOutlet weak var lbllink2: UILabel!
    
    @IBOutlet weak var lblres3: UILabel!
    
    @IBOutlet weak var lbllink3: UILabel!
    
    @IBOutlet weak var lblres4: UILabel!
    
    @IBOutlet weak var lbllink4: UILabel!
    
    @IBOutlet weak var lblres5: UILabel!
    
    @IBOutlet weak var lbllink5: UILabel!
    
    @IBOutlet weak var lblres6: UILabel!
    
    @IBOutlet weak var lblink6: UILabel!
    
    @IBOutlet weak var viewlink6: UIView!
    
    @IBOutlet weak var viewlink5: UIView!
    
    @IBOutlet weak var viewlink4: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageController: UIPageControl!
    
    
    
    @IBOutlet weak var viewLink1: UIView!
    
    @IBOutlet weak var viewLink2: UIView!
    
    @IBOutlet weak var viewLink3: UIView!
   
    
    // MARK: - VARIABLES -
    
    var imagesarray = [String]()
    
    var timer = Timer()
    
    var sec = 7
    
    var countimg = CGFloat()
    
    var sampleTapGesture = UITapGestureRecognizer()
    
    var obj  = AdminImageLink()
    
    
    // MARK: - METHODS -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callAPI()
        
        // Config scrollview
        scrollView.delegate = self
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.alwaysBounceHorizontal = false
        
        viewLink1.layer.cornerRadius = 30.0
        viewLink1.clipsToBounds = true
        viewLink2.layer.cornerRadius = 30.0
        viewLink2.clipsToBounds = true
        viewLink3.layer.cornerRadius = 30.0
        viewLink3.clipsToBounds = true
        viewlink4.layer.cornerRadius = 30.0
        viewlink4.clipsToBounds = true
        viewlink5.layer.cornerRadius = 30.0
        viewlink5.clipsToBounds = true
        viewlink6.layer.cornerRadius = 30.0
        viewlink6.clipsToBounds = true
        
        sampleTapGesture = UITapGestureRecognizer(target: self, action: #selector(TeacherHomeViewController.sampleTapGestureTapped(recognizer:)))
        self.scrollView.addGestureRecognizer(sampleTapGesture)
    
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(TeacherHomeViewController.updateCount), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - VOID METHODS -
    
    func callAPI()
    {
        let param : [String : String] =
            [
                "": ""
        ]
        
        print(param)
        
        AlamofireModel.GetDataFromServerGET(parameter: param as NSDictionary, URL: APIAction.admingetimglink.rawValue, handler: { response in
            
            print(JSON(response))
            
            let dict = JSON(response)
            
            self.obj = AdminImageLink(data: dict["info"])
            
            self.updatedetails()
        })
    }
    
    
    func updatedetails()
    {
        
        if obj.title1 == ""
        {
            
        }else{
            lblres1.text = obj.title1
            lbllink1.text = obj.link1
        }
        
        if obj.title2 == ""
        {
           
        }else{
            lblres2.text = obj.title2
            lbllink2.text = obj.link2
        }
        
        if obj.title3 == ""
        {
           
        }else{
            lblres3.text = obj.title3
            lbllink3.text = obj.link3
        }
        
        if obj.title4 == ""
        {
            viewlink4.isHidden = true
            
            
        }else{
            
            viewlink4.isHidden = false
           
            lblres4.text = obj.title4
            lbllink4.text = obj.link4
        }
        
        if obj.title5 == ""
        {
            
            viewlink5.isHidden = true
            
        }else{
            viewlink5.isHidden = false
            
            lblres5.text = obj.title5
            lbllink5.text = obj.link5
        }
        
        if obj.title6 == ""
        {
            viewlink6.isHidden = true
        }else{
            
            viewlink6.isHidden = false
            lblres6.text = obj.title6
            lblink6.text = obj.link6
        }
        
        if obj.image1 == ""
        {
            
            //ic_cameraplaceholder
        }else{
            
           imagesarray.append(obj.image1)
            
        }
        if obj.image2 == ""
        {
            
        }else{
            
            imagesarray.append(obj.image2)
        }
        
        if obj.image3 == ""
        {
        }else{
            
            imagesarray.append(obj.image3)
        }
        
        configurePageControl()
        
        for i in stride(from: 0, to: imagesarray.count, by: 1)
        {
            
            var frame = CGRect.zero
            frame.origin.x = kMainScreenWidth * CGFloat(i)
            frame.origin.y = 0
            frame.size = self.scrollView.frame.size
            
            //let myImage:UIImage = UIImage(named: imagesarray[i])!
            
            let myImageView:UIImageView = UIImageView()
            
            myImageView.kf.indicatorType = .activity
            
            myImageView.kf.setImage(with: URL(string : imagesarray[i]))
            
           // myImageView.image = myImage
            myImageView.contentMode = .scaleAspectFit
            myImageView.frame =  CGRect(x: frame.origin.x, y: 0, width: kMainScreenWidth, height: self.scrollView.frame.size.height)//self.scrollView.frame
            
            scrollView.addSubview(myImageView)
        }
        
        self.scrollView.contentSize = CGSize(width: kMainScreenWidth * CGFloat(imagesarray.count), height: 0)//self.scrollView.frame.size.height)
        pageController.addTarget(self, action: #selector(self.changePage(_:)), for: .valueChanged)
        
    }
    
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        self.pageController.numberOfPages = imagesarray.count
        self.pageController.currentPage = 0
        self.pageController.tintColor = UIColor.red
        self.pageController.pageIndicatorTintColor = UIColor.black
        self.pageController.currentPageIndicatorTintColor = UIColor.green
        //self.view.addSubview(pageController)
        
        
    }
    
    func sampleTapGestureTapped(recognizer : UITapGestureRecognizer)
    {
        print(countimg)
        if countimg == 1.0
        {
            if obj.imglink1 != ""
            {
                openURLBrowser(str :  obj.imglink1)
            }
        }else if countimg == 2.0
        {
            if obj.imglink2 != ""
            {
                openURLBrowser(str :  obj.imglink2)
            }
        }else if countimg == 3.0
        {
            if obj.imglink3 != ""
            {
                openURLBrowser(str :  obj.imglink3)
            }
        }
    }
    
    
    func openURLBrowser(str : String)
    {
        if str != ""
        {
            let url = NSURL(string: str)!
             
            if UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.openURL(url as URL)
            }else{
                let _url = NSURL(string: "http://" + str)!
                UIApplication.shared.openURL(_url as URL)
            }
          
        }
    }
    
    func updateCount()
    {
        
        if sec > 0
        {
            sec -= 1
        }else{
            
            countimg = CGFloat(pageController.currentPage) + 1.0
            
            if Int(countimg) < imagesarray.count
            {
                self.pageController.currentPage += 1
                let x = countimg * kMainScreenWidth//scrollView.frame.size.width
                scrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
                countimg += 1
            }else{
                self.pageController.currentPage = 0
                countimg = CGFloat(pageController.currentPage) + 1.0
                let x = CGFloat(pageController.currentPage) * kMainScreenWidth//scrollView.frame.size.width
                scrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
            }
            
            sec = 7
        }
        
    }
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    func changePage(_ sender: AnyObject) -> () {
        sec = 7
        
        countimg = CGFloat(pageController.currentPage) + 1.0
        let x = CGFloat(pageController.currentPage) * kMainScreenWidth//scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
        
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        sec = 7
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageController.currentPage = Int(pageNumber)
        countimg = CGFloat(pageController.currentPage) + 1.0
    }

    
    
    // MARK: - CLICKED EVENTS -
    
    @IBAction func btnLogoutClicked(_ sender: UIButton) {
        
        appInstance.LogoutPopup()
        
    }
    
    @IBAction func btnContactUsClicked(_ sender: UIButton) {
        
        Utilities.showMessage(text: "Coming Soon")
        
//        let VC = Utilities.viewController(name: "ContactUsViewController", onStoryboard: Sbname.Home.rawValue) as! ContactUsViewController
//        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    
    
    @IBAction func btnEditClicked(_ sender: UIButton) {
        
        let VC = Utilities.viewController(name: "TeacherEditViewController", onStoryboard: Sbname.Home.rawValue) as! TeacherEditViewController
        VC.userid = (kCurrentUser()?.userid)!
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    @IBAction func btnResourceLinkedClicked(_ sender: UIButton) {
        
        if sender.tag == 1
        {
            if obj.link1 != ""
            {
                openURLBrowser(str : obj.link1)
            }
        }else if sender.tag == 2
        {
            if obj.link2 != ""
            {
                openURLBrowser(str : obj.link2)
            }
        }else if sender.tag == 3
        {
            if obj.link3 != ""
            {
                openURLBrowser(str : obj.link3)
            }
        }else if sender.tag == 4
        {
            if obj.link4 != ""
            {
                openURLBrowser(str : obj.link4)
            }
        }else if sender.tag == 5
        {
            if obj.link5 != ""
            {
                openURLBrowser(str : obj.link5)
            }
        }else if sender.tag == 6
        {
            if obj.link6 != ""
            {
                openURLBrowser(str : obj.link6)
            }
        }
        
    }
    

}
