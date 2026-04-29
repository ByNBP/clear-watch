import { common } from '@kit.AbilityKit';
import { CpuViewModel } from '../viewmodel/CpuViewModel';
import { hidebug } from '@kit.PerformanceAnalysisKit';
import { Cpu } from '../model/Cpu';


@Builder
export function PageOneBuilder(name: string, param: Object) {
  Dashboard()
}

@Component
export struct Dashboard {
  vm: CpuViewModel = new CpuViewModel()
  @Consume('pageInfos') pageInfos: NavPathStack;
  context = this.getUIContext().getHostContext() as common.UIAbilityContext
  cpu: Cpu = new Cpu()

  aboutToAppear(): void {
    this.vm.getCpuUsage().then((ret) => {
      this.cpu.getCpuUsage = ret
    })
    this.vm.getSystemCpuUsage().then((ret) => {
      this.cpu.getSystemCpuUsage = ret
    })

    this.vm.getCpuUsage().then((ret) => {
      this.cpu.getCpuUsage = ret
    })
    this.vm.getGraphicsMemory().then((ret) => {
      this.cpu.getGraphicsMemory = ret
    })
    this.vm.getGraphicsMemory().then((mem) => {
      this.cpu.getGraphicsMemory = mem
    })
  }

  build() {
    NavDestination(){
      Scroll() {
        Column({ space: 10 }) {
          Text('Dashboard').fontSize('20px').fontWeight(FontWeight.Bold).textAlign(TextAlign.Center)
          Column() {
            Text(`CPU Process Usage: ${this.cpu.getCpuUsage.toFixed(2)}%`).fontSize('14px')
            Text(`System Cpu Usage: ${this.cpu.getSystemCpuUsage.toFixed(2)}%`).fontSize('14px')
          }.width('100%').alignItems(HorizontalAlign.Center)

          Column() {
            Text(`Graphic Memory : ${this.cpu.getGraphicsMemory}`).fontSize('14px')
            Text(`Total Mem : ${this.cpu.getSystemMemInfo.totalMem} KB`).fontSize('14px')
            Text(`Free Mem : ${this.cpu.getSystemMemInfo.freeMem} KB`).fontSize('14px')
            Text(`Avail Mem : ${this.cpu.getSystemMemInfo.availableMem} KB`).fontSize('14px')
          }.width('100%').alignItems(HorizontalAlign.Center)

          Button('View History')
            .onClick(() => {
              this.pageInfos.pushPath({ name: 'HistoryPage' })
            })
            .width('80%')
            .height(30)
            .fontSize(12)
        }
        .width('100%')
        .padding({ bottom: 20 })
      }
    }.hideBackButton(true)
  }
}
