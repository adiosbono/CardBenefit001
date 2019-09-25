//
//  CardVO.swift
//  CardBenefit
//
//  Created by Bono b Bono on 16/09/2019.
//  Copyright © 2019 Bono b Bono. All rights reserved.
//

import Foundation
import UIKit

struct CardVO {
    var cardId: Int
    var cardName: String
    var image: UIImage?
    var nickName: String?
    var traffic: Int
    var oversea: Int
    var memo: String?
    var orders: Int
}

struct SARVO {
    var shop: String?
    var advantage: String?
    var restrict: String?
}
