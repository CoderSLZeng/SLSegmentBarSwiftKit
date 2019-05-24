//
//  ViewController.swift
//  SLSegmentBarSwiftKit
//
//  Created by CoderSLZeng on 05/24/2019.
//  Copyright (c) 2019 CoderSLZeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    weak var segmentBar : SegmentBar?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let segmentBar = SegmentBar(frame: CGRect(x: 0, y: 44, width: view.frame.width, height: 35))
        segmentBar.backgroundColor = .red
        segmentBar.titles = ["标题1", "标题标题2", "标题标题3", "标题4", "标题5", "标题6"]
        self.view.addSubview(segmentBar)
        self.segmentBar = segmentBar
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        segmentBar?.backgroundColor = .blue
        segmentBar?.titles = ["标题标题标题1", "标题标题2", "标题3"]
    }

}

