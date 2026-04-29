import { CpuHelper } from '../util/CpuHelper';
import { HistoryViewModel } from './HistoryViewModel';

export class CpuViewModel {
  private historyVm: HistoryViewModel = new HistoryViewModel();

  async getCpuUsage(): Promise<number> {
    let cpu = new CpuHelper()
    let usage = cpu.getCpuUsage()
    // Record to history periodically or on demand
    return usage
  }

  async getSystemCpuUsage(): Promise<number> {
    let cpu = new CpuHelper()
    return cpu.getSystemCpuUsage()
  }

  async getSystemMemInfo() {
    let cpu = new CpuHelper()
    return cpu.getSystemMemInfo()
  }

  async getGraphicsMemory(): Promise<number> {
    let cpu = new CpuHelper()
    return cpu.getGraphicsMemory()
  }

  async recordSnapshot(): Promise<void> {
    let cpu = new CpuHelper();
    let cpuUsage = cpu.getSystemCpuUsage();
    let memInfo = cpu.getSystemMemInfo();
    await this.historyVm.addSnapshot(cpuUsage, memInfo.totalMem - memInfo.freeMem);
  }
}
