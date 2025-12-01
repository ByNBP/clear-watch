import { hidebug } from '@kit.PerformanceAnalysisKit';

export class Cpu {
  private _getCpuUsage: number = 0;

  public set getCpuUsage(value: number) {
    this._getCpuUsage = value;
  }

  public get getCpuUsage(): number {
    return this._getCpuUsage;
  }

  private _getSystemCpuUsage: number = 0;

  public set getSystemCpuUsage(value: number) {
    this._getSystemCpuUsage = value;
  }

  public get getSystemCpuUsage(): number {
    return this._getSystemCpuUsage;
  }

  private _getSystemMemInfo: hidebug.SystemMemInfo = hidebug.getSystemMemInfo()

  public get getSystemMemInfo(): hidebug.SystemMemInfo {
    return this._getSystemMemInfo;
  }

  public set getSystemMemInfo(value: hidebug.SystemMemInfo) {
    this._getSystemMemInfo = value;
  }

  private _getGraphicsMemory: number = 0;

  public set getGraphicsMemory(value: number) {
    this._getGraphicsMemory = value;
  }

  public get getGraphicsMemory(): number {
    return this._getGraphicsMemory;
  }

}
