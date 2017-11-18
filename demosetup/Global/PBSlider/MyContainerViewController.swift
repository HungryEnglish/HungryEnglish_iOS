//
//  MyContainerViewController.swift
//  tabBarLayout
//
//  Created by peerbits on 27/01/17.
//  Copyright © 2017 Peerbits Macmini. All rights reserved.
//

import UIKit

//MARK: -Protocol to define delegate -
@objc protocol MyContainerViewControllerDelegate
{
    @objc func MyContainerViewControllerDidMoveToViewController (_ MyContainerViewController: MyContainerViewController, viewController: UIViewController, atIndex: Int)
    
}
//MARK: - Helper ViewController Class -
class MyContainerViewController: UIViewController, UIScrollViewDelegate, MySliderViewDelegate
{
    //MARK: - Properties -
    var contentViewControllers: [UIViewController]!
    var contentScrollView: UIScrollView!
    var titles: [String]!
    var sliderView: MySliderView!
    var sliderViewShown: Bool = true
    var delegate: MyContainerViewControllerDelegate?
    
    
    // MARK: Init
    init (parent: UIViewController, contentViewControllers: [UIViewController], titles: [String])
    {
        super.init(nibName: nil, bundle: nil)
        self.contentViewControllers = contentViewControllers
        self.titles = titles
        
        // Move to parent
        willMove(toParentViewController: parent)
        parent.addChildViewController(self)
        didMove(toParentViewController: parent)
        
        
        // Setup Views
        sliderView = MySliderView (width: view.frame.size.width, titles: titles)
        sliderView.frame.origin.y = parent.topLayoutGuide.length
        sliderView.sliderDelegate = self
        
        contentScrollView = UIScrollView (frame: view.frame)
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.showsVerticalScrollIndicator = false
        contentScrollView.isPagingEnabled = true
        contentScrollView.scrollsToTop = false
        contentScrollView.delegate = self
        contentScrollView.bounces = false
        contentScrollView.contentSize = CGSize(width: contentScrollView.frame.size.width * CGFloat(contentViewControllers.count), height: 1.0)
        
        view.addSubview(contentScrollView)
        view.addSubview(sliderView)
        
        
        // Add Child View Controllers
        var currentX: CGFloat = 0
        for vc in contentViewControllers
        {
                  
            vc.view.frame = CGRect (
                x: currentX,
                y: parent.topLayoutGuide.length,
                width: view.frame.size.width,
                height: view.frame.size.height - parent.topLayoutGuide.length - parent.bottomLayoutGuide.length - 64 )
            
           
            contentScrollView.addSubview(vc.view)
            currentX += contentScrollView.frame.size.width
        }
        // Move First Item
        setCurrentViewControllerAtIndex(0)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    
    // MARK: Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    // MARK: ChildViewController Management
    func setCurrentViewControllerAtIndex (_ index: Int)
    {
        for i in 0..<self.contentViewControllers.count
        {
            let vc = contentViewControllers[i]
            if i == index
            {
                vc.willMove(toParentViewController: self)
                addChildViewController(vc)
                vc.didMove(toParentViewController: self)
                delegate?.MyContainerViewControllerDidMoveToViewController (self, viewController: vc, atIndex: index)
            }
            else
            {
                vc.willMove(toParentViewController: self)
                vc.removeFromParentViewController()
                vc.didMove(toParentViewController: self)
            }
        }
        sliderView.selectItemAtIndex(index)
        contentScrollView.setContentOffset(
            CGPoint (x: contentScrollView.frame.size.width * CGFloat(index), y: 0),
            animated: true)
        navigationController?.navigationItem.title = titles[index]
    }
    
    // MARK: SlidingContainerSliderViewDelegate
    func MySliderViewDidPressed(_ slidingContainerSliderView: MySliderView, atIndex: Int)
    {
        sliderView.shouldSlide = false
        setCurrentViewControllerAtIndex(atIndex)
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        //let maximumHorizontalOffset = scrollView.contentSize.width - scrollView.frame.width
       // let currentHorizontalOffset = scrollView.contentOffset.x;
       // let percentageHorizontalOffset = currentHorizontalOffset / maximumHorizontalOffset
       
        var devider : Float!
        if sliderView.appearance.fixedWidth
        {
            devider = Float(sliderView.labels.count)
        
            sliderView.selector.frame.origin.x = scrollView.contentOffset.x/CGFloat(devider)
        }
        else
        {
           
        }
        if scrollView.panGestureRecognizer.state == .began
        {
            sliderView.shouldSlide = true
        }
        let contentW = contentScrollView.contentSize.width - contentScrollView.frame.size.width
        let sliderW = sliderView.contentSize.width - sliderView.frame.size.width
        let current = contentScrollView.contentOffset.x
        let ratio = current / contentW
        if sliderView.contentSize.width > sliderView.frame.size.width && sliderView.shouldSlide == true
        {
            sliderView.contentOffset = CGPoint(x: sliderW * ratio, y: 0)
        }
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        let index = scrollView.contentOffset.x / contentScrollView.frame.size.width
        setCurrentViewControllerAtIndex(Int(index))
      //  sliderView.labels[Int(index)].center.x = self.view.center.x
    }
    //MARK: - Close Slide Controller -
    func closeMe()
    {
        self.removeFromParentViewController()
        self.view.removeFromSuperview()
        self.sliderView.removeFromSuperview()
    }
}

