//
//  SegmentBar.swift
//  SLSegmentBarSwiftKit_Example
//
//  Created by CoderSLZeng on 2019/5/24.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

@objc protocol SegmentBarDelegate: class {
    @objc func selected(toIndex: Int, fromIndex: Int)
}

class SegmentBar: UIView {
    
    // MARK: - 属性
    // MARK: 公共属性
    var titles = [""] {
        didSet {
            setupTitles(titles)
        }
    }
    
    var selectedIndex = 0 {
        didSet(old) {
            // 数据过滤
            guard let titleBtns = titleBtns else { return }
            if 0 == titleBtns.count || selectedIndex < 0 || selectedIndex > titleBtns.count - 1 { return }
            
            let btn = titleBtns[selectedIndex]
            titleButtonDidClicked(btn)
        }
    }
    
    weak var delegate: SegmentBarDelegate?
    
    var selectedCallback: ((_ toIndex: Int, _ fromIndex: Int) -> ())?
    
    // MARK: 私有属性
    /// 内容承载视图
    private var contentView: UIScrollView?
    /// 标题按钮数据源
    private var titleBtns: [UIButton]?
    /// 最后选中的按钮
    private var lastBtn: UIButton?
    
    private lazy var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = config.indicatorColor
        contentView?.addSubview(view)
        return view
    }()
    
    private lazy var config: SegmentBarConfig = SegmentBarConfig.defalutConfig
    
    // MARK: - 生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 数据校验
        guard let titleBtns = titleBtns else {return }
        
        // 承载内容视图的位置
        contentView?.frame = bounds
        
        // 计算标题按钮之前的间距
        var totalBtnWidth: CGFloat = 0
        
        for btn in titleBtns {
            btn.sizeToFit()
            totalBtnWidth += btn.frame.width
        }
        
        var caculateMargin: CGFloat = (frame.width - totalBtnWidth) / CGFloat(titleBtns.count + 1)
        if caculateMargin < config.minMargin {
            caculateMargin = config.minMargin
        }
        
        // 标题按钮的位置
        var lastX: CGFloat = caculateMargin
        for btn in titleBtns {
            btn.sizeToFit()
            btn.frame.size.height = frame.height
            btn.frame.origin.y = 0
            btn.frame.origin.x = lastX
            lastX += btn.frame.width + caculateMargin
        }
        
        // 承载内容视图的内容大小
        contentView?.contentSize = CGSize(width: lastX, height: 0)
        
        if config.isShowIndicator == false {
            indicatorView.frame = CGRect.zero
            return
        }
        
        // 指示器的位置
        let btn = titleBtns[selectedIndex]
        indicatorView.frame = CGRect(x: btn.frame.origin.x,
                                     y: bounds.height - config.indicatorHeight,
                                     width: btn.bounds.width + config.indicatorExtarWidth * 2,
                                     height: config.indicatorHeight)
        indicatorView.center.x = btn.center.x
    }
    
}

// MARK: - 接口
extension SegmentBar {
    convenience init(frame: CGRect, titles: [String]) {
        self.init(frame: frame)
        setupTitles(titles)
    }
    
    func update(_ configCallBack: (_ config: SegmentBarConfig) -> ()) {
        
        configCallBack(config)
        
        backgroundColor = config.backgroundColor
        
        guard let titleBtns = titleBtns else { return }
        for btn in titleBtns {
            btn.setTitleColor(config.titleNormalColor, for: .normal)
            btn.setTitleColor(config.titleSelectedColor, for: .selected)
            btn.titleLabel?.font = config.titleFont
        }
        
        indicatorView.backgroundColor = config.indicatorColor
        
        setNeedsLayout()
        layoutIfNeeded()
        
    }
}

// MARK: - 设置UI
extension SegmentBar {
    fileprivate func setupUI(_ frame: CGRect) {
        let scrollView = UIScrollView(frame: frame)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        addSubview(scrollView)
        contentView = scrollView
    }
    
    fileprivate func setupTitles(_ titles: [String]) {
        
        assert(0 != titles.count, "标题数据源不能为空")
        
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
            btn.setTitleColor(config.titleNormalColor, for: .normal)
            btn.setTitleColor(config.titleSelectedColor, for: .selected)
            btn.titleLabel?.font = config.titleFont
            btn.addTarget(self, action: #selector(SegmentBar.titleButtonDidClicked), for: .touchUpInside)
            btn.tag = titleBtns!.count
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
        
        delegate?.selected(toIndex: btn.tag, fromIndex: lastBtn?.tag ?? 0)
        
        if selectedCallback != nil {
            selectedCallback!(btn.tag, lastBtn?.tag ?? 0)
        }
        
        // 更新选中状态
        lastBtn?.isSelected = false
        btn.isSelected = true
        lastBtn = btn
        
        // 更新指示器视图的位置
        UIView.animate(withDuration: 0.1) {
            self.indicatorView.frame.size.width = btn.frame.width + self.config.indicatorExtarWidth * 2
            self.indicatorView.center.x = btn.center.x
        }
        
        // 更新内容视图的滚动位置
        if 0 == frame.width { return }
        var scrollX: CGFloat = btn.center.x - contentView!.frame.width * 0.5
        if scrollX < 0 { scrollX = 0 }
        let maxWidth = contentView!.contentSize.width - contentView!.frame.width
        if scrollX > maxWidth { scrollX = maxWidth }
        contentView?.setContentOffset(CGPoint(x: scrollX, y: 0), animated: true)
        
    }
}
