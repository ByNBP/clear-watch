import { workScheduler } from '@kit.BackgroundTasksKit';
import { notificationManager } from '@kit.NotificationKit';
import { CpuHelper } from '../util/CpuHelper';
import { HistoryViewModel } from '../viewmodel/HistoryViewModel';
import { BusinessError } from '@kit.BasicServicesKit';

export class BackgroundMonitorService {
  private static instance: BackgroundMonitorService;
  private readonly WORK_ID = 1001;

  private constructor() {}

  public static getInstance(): BackgroundMonitorService {
    if (!BackgroundMonitorService.instance) {
      BackgroundMonitorService.instance = new BackgroundMonitorService();
    }
    return BackgroundMonitorService.instance;
  }

  public registerAuditTask(): void {
    let workInfo: workScheduler.WorkInfo = {
      workId: this.WORK_ID,
      networkType: workScheduler.NetworkType.NETWORK_TYPE_ANY,
      bundleName: 'com.hmosdemos.wearable.clearwatch',
      abilityName: 'WorkSchedulerAbility',
      repeatCycleTime: 7200000, // 2 hours
    }

    try {
      workScheduler.startWork(workInfo);
      console.info('Background audit task registered successfully');
    } catch (err) {
      let e: BusinessError = err as BusinessError;
      console.error(`Failed to register background task. Code: ${e.code}, message: ${e.message}`);
    }
  }

  public async performAudit(): Promise<void> {
    const cpuHelper = new CpuHelper();
    const cpuUsage = cpuHelper.getSystemCpuUsage();
    const memInfo = cpuHelper.getSystemMemInfo();
    const historyVm = new HistoryViewModel();

    // Record snapshot
    await historyVm.addSnapshot(cpuUsage, memInfo.totalMem - memInfo.freeMem);

    // Check thresholds
    if (cpuUsage > 80) {
      this.sendNotification('High CPU Usage', `System CPU is at ${cpuUsage.toFixed(1)}%. Consider cleaning cache.`);
    }
  }

  private sendNotification(title: string, text: string): void {
    let notificationRequest: notificationManager.NotificationRequest = {
      id: 1,
      content: {
        notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal: {
          title: title,
          text: text,
          additionalText: 'ClearWatch Optimizer'
        }
      }
    };

    notificationManager.publish(notificationRequest).then(() => {
      console.info('Notification published');
    }).catch((err: BusinessError) => {
      console.error(`Failed to publish notification. Code: ${err.code}, message: ${err.message}`);
    });
  }
}
