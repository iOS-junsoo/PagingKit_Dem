//
//  ViewController.swift
//  ViewPager_Dem
//
//  Created by 준수김 on 2021/11/05.
//

import UIKit
import PagingKit

class ViewController: UIViewController {

    private var viewControllers: Array<UIViewController> = []
    
    var menuViewController: PagingMenuViewController!
    var contentViewController: PagingContentViewController!
    
    
       
//       var dataSource = [(menuTitle: "배달", vc: viewController(.red)), (menuTitle: "배민1", vc: viewController(.blue)), (menuTitle: "포장", vc: viewController(.yellow)), (menuTitle: "쇼핑라이브", vc: viewController(.blue)), (menuTitle: "선물하기", vc: viewController(.blue)), (menuTitle: "전국별미", vc: viewController(.blue))]
    
    var dataSource = ["배달", "배민1", "포장", "쇼핑라이브", "선물하기", "전국별미"]
    
    
    
    var array1 : [UIColor] = [.red, .clear, .clear,  .clear, .clear, .clear]
    var array2 : [UIColor] = [.clear, .red, .clear,  .clear, .clear, .clear]
    var array3 : [UIColor] = [.clear, .clear, .red,  .clear, .clear, .clear]
    var array4 : [UIColor] = [.clear, .clear, .clear,  .red, .clear, .clear]
    var array5 : [UIColor] = [.clear, .clear, .clear,  .clear, .red, .clear]
    var array6 : [UIColor] = [.clear, .clear, .clear,  .clear, .clear, .red]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController1") as! ViewController1
        let vc2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        let vc3 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController3") as! ViewController3
        let vc4 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController4") as! ViewController4
        let vc5 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController5") as! ViewController5

        viewControllers.append(vc1)
        viewControllers.append(vc2)
        viewControllers.append(vc3)
        viewControllers.append(vc4)
        viewControllers.append(vc5)
        
        menuViewController.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
    
//        menuViewController.registerFocusView(nib: UINib(nibName: "FocusView", bundle: nil))
        menuViewController.reloadData()
        contentViewController.reloadData()
        
        print(viewControllers)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let vc = segue.destination as? PagingMenuViewController {
                menuViewController = vc
                menuViewController.dataSource = self
                menuViewController.delegate = self
            } else if let vc = segue.destination as? PagingContentViewController {
                contentViewController = vc
                contentViewController.dataSource = self
                contentViewController.delegate = self
            }
        }


}

//MARK: - menu datasource
extension ViewController: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        switch index {
        case 0:
            return 70
        case 1:
            return 70
        case 2:
            return 85
        case 3:
            return 100
        case 4:
            return 100
        case 5:
            return 110
        default:
            return 100
        }
        
        
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: index) as! MenuCell
        
        cell.titleLabel.text = dataSource[index]
        
        switch Page.pageTitle1 {
        case 0:
            cell.myView.backgroundColor = array1[index]
            cell.myView.frame.size.width = 60
        case 1:
            cell.myView.backgroundColor = array2[index]
            cell.myView.frame.size.width = 60
        case 2:
            cell.myView.backgroundColor = array3[index]
            cell.myView.frame.size.width = 60
        case 3:
            cell.myView.backgroundColor = array4[index]
            cell.myView.frame.size.width = 60
        case 4:
            cell.myView.backgroundColor = array5[index]
            cell.myView.frame.size.width = 60
        case 5:
            cell.myView.backgroundColor = array6[index]
            cell.myView.frame.size.width = 60
        default:
            print("error")
            
        }
        
//        switch Page.pageTitle2 {
//        case 0:
//            cell.myView.backgroundColor = array1[index]
//            cell.myView.frame.size.width = 60
//        case 1:
//            cell.myView.backgroundColor = array2[index]
//            cell.myView.frame.size.width = 60
//        case 2:
//            cell.myView.backgroundColor = array3[index]
//            cell.myView.frame.size.width = 60
//        case 3:
//            cell.myView.backgroundColor = array4[index]
//            cell.myView.frame.size.width = 60
//        case 4:
//            cell.myView.backgroundColor = array5[index]
//            cell.myView.frame.size.width = 60
//        case 5:
//            cell.myView.backgroundColor = array6[index]
//            cell.myView.frame.size.width = 60
//        default:
//            print("error")
//
//        }
        
        return cell
    }
}
//MARK: - contents datasource
extension ViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return viewControllers[index]
    }
}


//MARK: - menu delegate
extension ViewController: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentViewController.scroll(to: page, animated: true)
        Page.pageTitle1 = page
        menuViewController.reloadData()
    }
}
//MARK: - contents delegate
extension ViewController: PagingContentViewControllerDelegate {
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        menuViewController.scroll(index: index, percent: percent, animated: false)
        Page.pageTitle2 = index
        print("인덱스\(index)")
    }
}
