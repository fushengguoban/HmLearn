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
  private allPostData: PostData[] = [
    {
      avatar: $r('app.media.foreground'),
      name: 'Alice',
      message: "天气晴朗",
      images: [$r('app.media.startIcon'), $r('app.media.layered_image')]
    },
    {
      avatar: $r('app.media.foreground'),
      name: 'Alice',
      message: "你好世界",
      images: [$r('app.media.startIcon'), $r('app.media.layered_image')]
    },
    {
      avatar: $r('app.media.foreground'),
      name: 'Alice',
      message: "万物生长",
      images: [$r('app.media.startIcon'), $r('app.media.layered_image')]
    },
  ]

  onItemClicked(changedPropertyName: string) {
    if (this.selectedIndex < 0) {
      return
    }
    this.getUIContext().animateTo({
      duration: 350,
      curve: Curve.Friction
    }, () => {
      this.isExpand = !this.isExpand
    })
  }

  build() {
    Column({ space: 20 }) {
      ForEach(this.allPostData, (postData: PostData, index: number) => {
        if (!this.isExpand || this.selectedIndex === index) {
          Column() {
            Post({ data: postData, selectedIndex: this.selectedIndex, index: index })
          }.width("100%")
        }
      }, (postData: PostData, index: number) => index.toString())
    }.size({width:"100%",height:"100%"})
    .backgroundColor("#40808080")
  }
}

@Component
export default struct Post {
  @Link selectedIndex: number
  @Prop data: PostData
  @Prop index: number
  @State itemHeight: number = 250
  @State isExpand: boolean = false
  @State expandImageSize: number = 100
  @State avatarSize: number = 50


  build() {
    Column({ space: 20 }) {
      Row({ space: 10 }) {
        Image(this.data.avatar)
          .size({ width: this.avatarSize, height: this.avatarSize })
          .borderRadius(this.avatarSize / 2)
          .clip(true)

        Text(this.data.name)
      }
      .justifyContent(FlexAlign.Start)

      Text(this.data.message)

      Row({ space: 15 }) {
        ForEach(this.data.images, (imageResource: Resource, index: number) => {
          Image(imageResource)
            .size({ width: this.expandImageSize, height: this.expandImageSize })
        }, (imageResource: Resource, index: number) => index.toString())
      }

      if (this.isExpand) {
        Column() {
          Text("评论区")
            .transition(TransitionEffect.OPACITY.animation({
              duration: 350, curve: Curve.Friction
            })).padding({ top: 10 })
        }
        .transition(TransitionEffect.asymmetric(
          TransitionEffect.opacity(0.99)
            .animation({ duration: 350, curve: Curve.Friction }),
          TransitionEffect.OPACITY.animation({ duration: 0 })
        )).size({ width: "100%" })
      }
    }
    .backgroundColor(Color.White)
    .size({ width: "100%", height: this.itemHeight })
    .alignItems(HorizontalAlign.Start)
    .padding({ left: 10, top: 10 })
    .onClick(() => {
      this.selectedIndex = -1
      this.selectedIndex = this.index
      this.getUIContext().animateTo({
        duration: 350,
        curve: Curve.Friction
      }, () => {
        this.isExpand = !this.isExpand
        this.itemHeight = this.isExpand ? 780 : 250
        this.avatarSize = this.isExpand ? 75 : 50
        this.expandImageSize = (this.isExpand && this.data.images.length > 0) ?
          (360 - (this.data.images.length + 1) * 15) / this.data.images.length : 100
      })
    })
  }
}