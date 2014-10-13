//
//  MagazinePageViewController.swift
//  PagingStarting
//
//  Created by suisho on 2014/10/13.
//  Copyright (c) 2014年 suisho. All rights reserved.
//

import UIKit
enum StoryBoardIds: String{
    case Cover = "Cover", Magazine = "Magazine", End = "End"
    static let all = [Cover, Magazine, End]
    func next() -> StoryBoardIds?{
        if let id = find(StoryBoardIds.all, self){
            if id < StoryBoardIds.all.count - 1{
                return StoryBoardIds.all[id+1]
            }
        }
        return nil
    }
    func prev() -> StoryBoardIds?{
        if let id = find(StoryBoardIds.all, self){
            if 0 < id {
                return StoryBoardIds.all[id-1]
            }
        }
        return nil
    }

}

class MagazineRootViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pageViewController : UIPageViewController?
    
    func getViewControllerFromStoryBoard(id: StoryBoardIds) -> UIViewController{
        return self.storyboard!.instantiateViewControllerWithIdentifier(id.toRaw()) as UIViewController
    }
    
    func getViewControllers() -> [UIViewController]{
        var vc :[UIViewController] = []
        for id in StoryBoardIds.all{
            vc.append(getViewControllerFromStoryBoard(id))
        }
        return vc
    }
    
    func disablePagingViewBounce(pageViewController : UIViewController){
        for v in pageViewController.view.subviews{
            if let scrollView = v as? UIScrollView{
                scrollView.bounces = false
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // setup pageView
        let pageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        self.addChildViewController(pageViewController)
        
        let startViewController = getViewControllerFromStoryBoard(StoryBoardIds.Cover)
        pageViewController.setViewControllers([startViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        //disablePagingViewBounce(pageViewController)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.view.frame = self.view.frame
        self.pageViewController = pageViewController
        self.view.addSubview(pageViewController.view)
        self.view.gestureRecognizers = self.pageViewController?.gestureRecognizers
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?{
        
        if let restId = viewController.restorationIdentifier{
            if let prev = StoryBoardIds.fromRaw(restId)?.prev(){
                return getViewControllerFromStoryBoard(prev)
            }
        }

        return nil
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?{
        if let restId = viewController.restorationIdentifier{
            if let next = StoryBoardIds.fromRaw(restId)?.next(){
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
