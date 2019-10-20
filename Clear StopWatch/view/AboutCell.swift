//
//  AboutCell.swift
//  Clear StopWatch
//
//  Created by hosam on 10/20/19.
//  Copyright © 2019 hosam. All rights reserved.
//


import UIKit

class AboutCell: UITableViewCell {
    let fieldLabel:UILabel = {
        let la = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: .black)
        return la
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupViews()  {
        backgroundColor = .white
        stack(fieldLabel).withMargins(.init(top: 0, left: 20, bottom: 0, right: 16))
        
    }
}
