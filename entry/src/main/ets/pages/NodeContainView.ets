import { AnimationProperties } from '../other/AnimationProperties'

@Entry
@Component
struct NodeContainView {
  //新建一镜到底的动画类
  @State AnimationProperties: AnimationProperties = new AnimationProperties()
  private listArray: Array<number> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

  build() {
    Stack() {
      List({ space: 20 }) {
        ForEach(this.listArray, (item: number) => {
          ListItem() {
            PostItem({ index: item, AnimationProperties: this.AnimationProperties })
          }
        })
      }.clip(false)
      .alignListItem()
    }
  }
}









