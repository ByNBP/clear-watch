import { sensor } from '@kit.SensorServiceKit';
import { BusinessError } from '@kit.BasicServicesKit';

export class GestureHelper {
  private static instance: GestureHelper;
  private isListening: boolean = false;
  private readonly SHAKE_THRESHOLD = 15; // acceleration threshold in m/s^2

  private constructor() {}

  public static getInstance(): GestureHelper {
    if (!GestureHelper.instance) {
      GestureHelper.instance = new GestureHelper();
    }
    return GestureHelper.instance;
  }

  public startShakeDetection(onShake: () => void): void {
    if (this.isListening) return;

    try {
      sensor.on(sensor.SensorId.ACCELEROMETER, (data) => {
        const acceleration = Math.sqrt(data.x * data.x + data.y * data.y + data.z * data.z);
        if (acceleration > this.SHAKE_THRESHOLD) {
          console.info('Shake detected!');
          onShake();
        }
      }, { interval: 100000000 }); // 100ms
      this.isListening = true;
    } catch (err) {
      let e: BusinessError = err as BusinessError;
      console.error(`Failed to register accelerometer sensor. Code: ${e.code}, message: ${e.message}`);
    }
  }

  public stopShakeDetection(): void {
    if (!this.isListening) return;

    try {
      sensor.off(sensor.SensorId.ACCELEROMETER);
      this.isListening = false;
    } catch (err) {
      let e: BusinessError = err as BusinessError;
      console.error(`Failed to unregister accelerometer sensor. Code: ${e.code}, message: ${e.message}`);
    }
  }
}
