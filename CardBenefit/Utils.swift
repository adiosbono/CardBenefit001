//
//  Utils.swift
//  CardBenefit
//
//  Created by Bono b Bono on 27/09/2019.
//  Copyright © 2019 Bono b Bono. All rights reserved.
//

import Foundation
import UIKit


//메시지 알림창 코드 간소화하기 : UIViewController를 상속하는곳에서 사용가능
extension UIViewController {
    func alert(_ message: String, completion: (()->Void)? = nil) {
        //메인 스레드에서 실행되도록
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .cancel){ (_) in
                completion?()
            }
            alert.addAction(okAction)
            self.present(alert, animated: false)
        }
    }
}
