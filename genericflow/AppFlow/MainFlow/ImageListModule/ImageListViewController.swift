import RxSwift

final class ImageListViewContoller: BaseViewController<ImageListView>, ImageListModule {

  var onImageTap: (Image) -> Void = { _ in }

  var viewModel: ImageListViewModel!

  override func setupView() {
    rootView.tableView.register(ImageCell.self, forCellReuseIdentifier: "ImageCell")
    rootView.tableView.estimatedRowHeight = 153
  }

  override func bindView() {
    rootView.tableView.rx.modelSelected(Image.self)
      .bind { [unowned self] image in
        self.onImageTap(image)
      }
      .disposed(by: disposeBag)

    rootView.tableView.rx.itemSelected
      .bind { [rootView] indexPath in
        rootView.tableView.deselectRow(at: indexPath, animated: true)
      }
      .disposed(by: disposeBag)
  }

  override func bindViewModel() {
    let output = viewModel.transform(
      input: .init(
        loadList: rootView.tableView.rx.reachedBottom.startWith(())
      )
    )

    // handle error state
    // add button to reload or other ux solution
    output.listSequence.errors
      .bind { _ in }
      .disposed(by: disposeBag)

    // show loading state at the bottom of table
    output.listSequence.loading
      .bind { _ in }
      .disposed(by: disposeBag)

    output.list.bind(to: rootView.tableView.rx.items(cellIdentifier: "ImageCell", cellType: ImageCell.self)) { _, model, cell in
      cell.set(name: model.user, thumbnailUrl: model.previewURL)
    }
    .disposed(by: disposeBag)

    output.listSequence
      .connect()
      .disposed(by: disposeBag)
  }
}
