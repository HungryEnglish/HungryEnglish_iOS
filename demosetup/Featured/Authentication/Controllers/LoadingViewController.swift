//
//  LoadingViewController.swift
//  demosetup
//
//  Created by Nikunj on 12/09/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit


class LoadingViewController: UIViewController {

    // MARK: - OUTLETS -
    
    
    @IBOutlet weak var webview: UIWebView!
   
    
    // MARK: - VARIABLES -
    
    
    
    
    // MARK: - METHODS -
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       ShowLoader()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - VOID METHODS -
    

    func ShowLoader()
    {
//        let img = UIImage.gifImageWithName : "Loader")
        
//        let img = UIImage.animatedImageNamed("Loader", duration: 1.0)
      //  let imageView = UIImageView()
       // imgLoad.loadGif(name: "Loader")
        
        //imgLoad.image = UIImage.gif(name : "Loader")
        
        
       // let url = URL(string : "Loader.gif")
        
       // imgLoad.kf.setImage(with: url as! URL)
        
        
       // imgLoad.image = img
        
       
        
       // let url = Bundle.main.url(forResource: "Loader", withExtension: "gif")!
        
        //let url = Bundle.main.url(forResource: "Loader", withExtension: "gif")
        let url = URL(string: "Loader.gif")
        print(url!)
        
        let data = try! Data(contentsOf: url!)
        webview.load(data, mimeType: "image/gif", textEncodingName: "UTF-8", baseURL: NSURL() as URL)
        
    }
    
    // MARK: - CLICKED EVENTS -
    
    
    @IBAction func btnCloseClicekd(_ sender: UIButton) {
    }
    

}
