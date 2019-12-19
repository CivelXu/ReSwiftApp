//
//  MemberCell.swift
//  ReSwiftApp
//
//  Created by Civel Xu on 2019/12/18.
//  Copyright © 2019 Civel Xu. All rights reserved.
//

import UIKit
import Kingfisher

final class MemberCell: UITableViewCell {

    static let identify = "MemberCell"

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    func configureData(member: Member) {
        var url = member.headImg?.storageUrl ?? ""
        if !url.isEmpty {
            let width = Int(40 * UIScreen.main.scale)
            let add = "?x-oss-process=image/resize,m_fill,h_\(width),w_\(width)" + "/circle,r_\(width / 2)/format,png"
            url = url + add
        }
        avatar.image = nil
        if let url = URL(string: url) {
            avatar.kf.setImage(with: url)
        }
        name.text = member.name ?? ""
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        avatar.layer.cornerRadius = 20
        avatar.contentMode = .scaleAspectFill
        avatar.backgroundColor = .lightGray
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
