//
//  ViewController.swift
//  SLSegmentBarSwiftKit
//
//  Created by CoderSLZeng on 05/24/2019.
//  Copyright (c) 2019 CoderSLZeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - 属性
    // MARK: 懒加载
    lazy var segmentBarVC: SegmentBarViewController = {
        let titles = ["标题标题1", "标题标题标题2", "标题3", "标题标题标题4", "标题5"]
        let segmentBarVc = SegmentBarViewController(titles: titles, children: childrenVCs)
        addChild(segmentBarVc)
        view.addSubview(segmentBarVc.view)
        return segmentBarVc
    }()
    
    // MARK: 私有属性
    var childrenVCs: [UIViewController] {
        let a = UIViewController()
        a.view.backgroundColor = .red
        
        let b = UIViewController()
        b.view.backgroundColor = .green
        
        let c = UIViewController()
        c.view.backgroundColor = .blue
        
        let d = UIViewController()
        d.view.backgroundColor = .purple
        
        let e = UIViewController()
        e.view.backgroundColor = .darkGray
        
        return [a, b, c, d, e]
    }
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = segmentBarVC.segmentBar
    }
    
    // MARK: - 布局
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        segmentBarVC.view.frame = view.bounds
        segmentBarVC.segmentBar.frame = CGRect(x: 0, y: 0, width: 300, height: 35)
    }

}



