//
//  TextStyle.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import UIKit

enum TextStyle {
    case header1, header2, callout, body, bodyBold, footnote, footnoteBold, smallFootnote
    
    var fontSize: CGFloat {
        self.font?.pointSize ?? 0
    }
    
    var lineHeight: CGFloat {
        switch self {
        case .header1:
            return 44
        case .header2:
            return 32
        case .callout:
            return 28
        case .body:
            return 24
        case .bodyBold:
            return 24
        case .footnote:
            return 16
        case .footnoteBold:
            return 16
        case .smallFootnote:
            return 14
        }
    }
    
    var font: UIFont? {
        switch self {
        case .header1:
            return .header1
        case .header2:
            return .header2
        case .callout:
            return .callout
        case .body:
            return .body
        case .bodyBold:
            return .bodyBold
        case .footnote:
            return .footnote
        case .footnoteBold:
            return .footnoteBold
        case .smallFootnote:
            return .smallFootnote
        }
    }
}
