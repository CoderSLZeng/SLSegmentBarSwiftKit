//
//  SegmentBar.swift
//  SLSegmentBarSwiftKit_Example
//
//  Created by CoderSLZeng on 2019/5/24.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class SegmentBar: UIView {
    
    // MARK: 公共属性
    var titles: [String]? {
        willSet(newTitles) {
            
            guard let newTitles = newTitles else {
                return
            }
            
            // 删除之前添加过的标题按钮
            if let titleBtns = titleBtns {
                for btn in titleBtns {
                    btn.removeFromSuperview()
                }
            }
            
            titleBtns?.removeAll()
            titleBtns = nil
            
            // 添加新的标题按钮
            titleBtns = [UIButton]()
            for title in newTitles {
                let btn = UIButton(type: .custom)
                btn.setTitle(title, for: .normal)
                btn.backgroundColor = .green
                contentView?.addSubview(btn)
                titleBtns?.append(btn)
            }
            
            // 手动刷新视图
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    // MARK: 私有属性
    /// 标题按钮之间的最小间隙
    private let minMargin: CGFloat = 30;
    /// 内容承载视图
    private var contentView: UIScrollView?
    /// 标题按钮数据源
    private var titleBtns: [UIButton]?
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        let scrollView = UIScrollView(frame: frame)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        self.addSubview(scrollView)
        contentView = scrollView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let titleBtns = titleBtns else {
            return
        }
        
        contentView?.frame = bounds;
        
        var totalBtnWidth: CGFloat = 0
        
        for btn in titleBtns {
            btn.sizeToFit()
            totalBtnWidth += btn.frame.width
        }
        
        var caculateMargin: CGFloat = (self.frame.width - totalBtnWidth) / CGFloat(titleBtns.count + 1)
        if caculateMargin < minMargin {
            caculateMargin = minMargin
        }
        
        var lastX: CGFloat = caculateMargin
        for btn in titleBtns {
            btn.sizeToFit()
            btn.frame.size.height = frame.height
            btn.frame.origin.y = 0
            btn.frame.origin.x = lastX
            lastX += btn.frame.width + caculateMargin
        }
        
        self.contentView?.contentSize = CGSize(width: lastX, height: 0)
    }
    
}
