import { ClearWatchViewModel } from '../viewmodel/ClearWatchViewModel';
import { common } from '@kit.AbilityKit';


@Builder
export function PageThreeBuilder(name: string, param: Object) {
  ClearWatch()
}

@Component
struct ClearWatch {
  @State vm: ClearWatchViewModel = new ClearWatchViewModel();
  context = this.getUIContext().getHostContext() as common.UIAbilityContext
  scroll: Scroller = new Scroller()
  @State status :string= ''

  build() {
    NavDestination() {
      Scroll(this.scroll) {
        Column({ space: 12 }) {
          Text('🧹 Cache Cleaner').fontColor(Color.Black)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 16 });

          Button('Cache List File')
            .onClick(() => this.vm.loadCacheFiles( this.context, (status) => {
              this.status = status
            }))
            .width('90%')
            .height(40);

          Button('Clear')
            .onClick(() => this.vm.clearCache(this.context, (status) => {
              this.status = status
            }))
            .width('90%')
            .height(40)
            .backgroundColor('#4CAF50')
            .fontColor('#fff');
          Text(`Cache Path : ${this.context.cacheDir}`).fontColor(Color.Black).fontSize(8)
          Text(this.status).fontColor(Color.Black)
            .fontSize(10)
            .margin({ top: 12 });

          if (this.vm.cacheFiles.length > 0) {
            List() {
              ForEach(this.vm.deletedFiles, (file: string) => {
                ListItem() {
                  Text(`🗑️ ${file}`).textAlign(TextAlign.Center).width('100%')
                    .fontSize(10).fontColor(Color.Black);
                }
              });

            }.margin({ top: 10 });
          }
        }
        .padding(20)
        .backgroundColor('#F8F8F8')

      }
    }.hideBackButton(true)
  }
}
