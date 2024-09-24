import { curves } from '@kit.ArkUI'
import { faceDetector } from '@kit.CoreVisionKit'

const ITEM_COUNTS = 9
const ITEM_COLOR = "#ED6F21"
const INTERVAL = 30
const DURATION = 300


@Entry
@Component
struct AnimateToDemo {
  @State isGridShow: boolean = false
  private dataArray: number[] = new Array(ITEM_COUNTS)

  aboutToAppear(): void {
    for (let i = 0; i < ITEM_COUNTS; i++) {
      this.dataArray[i] = i
    }
  }

  build() {
    Stack() {
      if (this.isGridShow) {
        Grid() {
          ForEach(this.dataArray, (item: number, index: number) => {
            GridItem() {
              Stack() {
                Text((item + 1).toString())
              }.size({ width: 50, height: 50 })
              .backgroundColor(ITEM_COLOR)
              .transition(TransitionEffect.OPACITY.combine(TransitionEffect.scale({ x: 0.5, y: 0.5 }))
                .animation({ duration: DURATION, curve: Curve.Friction, delay: INTERVAL * index }))
              .borderRadius(10)
            }
            .transition(TransitionEffect.opacity(0.99))
          }, (item: number) => item.toString())
        }
        .columnsTemplate('1fr 1fr 1fr')
        .rowsGap(15)
        .columnsGap(15)
        .size({ width: 180, height: 180 })
        .transition(TransitionEffect.opacity(0.99))
      }
    }
    .size({ width: "100%", height: "100%" })
    .onClick(() => {
      this.getUIContext().animateTo({
        duration: DURATION + INTERVAL * (ITEM_COUNTS - 1),
        curve: Curve.Friction
      }, () => {
        this.isGridShow = !this.isGridShow
      })
    })
  }
}