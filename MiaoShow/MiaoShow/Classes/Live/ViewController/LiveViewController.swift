//
//  LiveViewController.swift
//  MiaoShow
//
//  Created by  Mazy on 2017/4/7.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

let cellID = "MAZY"
let screenH = UIScreen.main.bounds.height

class LiveViewController: XMBaseViewController {
    
    /// 懒加载tableView
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        return tableView
    }()
    
    var currentOffsetY: CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 取消顶部自动约束
        automaticallyAdjustsScrollViewInsets = false
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        view.addSubview(tableView)
        
        navigationItem.title = "广场"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"search_head")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(search))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"head_crown")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(search))
        
    }
    
    @objc func search() {
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension LiveViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        cell?.textLabel?.text = "ddafagaga"
        return cell!
    }
}


// MARK: - scrollViewDelegate
extension LiveViewController {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        currentOffsetY = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let rect = tabBarController?.tabBar.frame
        
        if scrollView.contentOffset.y > currentOffsetY ?? 0 {
            let distance = scrollView.contentOffset.y - currentOffsetY!
            UIView.animate(withDuration: 0.5, animations: { 
                if distance < 49.0 {
                    self.tabBarController?.tabBar.frame = CGRect(x: (rect?.origin.x)!, y: screenH+distance, width: (rect?.width)!, height: (rect?.height)!)
                }
                self.navigationController?.setNavigationBarHidden(true, animated: true)
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: { 
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                self.tabBarController?.tabBar.frame = CGRect(x: (rect?.origin.x)!, y: screenH-49, width: (rect?.width)!, height: (rect?.height)!)
            })
        }
    }
}








