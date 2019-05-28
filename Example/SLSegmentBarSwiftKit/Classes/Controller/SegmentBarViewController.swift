//
//  SegmentBarViewController.swift
//  SLSegmentBarSwiftKit_Example
//
//  Created by CoderSLZeng on 2019/5/28.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class SegmentBarViewController: UIViewController {

    // MARK: - 属性
    lazy var contentView: UIScrollView = {
        let contentView = UIScrollView()
        contentView.isPagingEnabled = true
        contentView.showsHorizontalScrollIndicator = false
        contentView.bounces = false
        contentView.delegate = self
        view.addSubview(contentView)
        return contentView
    }()
    
    // MARK: 懒加载
    lazy var segmentBar: SegmentBar = {
        let segmentBar = SegmentBar(frame: .zero)
        view.addSubview(segmentBar)
        return segmentBar
    }()
    
    
    // MARK: - 生命周期
    convenience init(titles: [String], children: [UIViewController]) {
        self.init()
        
        assert(0 != titles.count && titles.count == children.count, "标题数据源和子控制器数据源数量不一致，请检查")
        
        // 设置选项栏标题
        segmentBar.titles = titles;
        
        // 清空之前添加的子控制器
        for child in children {
            child.removeFromParent()
        }
        
        // 添加子控制器
        for child in children {
            addChild(child)
        }
        
        segmentBar.selectedCallback = { [weak self]
            toIndex, _ in
            self?.showViewFromChildren(toIndex)
        }
        // 默认选中首个
        segmentBar.selectedIndex = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
    }
    
    // MARK: - 布局
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var contentViewFrame = view.bounds
        
        // 选项栏视图的位置
        if segmentBar.superview == view {
            segmentBar.frame = CGRect(x: 0, y: 64, width: view.bounds.width, height: 35)
            let y = segmentBar.frame.maxY
            contentViewFrame.origin.y = y
            contentViewFrame.size.height = view.bounds.height - y
        }
        
        // 承载内容视图的位置
        contentView.frame = contentViewFrame
        contentView.contentSize = CGSize(width: CGFloat(children.count) * view.bounds.width, height: 0)
        
        // 子控制器视图的位置
        let count = children.count
        for i in 0..<count {
            let child = children[i]
            let width = contentView.bounds.width
            let x = CGFloat(i) * width
            child.view.frame = CGRect(x: x,
                                      y: 0,
                                      width: width,
                                      height: contentView.bounds.height)
        }
    }
}

// MARK: - 私有方法
extension SegmentBarViewController {
    private func showViewFromChildren(_ atIndex: Int) {
        
        // 数据过滤
        if 0 == children.count || atIndex < 0 || atIndex > children.count - 1 { return }
        
        // 添加子控制器的视图
        let child = children[atIndex]
        contentView.addSubview(child.view)
        
        // 滚动到对应的位置
        contentView.setContentOffset(CGPoint(x: CGFloat(atIndex) * contentView.frame.width, y: 0), animated: true)
    }
}

// MARK: - 代理
extension SegmentBarViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        segmentBar.selectedIndex = index
    }
}
