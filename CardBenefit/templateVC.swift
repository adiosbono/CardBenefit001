//
//  templateVC.swift
//  CardBenefit
//
//  Created by Bono b Bono on 22/09/2019.
//  Copyright © 2019 Bono b Bono. All rights reserved.
//

import Foundation
import UIKit

class TableViewControllerTemplateVC: UITableViewController{
    
override func viewDidLoad() {
    <#code#>
}
//화면이 나타날때마다 호출되는 메소드
override func viewWillAppear(_ animated: Bool) {
    <#code#>
}
//테이블 행의 개수를 결정하는 메소드
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    <#code#>
}

//테이블 행을 구성하는 메소드
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    <#code#>
}
//테이블의 특정 행이 선택되었을때 호출되는 메소드
override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    <#code#>
}
//테이블 뷰의 섹션의 수 결정하는 메소드 따로 오버라이드 하지 않으면 기본값은 1임
override func numberOfSections(in tableView: UITableView) -> Int {
    return 3
}
    
}
