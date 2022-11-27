import UIKit

final class ImageListView: BaseView {
  
  let tableView = UITableView()

  override func setupInitialLayout() {
    addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  override func configureViews() {
    tableView.separatorStyle = .none
  }
  
}
