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
    var cardName: String = "카드이름"
    var image: UIImage?
    var nickName: String?
    var traffic: Bool
    var oversea: Bool
    var memo: String?
}
