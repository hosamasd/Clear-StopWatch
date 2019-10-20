//
//  AboutVC.swift
//  Clear StopWatch
//
//  Created by hosam on 10/20/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit
import SafariServices
import MOLH

class AboutVC: UITableViewController {
    let cellID = "cellID"
    
    let img:UIImageView =  {
        let img =  UIImageView(image: #imageLiteral(resourceName: "pict"))
        img.constrainWidth(constant: 60)
        img.constrainHeight(constant: 60)
        img.layer.cornerRadius = 30
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    let label = UILabel(text: "Built By \n HOSAM".localized, font: .systemFont(ofSize: 18), textColor: .black,textAlignment: .left,numberOfLines: 2)
    var sectionTitles = [ "","Follow Us","Language"]
    var links = ["https://apps.apple.com/us/developer/hosam-mohamed/id1482369833","https://github.com/hosamasd?tab=repositories", "https://www.facebook.com/hosammohamedasd", "https://www.linkedin.com/in/hosam-mohamed-425a83119/"]
    
    lazy var headerView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.addSubViews(views: img, label)
        
        img.centerInSuperview()
        label.anchor(top: img.topAnchor, leading: img.trailingAnchor, bottom: nil, trailing: nil,padding: .init(top: 8, left: 8, bottom: 0, right: 0))
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return section == 0 ? headerView : nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            return
            
            
        case 1 :
            if let url = URL(string: links[indexPath.row]){
                let safari = SFSafariViewController(url: url)
                present(safari, animated: true)
                print(links[indexPath.row])
            }
            
        case 2 :
            //reset language
            UIView.animate(withDuration: 1, animations: {
                self.navigationController?.popViewController(animated: true)
            }) { (_) in
                MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
                
                MOLH.reset()
            }
        default:
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? nil : sectionTitles[section]
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 250 : 40
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 0 :  section == 1  ? 4 :  1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! AboutCell
        
        if MOLHLanguage.isRTLLanguage() {
            cell.fieldLabel.textAlignment = .right
        }
        
        if indexPath.section == 0 {
            return UITableViewCell()
        }else  if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.fieldLabel.text = "AppStore".localized
            }else if indexPath.row == 1 {
                cell.fieldLabel.text = "GitHub".localized
            }else if indexPath.row == 2 {
                cell.fieldLabel.text = "Facebook".localized
            }else {
                cell.fieldLabel.text = "LinkedIn".localized
            }
        }else  {
            cell.fieldLabel.text = "English".localized
        }
        
        
        
        
        return cell
    }
    
    // MARK: -user methods
    
    
    func setupViews()  {
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.register(AboutCell.self, forCellReuseIdentifier: cellID)
        
    }
    
}
