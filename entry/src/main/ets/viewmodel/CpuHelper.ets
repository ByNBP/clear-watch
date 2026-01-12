import { hidebug } from '@kit.PerformanceAnalysisKit';
import file from '@kit.CoreFileKit'
import { BusinessError } from '@kit.BasicServicesKit';

export class CpuHelper {
  cachePath: string = '';
  cacheDir: string = '';

  getCpuUsage() {
    let cpuUsage: number = hidebug.getCpuUsage();
    return cpuUsage
  }

  getSystemCpuUsage() {
    let getSystemCpuUsage = hidebug.getSystemCpuUsage()
    return getSystemCpuUsage
  }

  getSystemMemInfo(): hidebug.SystemMemInfo {
    let systemMemInfo: hidebug.SystemMemInfo = hidebug.getSystemMemInfo();
    return systemMemInfo
  }
  getGraphicsMemory(): number {
    hidebug.getGraphicsMemory().then((ret: number) => {
      console.info(`graphicsMemory: ${ret}`)
      return ret
    }).catch((error: BusinessError) => {
      console.error(`error code: ${error.code}, error msg: ${error.message}`);
      return error.code
    })
    return 0;
  }
}