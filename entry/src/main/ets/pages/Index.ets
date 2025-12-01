@Entry
@Component
export struct Index {
  pageInfos: NavPathStack = new NavPathStack();
  scroll : Scroller = new Scroller()

  aboutToAppear(): void {

  }

  build() {

    Navigation(this.pageInfos) {

  Scroll(this.scroll){
    Column() {
      Button('Dashboard')
        .width('80%').height(30)

        .onClick(() => {
          this.pageInfos.pushPath({
            name: 'Dashboard'
          }); // Push the navigation destination page specified by name to the routing stack.
        })
      Button('Graph').width('80%').height(30).margin({ top:8 })

        .onClick(() => {
          this.pageInfos.pushPath({
            name: 'Graph'
          }); // Push the navigation destination page specified by name to the routing stack.
        })
      Button('Clear Watch').width('80%').height(30).margin({ top:8 })

        .onClick(() => {
          this.pageInfos.pushPath({
            name: 'ClearWatch'
          }); // Push the navigation destination page specified by name to the routing stack.
        })
    }.justifyContent(FlexAlign.Center)
  }.width('100%').height('100%').backgroundColor(Color.White)

    }.title('NavIndex').hideTitleBar(true)

  }
}