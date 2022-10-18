//
//  TableViewCell.swift
//  frist-project
//
//  Created by abdallah ragab on 01/08/2022.
//

import UIKit

protocol TableViewCellDelegate: AnyObject {
    func deleteBtn(model: Info?)
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var imageBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!

    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var imagge: UIImageView!

    weak var delegate: TableViewCellDelegate?
    var model: Info? = nil
    static let reuseidentifire = String(describing: TableViewCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        localization()

    }

    func bindData(model: Info?, delegate: TableViewCellDelegate?) {
        self.delegate = delegate
        self.model = model
        self.imagge.loadFrom(URLAddress: model?.img ?? "")
        self.nameLbl.text = model?.userFullname
        self.locationLbl.text = model?.fullAddress
        self.timeLbl.text = convertDateFormater(date: model?.date ?? "")

    }

    func localization() {
        self.nameLbl.text = NSLocalizedString("nameLbl", comment: "")

    }

    func convertDateFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: date) else {
            return ""
        }
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        let timeStamp = dateFormatter.string(from: date)

        return timeStamp
    }

    @IBAction func deleteBtnTapped(_ sender: Any) {
        // call api  with id object in list and refresh list
        delegate?.deleteBtn(model: self.model)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }



}
