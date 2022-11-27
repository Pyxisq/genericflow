import UIKit

final class ImageDescriptionViewController: UIViewController, ImageDescriptionModule {

  private let image: Image

  init(image: Image) {
    self.image = image
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    let view = UINib(nibName: "ImageDescriptionView", bundle: nil)
      .instantiate(withOwner: nil, options: nil)[0] as! ImageDescriptionView
    view.set(image: image)
    self.view = view
  }

}
