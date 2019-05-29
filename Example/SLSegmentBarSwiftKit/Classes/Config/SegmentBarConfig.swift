//
//  SegmentBarConfig.swift
//  SLSegmentBarSwiftKit_Example
//
//  Created by CoderSLZeng on 2019/5/28.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class SegmentBarConfig: NSObject {
    
    /// 背景颜色
    var backgroundColor: UIColor = .clear
    /// 最小间距
    var minMargin: CGFloat = 30
    
    /// 标题普通状态颜色
    var titleNormalColor: UIColor = .lightGray
    /// 标题选中状态颜色
    var titleSelectedColor: UIColor = .red
    /// 标题的字体
    var titleFont: UIFont = .systemFont(ofSize: 15)

    /// 指示器的颜色
    var indicatorColor: UIColor = .red
    /// 指示器的高度
    var indicatorHeight: CGFloat = 2
    /// 指示器的额外宽度
    var indicatorExtarWidth: CGFloat = 0
    /// 是否显示指示器
    var isShowIndicator: Bool = true
    
    class var defalutConfig: SegmentBarConfig {
        return SegmentBarConfig()
    }
    
    func backgroundColor(_ color: UIColor) -> SegmentBarConfig {
        backgroundColor = color
        return self
    }
    
    func minMargin(_ margin: CGFloat) -> SegmentBarConfig {
        minMargin = margin
        return self
    }
    
    func titleNormalColor(_ color: UIColor) -> SegmentBarConfig {
        titleNormalColor = color
        return self
    }
    
    func titleSelectedColor(_ color: UIColor) -> SegmentBarConfig {
        titleSelectedColor = color
        return self
    }
    
    func titleFont(_ font: UIFont) -> SegmentBarConfig {
        titleFont = font
        return self
    }
    
    func indicatorColor(_ color: UIColor) -> SegmentBarConfig {
        indicatorColor = color
        return self
    }
    
    func indicatorHeight(_ height: CGFloat) -> SegmentBarConfig {
        indicatorHeight = height
        return self
    }
    
    func indicatorExtarWidth(_ width: CGFloat) -> SegmentBarConfig {
        indicatorExtarWidth = width
        return self
    }
    
    func isShowIndicator(_ isShow: Bool) -> SegmentBarConfig {
        isShowIndicator = isShow
        return self
    }
    
}
