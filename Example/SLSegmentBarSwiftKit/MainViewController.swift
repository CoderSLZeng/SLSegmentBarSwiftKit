//
//  MainViewController.swift
//  SLSegmentBarSwiftKit_Example
//
//  Created by CoderSLZeng on 2019/5/27.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }


}
