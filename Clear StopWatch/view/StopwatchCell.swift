//
//  StopwatchCell.swift
//  Clear StopWatch
//
//  Created by hosam on 10/20/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit
import MOLH

class StopwatchCell: UITableViewCell {
    
    var  stopWatch:StopwatchModel!{
        didSet{
            numberLabel.text = "Lap \(stopWatch.lapCount)"
            timeLabel.text = stopWatch.lapText
        }
    }
    
     let numberLabel = UILabel(text: "", font: .systemFont(ofSize: 20), textColor: .black)
    let timeLabel = UILabel(text: "", font: .systemFont(ofSize: 20), textColor: .black)
    var isRTL:Bool = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews()  {
        backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        if MOLHLanguage.isRTLLanguage() {
             hstack(timeLabel,UIView(),numberLabel, spacing: 8, alignment: .center).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
        }else {
             hstack(numberLabel,timeLabel, spacing: 8, alignment: .center).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
        }
      
    }
    
}
