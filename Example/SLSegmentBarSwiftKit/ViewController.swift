//
//  ViewController.swift
//  SLSegmentBarSwiftKit
//
//  Created by CoderSLZeng on 05/24/2019.
//  Copyright (c) 2019 CoderSLZeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var segmentBar: SegmentBar = {
         let titles = ["标题1", "标题标题2", "标题标题3", "标题4", "标题5", "标题6"]
        let segmentBar = SegmentBar(frame: CGRect(x: 0,
                                                  y: 64,
                                                  width: view.frame.width,
                                                  height: 35),
                                    titles: titles)
        segmentBar.backgroundColor = .blue
//        segmentBar.delegate = self
        return segmentBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(segmentBar)
        automaticallyAdjustsScrollViewInsets = false
        segmentBar.selectedCallBack = {
            toIndex, fromIndex in
            
             print("toIndex = \(toIndex), fromInde = \(fromIndex)")
        }
        
    }

}

extension ViewController: SegmentBarDelegate {
    func selected(toIndex: Int, fromIndex: Int) {
        print("toIndex = \(toIndex), fromInde = \(fromIndex)")
    }
}

