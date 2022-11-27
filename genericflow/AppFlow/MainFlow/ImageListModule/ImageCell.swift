import UIKit
import Kingfisher

final class ImageCell: UITableViewCell {

  private let thumbnailView = UIImageView()
  private let nameLabel = UILabel()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupInitialLayout()
    configureViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupInitialLayout() {
    let contentStackView = UIStackView(
      views: [thumbnailView, nameLabel],
      axis: .horizontal,
      distribution: .fillProportionally,
      alignment: .center,
      spacing: 16
    )

    contentView.addSubview(contentStackView)
    contentStackView.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(8)
    }

    thumbnailView.snp.makeConstraints { make in
      make.height.equalTo(100)
    }
  }

  private func configureViews() {
    thumbnailView.contentMode = .scaleAspectFit
  }

  func set(name: String, thumbnailUrl: String) {
    nameLabel.text = name
    thumbnailView.kf.setImage(with: URL(string: thumbnailUrl), options: [.cacheMemoryOnly])
  }
}
