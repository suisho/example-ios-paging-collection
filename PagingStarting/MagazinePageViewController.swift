//
//  MagazinePageViewController.swift
//  PagingStarting
//
//  Created by suisho on 2014/10/13.
//  Copyright (c) 2014年 suisho. All rights reserved.
//

import UIKit
enum Pages: String{
    case Cover = "Cover"
    case Magazine = "Magazine"
    case End = "End"
    static let all = [Cover, Magazine, End]
    func next() -> Pages?{
        if let id = find(Pages.all, self){
            println(id)
            if id < Pages.all.count - 1{
                return Pages.all[id+1]
            }
        }
        return nil
    }
    func prev() -> Pages?{
        if let id = find(Pages.all, self){
            if 0 < id {
                return Pages.all[id-1]
            }
        }
        return nil
    }

}

class MagazineRootViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate {
    var currentPage : Pages = Pages.Cover
    var destPage : Pages? = nil
    var pageViewController : UIPageViewController?
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        println(self.currentPage.toRaw())
        switch currentPage{
        case .Cover:
            if scrollView.contentOffset.x < scrollView.bounds.size.width {
                scrollView.setContentOffset(CGPointMake(scrollView.bounds.size.width, 0), animated: false)
            }
        default:
            break
        }
    }
    
    func getViewControllerFromStoryBoard(id: Pages) -> UIViewController{
        return self.storyboard!.instantiateViewControllerWithIdentifier(id.toRaw()) as UIViewController
    }
    
    func getViewControllers() -> [UIViewController]{
        var vc :[UIViewController] = []
        for id in Pages.all{
            vc.append(getViewControllerFromStoryBoard(id))
        }
        return vc
    }
    
    func disablePagingViewBounce(pageViewController : UIViewController){
        for v in pageViewController.view.subviews{
            if let scrollView = v as? UIScrollView{
                //scrollView.bounces = false
                //scrollView.delegate = self
                //scrollView.alwaysBounceHorizontal = true
                //scrollView.bouncesZoom = false
                scrollView.delegate = self
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // setup pageView
        let opt = [
            UIPageViewControllerOptionSpineLocationKey : UIPageViewControllerSpineLocation.Mid.toRaw()
        ]
        let pageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options:opt)
        self.addChildViewController(pageViewController)
        
        let startViewController = getViewControllerFromStoryBoard(Pages.Cover)
        pageViewController.setViewControllers([startViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        disablePagingViewBounce(pageViewController)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.view.frame = self.view.frame
        self.currentPage = Pages.Cover
        self.pageViewController = pageViewController
        self.view.addSubview(pageViewController.view)
        self.view.gestureRecognizers = self.pageViewController?.gestureRecognizers
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject], transitionCompleted completed: Bool) {
        if completed{
            let pvc = pageViewController.viewControllers.last
            if let d = Pages.fromRaw(pvc?.restorationIdentifier ?? ""){
                self.currentPage = d
            }
        }
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?{
        if let restId = viewController.restorationIdentifier{

            if let prev = Pages.fromRaw(restId)?.prev(){
                return getViewControllerFromStoryBoard(prev)
            }
        }

        return nil
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?{
        if let restId = viewController.restorationIdentifier{
            if let next = Pages.fromRaw(restId)?.next(){
                return getViewControllerFromStoryBoard(next)
            }
        }
        return nil
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
