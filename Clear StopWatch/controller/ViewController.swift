//
//  ViewController.swift
//  Clear StopWatch
//
//  Created by hosam on 10/20/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit
import MOLH
class ViewController: UIViewController {
    
    let smallLabel = UILabel(text: "00:00:00", font: .systemFont(ofSize: 20), textColor: .black,textAlignment: .right)
    let bigLabel = UILabel(text: "00:00:00", font: .systemFont(ofSize: 50), textColor: .black,textAlignment: .center)
    lazy var startButton:UIButton = {
        let bt = UIButton(title: "Start".localized, titleColor: .green, font: .systemFont(ofSize: 18), backgroundColor: .white, target: self, action: #selector(handleStart))
        bt.constrainHeight(constant: 70)
        bt.constrainWidth(constant: 70)
        bt.layer.cornerRadius = 35
        bt.clipsToBounds = true
        return bt
    }()
    lazy var labButton:UIButton = {
        let bt = UIButton(title: "Lap".localized, titleColor: .gray, font: .systemFont(ofSize: 18), backgroundColor: .white, target: self, action: #selector(handleLab))
        bt.constrainHeight(constant: 70)
        bt.constrainWidth(constant: 70)
        bt.layer.cornerRadius = 35
        bt.clipsToBounds = true
        bt.isEnabled = false
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
    fileprivate var timer = Timer()
    fileprivate var isBegin:Bool = false
    fileprivate var seconds:    Int = 0
    fileprivate var lapCount:Int = 0
    var stopwatchArray = [StopwatchModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigations()
        setupViews()
    }
    
     // MARK: -user methods
    
    func setupNavigations()  {
        let titleLbl = UILabel()
        
        let attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "Clear ".localized, attributes: [.foregroundColor : UIColor.red,.font:UIFont.boldSystemFont(ofSize: 26)]))
        attributedText.append(NSAttributedString(string: "Stopwatch".localized, attributes: [.foregroundColor : UIColor.orange,.font:UIFont.systemFont(ofSize: 26)]))
        titleLbl.attributedText = attributedText
        navigationItem.titleView = titleLbl
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "About".localized, style: .plain, target: self, action: #selector(handleAbout))
    }
    
    fileprivate func setupViews()  {
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
        
        tableView.anchor(top: subView.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 8, left: 0, bottom: 0, right: 0))
    }
    
    
    
    fileprivate func startButtons(sender:UIButton)  {
        isBegin = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        sender.setTitle("Stop".localized, for: .normal)
        sender.setTitleColor(.red, for: .normal)
        labButton.setTitle("Lap".localized, for: .normal)
        labButton.isEnabled = true
    }
    
    fileprivate func stopButtons(sender:UIButton)  {
        timer.invalidate()
        sender.setTitle("Start".localized, for: .normal)
        sender.setTitleColor(.green, for: .normal)
        labButton.setTitle("Reset".localized, for: .normal)
        
    }
    
    
    
    fileprivate  func makeLapButton(sender:UIButton)  {
        guard let text = bigLabel.text else { return  }
        let stop = StopwatchModel(counter: seconds, lapCount: lapCount + 1, lapText: text)
        stopwatchArray.append(stop)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        lapCount += 1
    }
    
    fileprivate func makeResetButton(sender:UIButton)  {
        isBegin = false
        labButton.isEnabled = false
        labButton.setTitle("Lap".localized, for: .normal)
        timer.invalidate()
        seconds = 0
        lapCount = 0
        stopwatchArray.removeAll()
        DispatchQueue.main.async {
            self.upadteLabels()
            self.tableView.reloadData()
        }
        
    }
    
    fileprivate func upadteLabels() {
        bigLabel.text = timeString(time: TimeInterval(seconds))
        smallLabel.text = timeString(time: TimeInterval(seconds))
    }
    
    fileprivate func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    //TODO: -handle Methods
    
    @objc fileprivate func updateTimer() {
        seconds += 1
        upadteLabels()
        
    }
    
    @objc fileprivate func handleAbout()  {
        let about = AboutVC()
        navigationController?.pushViewController(about, animated: true)
    }
    
    @objc fileprivate func handleLab(sender:UIButton)  {
        sender.isEnabled = isBegin ? true : false
        sender.titleLabel?.text == "Lap".localized ?  makeLapButton(sender: sender) : makeResetButton(sender: sender)
    }
    
    @objc fileprivate  func handleStart(sender:UIButton)  {
        if sender.titleLabel?.text == "Stop".localized {
            stopButtons(sender: sender)
        }else {
            startButtons(sender: sender)
        }
        upadteLabels()
    }
    
}

 // MARK: -extension methods

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stopwatchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! StopwatchCell
        let stop = stopwatchArray[indexPath.row]
        
        cell.stopWatch = stop
        
        
        return cell
    }
    
    
}
