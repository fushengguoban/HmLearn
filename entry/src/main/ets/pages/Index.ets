import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.pageInfos) {
      RelativeContainer() {
        Text(this.message)
          .id('HelloWorld')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
          .onClick(event => {
            // this.pageInfos.pushPath({ name: "secondPage" })
            router.pushUrl({
              url: 'pages/BindSheetDemo ' // 目标url
            }, router.RouterMode.Standard, (err) => {
              if (err) {
                console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
                return;
              }
              console.info('Invoke pushUrl succeeded.');
            });
          })
      }
      .height('100%')
      .width('100%')
    }.mode(NavigationMode.Stack)
  }
}