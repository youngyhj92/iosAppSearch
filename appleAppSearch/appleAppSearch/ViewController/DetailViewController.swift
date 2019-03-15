//
//  DetailViewController.swift
//  appleAppSearch
//
//  Created by hyunjun yang on 15/03/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//

import UIKit

class DetailViewController : UITableViewController  {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let detailAppInfoNib = UINib(nibName: "DetailAppInfoCell", bundle: nil)
        tableView.register(detailAppInfoNib, forCellReuseIdentifier: "appInfoCell")
        let detailReleasNoteNib = UINib(nibName: "DetailReleaseNoteCell", bundle: nil)
        tableView.register(detailReleasNoteNib, forCellReuseIdentifier: "releaseNoteCell")
        let detailScreenShotNib = UINib(nibName: "DetailScreenShotCell", bundle: nil)
        tableView.register(detailScreenShotNib, forCellReuseIdentifier: "screenshotCell")
        let detailDescriptionNib = UINib(nibName: "DetailDescriptionCell", bundle: nil)
        tableView.register(detailDescriptionNib, forCellReuseIdentifier: "descriptionCell")
        let detailSellerInfoNib = UINib(nibName: "DetailSellerInfoCell", bundle: nil)
        tableView.register(detailSellerInfoNib, forCellReuseIdentifier: "sellerInfo")
        
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = UITableView.automaticDimension
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "appInfoCell", for: indexPath) as! DetailAppInfoCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "releaseNoteCell", for: indexPath) as! DetailReleaseNoteCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "screenshotCell", for: indexPath) as! DetailScreenShotCell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as! DetailDescriptionCell
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "sellerInfo", for: indexPath) as! DetailSellerInfoCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}

class DetailAppInfoCell : UITableViewCell  {
    
    @IBOutlet weak var appLogoImage: UIImageView!
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var companyTitle: UILabel!
    @IBOutlet weak var ratingTitle: UILabel!
    @IBOutlet weak var usageAge: UILabel!
}

class DetailReleaseNoteCell : UITableViewCell  {
    
    @IBOutlet weak var releaseNoteContents: UIView!
    
}

class DetailScreenShotCell : UITableViewCell  {
    
    @IBOutlet weak var firstScreenShot: UIImageView!
    @IBOutlet weak var secondScreenShot: UIImageView!
    @IBOutlet weak var thirdScreenShot: UIImageView!
    
}

class DetailDescriptionCell : UITableViewCell  {
    
    @IBOutlet weak var descriptions: UILabel!
    
}

class DetailSellerInfoCell : UITableViewCell  {
    
    @IBOutlet weak var cellerContent: UIView!
    @IBOutlet weak var appSize: UILabel!
    @IBOutlet weak var appCategory: UILabel!
    @IBOutlet weak var useAge: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var features: UILabel!
    @IBOutlet weak var rights: UILabel!
    
}
