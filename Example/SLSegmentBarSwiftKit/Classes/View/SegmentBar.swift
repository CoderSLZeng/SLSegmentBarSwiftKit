//
//  SegmentBar.swift
//  SLSegmentBarSwiftKit_Example
//
//  Created by CoderSLZeng on 2019/5/24.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class SegmentBar: UIView {
    
    // MARK: - 属性
    // MARK: 公共属性
    var titles = [""] {
        didSet(old) {
            setupTitles(titles)
        }
    }
    
    // MARK: 私有属性
    /// 标题按钮之间的最小间隙
    private let minMargin: CGFloat = 30
    /// 内容承载视图
    private var contentView: UIScrollView?
    /// 标题按钮数据源
    private var titleBtns: [UIButton]?
    /// 最后选中的按钮
    private var lastBtn: UIButton?
    
    private lazy var indicatorView: UIView = {
        let height: CGFloat = 2
        let y = frame.height - height
        let frame = CGRect(x: 0, y: y, width: 0, height: height)
        let view = UIView(frame: frame)
        return view
    }()
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI(frame)
    }
    
    init(frame: CGRect, titles: [String]) {
        super.init(frame: frame)
        setupUI(frame)
        setupTitles(titles)
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
        
        contentView?.frame = bounds
        
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

// MARK: - 设置UI
extension SegmentBar {
    fileprivate func setupUI(_ frame: CGRect) {
        let scrollView = UIScrollView(frame: frame)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        self.addSubview(scrollView)
        self.addSubview(self.indicatorView)
        contentView = scrollView
    }
    
    fileprivate func setupTitles(_ titles: [String]) {
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
        for title in titles {
            let btn = UIButton(type: .custom)
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.setTitleColor(.red, for: .selected)
            btn.addTarget(self, action: #selector(SegmentBar.titleButtonDidClicked), for: .touchUpInside)
            contentView?.addSubview(btn)
            titleBtns?.append(btn)
        }
        
        // 手动刷新视图
        setNeedsLayout()
        layoutIfNeeded()
    }
}

// MARK: - 监听
extension SegmentBar {
    @objc func titleButtonDidClicked(_ btn: UIButton) {
        // 更新选中状态
        lastBtn?.isSelected = false
        btn.isSelected = true
        lastBtn = btn
        
        // 更新指示器视图的位置
        UIView.animate(withDuration: 0.1) {
            self.indicatorView.frame.size.width = btn.frame.width
            self.indicatorView.center.x = btn.center.x
        }
        
        // 更新内容视图的滚动位置
        var scrollX: CGFloat = btn.center.x - contentView!.frame.width * 0.5;
        if scrollX < 0 { scrollX = 0 }
        let maxWidth = contentView!.contentSize.width - contentView!.frame.width
        if scrollX > maxWidth { scrollX = maxWidth }
        contentView?.setContentOffset(CGPoint(x: scrollX, y: 0), animated: true)
        
    }
}
