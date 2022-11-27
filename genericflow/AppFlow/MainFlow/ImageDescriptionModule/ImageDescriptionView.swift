import UIKit
import Kingfisher

final class ImageDescriptionView: UIView {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var imageSizeLabel: UILabel!
  @IBOutlet weak var imageTypeLabel: UILabel!
  @IBOutlet weak var imageTagsLabel: UILabel!

  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var viewsLabel: UILabel!
  @IBOutlet weak var likesLabel: UILabel!
  @IBOutlet weak var commentsLabel: UILabel!
  @IBOutlet weak var downloadsLabel: UILabel!

  func set(image: Image) {
    imageView.kf.setImage(with: URL(string: image.largeImageURL), options: [.cacheMemoryOnly])
    imageSizeLabel.text = "Size: \(image.imageSize)"
    imageTypeLabel.text = "Type: \(image.type)"
    imageTagsLabel.text = "Tags: \(image.tags)"

    userNameLabel.text = image.user
    viewsLabel.text = "Views: \(image.views)"
    likesLabel.text = "Likes: \(image.likes)"
    commentsLabel.text = "Comments: \(image.comments)"
    downloadsLabel.text = "Downloads: \(image.downloads)"
  }

}
