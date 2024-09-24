class PostData {
  avatar: Resource = $r('app.media.app_icon')
  name: string = ""
  message: string = ""
  images: Resource[] = []
}

@Entry
@Component
struct MyExtendView {
  @Link isExpand: boolean
  @State cardList: Array<PostData> = xxxx;

  build() {
  }
}