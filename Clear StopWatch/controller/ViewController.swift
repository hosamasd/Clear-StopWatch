//
//  ViewController.swift
//  Clear StopWatch
//
//  Created by hosam on 10/20/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let smallLabel = UILabel(text: "00:00:00", font: .systemFont(ofSize: 20), textColor: .black,textAlignment: .right)
     let bigLabel = UILabel(text: "00:00:00", font: .systemFont(ofSize: 50), textColor: .black,textAlignment: .center)
    lazy var startButton:UIButton = {
        let bt = UIButton(title: "Start", titleColor: .green, font: .systemFont(ofSize: 18), backgroundColor: .white, target: self, action: #selector(handleStart))
        bt.constrainHeight(constant: 60)
        bt.constrainWidth(constant: 60)
        bt.layer.cornerRadius = 30
        bt.clipsToBounds = true
        return bt
    }()
    lazy var labButton:UIButton = {
        let bt = UIButton(title: "Lab", titleColor: .gray, font: .systemFont(ofSize: 18), backgroundColor: .white, target: self, action: #selector(handleLab))
         bt.constrainHeight(constant: 60)
        bt.constrainWidth(constant: 60)
        bt.layer.cornerRadius = 30
        bt.clipsToBounds = true
        return bt
    }()
    lazy var mainView:UIView = {
       let m = UIView(backgroundColor: .white)
        m.constrainHeight(constant: 120)
        m.addSubViews(views: smallLabel,bigLabel)
        return m
    }()
    lazy var subView:UIView = {
        let m = UIView(backgroundColor: #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1))
        m.constrainHeight(constant: 100)
         m.addSubViews(views: startButton,labButton)
        return m
    }()
    lazy var tableView:UITableView = {
       let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.backgroundColor = .white
        t.register(StopwatchCell.self, forCellReuseIdentifier: cellID)
        return t
    }()
    fileprivate let cellID = "cellID"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }


    func setupViews()  {
        view.backgroundColor = .white
       [smallLabel,bigLabel].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        view.addSubViews(views: mainView,subView,tableView)
        
        mainView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 16, left: 8, bottom: 0, right: 8))
        
        smallLabel.anchor(top: mainView.topAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 40, left: 0, bottom: 0, right: 0))
        smallLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        bigLabel.anchor(top: smallLabel.bottomAnchor, leading: nil, bottom: nil, trailing: smallLabel.trailingAnchor,padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        bigLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        
         subView.anchor(top: mainView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 20, left: 8, bottom: 0, right: 8))
         startButton.anchor(top: subView.topAnchor, leading: nil, bottom: nil, trailing: bigLabel.trailingAnchor,padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        labButton.anchor(top: subView.topAnchor, leading: bigLabel.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        
        tableView.anchor(top: subView.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }
    
  @objc  func handleStart()  {
        print(154)
    }
    
    @objc  func handleLab()  {
        print(154)
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! StopwatchCell
        
        return cell
    }
    
    
}
