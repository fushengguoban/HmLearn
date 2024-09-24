import { faceDetector } from '@kit.CoreVisionKit'

class PostData {
  avatar: Resource = $r('app.media.app_icon')
  name: string = ""
  message: string = ""
  images: Resource[] = []
}

@Entry
@Component
struct MyExtendView {
  @State isExpand: boolean = false
  @State @Watch('onItemClicked') selectedIndex: number = -1

  private allPostData:PostData[] = [
    {avatar:$r('app.media.foreground'),name:'Alice',message:"天气晴朗",
    images:[$r('app.media.startIcon')]}
  ]

  build() {
  }

  onItemClicked(changedPropertyName: string) {
  }
}