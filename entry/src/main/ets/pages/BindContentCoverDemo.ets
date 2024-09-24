import { curves } from '@kit.ArkUI'


/**
 * bindContentCover 构建全屏模拟转场效果
 * 显示方式可设置无动画过度，上下切换以及透明渐变的过度方式。
 * 使用方式 通过@Builder 的方式。
 * 使用场景可以延伸到展示一张图，也可以是子页面需要展示的内容。
 * 
 */
interface PersonList {
  name: string,
  cardNum: string
}

@Entry
@Component
struct BindContentCoverDemo {
  private personList: Array<PersonList> = [
    { name: "王**", cardNum: "1234****************789" },
    { name: "刘**", cardNum: "3412****************789" },
    { name: "李**", cardNum: "1111****************789" }
  ]
  @State isPresent: boolean = false

  @Builder
  MyBuilder() {
    Column() {
      Row() {
        Text("选择乘车人")
          .fontSize(20)
          .fontColor(Color.White)
          .width("100%")
          .textAlign(TextAlign.Center)
          .padding({ top: 30, bottom: 15 })
      }
      .backgroundColor(0x007dfe)

      Row() {
        Text("+ 添加乘车人")
          .fontSize(16)
          .fontColor(0x333333)
          .margin({ top: 10 })
          .padding({ top: 20, bottom: 20 })
          .width("92%")
          .borderRadius(10)
          .textAlign(TextAlign.Center)
          .backgroundColor(Color.White)
      }

      Column() {
        ForEach(this.personList, (item: PersonList, index: number) => {
          Row() {
            Column() {
              if (index % 2 == 0) {
                Column()
                  .width(20)
                  .height(20)
                  .border({width:1,color:0x007dfe})
                  .backgroundColor(0x007dfe)
              }else {
                Column()
                  .width(20)
                  .height(20)
                  .border({width:1,color:0x007dfe})
              }
            }
            .width("20%")

            Column(){
              Text(item.name)
                .fontColor(0x333333)
                .fontSize(18)
              Text(item.cardNum)
                .fontColor(0x666666)
                .fontSize(14)
            }
            .width("60%")
            .alignItems(HorizontalAlign.Start)

            Column(){
              Text("编辑")
                .fontColor(0x007dfe)
                .fontSize(16)
            }
            .width("20%")
          }
          .padding({top:10,bottom:10})
          .border({width:{bottom:1},color:0xf1f1f1})
          .width("92%")
          .backgroundColor(Color.White)
        })
      }.padding({top:20,bottom:20})

      Text("确认")
        .width("90%")
        .height(40)
        .textAlign(TextAlign.Center)
        .borderRadius(10)
        .fontColor(Color.White)
        .backgroundColor(0x007dfe)
        .onClick(()=>{
          this.isPresent=!this.personList
        })
    }
    .size({width:"100%",height:"100%"})
    .backgroundColor(0xf5f5f5)
    .transition(TransitionEffect.translate({y:1000}).animation({curve:curves.springMotion(0.6,0.8)}))
  }

  build() {
    Column(){
      Row(){
        Text("确认订单")
          .fontSize(20)
          .fontColor(Color.White)
          .width("100%")
          .textAlign(TextAlign.Center)
          .padding({top:30,bottom:60})
      }.backgroundColor(0x007dffe)

      Column(){
        Row(){
          Column(){
            Text("00:25")
            Text("始发站")
          }.width("30%")

          Column(){
            Text("G1234")
            Text("8时1分")
          }.width("30%")

          Column(){
            Text('08:26')
            Text('终点站')
          }.width('30%')
        }
      }
      .width("92%")
      .padding(15)
      .margin({top:-30})
      .backgroundColor(Color.White)
      .shadow({radius:30,color:"#aaaaaaa"})
      .borderRadius(10)


      Column(){
        Text("+选择乘车人")
          .fontSize(18)
          .fontColor(Color.Orange)
          .fontWeight(FontWeight.Bold)
          .padding({top:10,bottom:10})
          .width("60%")
          .textAlign(TextAlign.Center)
          .borderRadius(15)
          .bindContentCover(this.isPresent,this.MyBuilder(),{
            modalTransition:ModalTransition.DEFAULT,
            onDisappear:()=>{
              this.isPresent =!this.isPresent
            }
          })
          .onClick(()=>{
            this.isPresent =!this.isPresent
          })
      }.padding({top:60})

    }
  }
}