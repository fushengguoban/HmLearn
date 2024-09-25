import { RectInfoInPx } from './ComponentAttUtils'
import { MyNodeController } from './MyNodeController'
import { WindowUtils } from './WindowUtils'
import { curves } from '@kit.ArkUI'

const TAG: string = "AnimationProperties"
const DEVICE_BORDER_RADIUS: number = 34

@Observed
export class AnimationProperties {
  public navDestinationBgColor: ResourceColor = Color.Transparent
  public translateX: number = 0
  public translateY: number = 0
  public scaleValue: number = 1
  public clipWidth: Dimension = 0
  public clipHeight: Dimension = 0
  public radius: number = 0
  public positionValue: number = 0
  public showDetailContent: boolean = false

  public doAnimation(cardItemInfo_px: RectInfoInPx, isPush: boolean, isExit: boolean,
    transitionProxy: NavigationTransitionProxy,
    extraTranslateValue: number, prePageOnFinish: (index: MyNodeController) => void,
    myNodeController: MyNodeController | undefined): void {
    //首先计算卡片的宽高与窗口宽高的比例
    let widthScaleRatio = cardItemInfo_px.width / WindowUtils.windowWidth_px
    let heightScaleRatio = cardItemInfo_px.height / WindowUtils.windowHeight_px
    let isUseWidthScale = widthScaleRatio > heightScaleRatio
    let initScale: number = isUseWidthScale ? widthScaleRatio : heightScaleRatio
    let initTranslateX: number = 0
    let initTranslateY: number = 0
    let initClipWidth: Dimension = 0
    let initClipHeight: Dimension = 0

    let initPositionValue: number = -px2vp(WindowUtils.topAvoidAreHeight_px + extraTranslateValue)
    if (isUseWidthScale) {
      initTranslateX = px2vp(cardItemInfo_px.left - (WindowUtils.windowWidth_px - cardItemInfo_px.width) / 2);
      initClipWidth = '100%';
      initClipHeight = px2vp((cardItemInfo_px.height) / initScale);
      initTranslateY = px2vp(cardItemInfo_px.top - ((vp2px(initClipHeight) - vp2px(initClipHeight) * initScale) / 2));
    } else {
      initTranslateY = px2vp(cardItemInfo_px.top - (WindowUtils.windowHeight_px - cardItemInfo_px.height) / 2);
      initClipHeight = '100%';
      initClipWidth = px2vp((cardItemInfo_px.width) / initScale);
      initTranslateX = px2vp(cardItemInfo_px.left - (WindowUtils.windowWidth_px / 2 - cardItemInfo_px.width / 2));
    }

    console.log(TAG, 'initScale: ' + initScale + ' initTranslateX ' + initTranslateX +
      ' initTranslateY ' + initTranslateY + ' initClipWidth ' + initClipWidth +
      ' initClipHeight ' + initClipHeight + ' initPositionValue ' + initPositionValue);

    //转场至新页面
    if (isPush && !isExit) {
      this.scaleValue = initScale;
      this.translateX = initTranslateX;
      this.clipWidth = initClipWidth;
      this.clipHeight = initClipHeight;
      this.translateY = initTranslateY;
      this.positionValue = initPositionValue;

      animateTo({
        curve: curves.interpolatingSpring(0, 1, 328, 36),
        onFinish: () => {
          if (transitionProxy) {
            transitionProxy.finishTransition()
          }
        }
      }, () => {
        this.scaleValue = 1.0;
        this.translateX = 0;
        this.translateY = 0;
        this.clipWidth = '100%';
        this.clipHeight = '100%';
        // 页面圆角与系统圆角一致
        this.radius = DEVICE_BORDER_RADIUS;
        this.showDetailContent = true;
      })

      animateTo({
        duration: 100,
        curve: Curve.Sharp
      }, () => {
        this.navDestinationBgColor = "#00ffffff"
      })
    } else if (!isPush && !isExit) {
      animateTo({
        duration: 350,
        curve: Curve.EaseInOut,
        onFinish: () => {
          if (transitionProxy) {
            transitionProxy.finishTransition()
          }
          prePageOnFinish(myNodeController)
          if (myNodeController != undefined) {
            (myNodeController as MyNodeController).onRemove()
          }
        }
      }, () => {
        this.scaleValue = initScale;
        this.translateX = initTranslateX;
        this.translateY = initTranslateY;
        this.radius = 0;
        this.clipWidth = initClipWidth;
        this.clipHeight = initClipHeight;
        this.showDetailContent = false;
      })

      animateTo({
        duration: 200,
        delay: 150,
        curve: Curve.Friction
      }, () => {
        this.navDestinationBgColor = Color.Transparent
      })
    }
  }
}
