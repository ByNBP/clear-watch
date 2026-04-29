import { preferences } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';

export class PreferenceManager {
  private static instance: PreferenceManager;
  private pref: preferences.Preferences | null = null;
  private readonly PREF_NAME = 'ClearWatchPrefs';

  private constructor() {}

  public static getInstance(): PreferenceManager {
    if (!PreferenceManager.instance) {
      PreferenceManager.instance = new PreferenceManager();
    }
    return PreferenceManager.instance;
  }

  async init(context: Context): Promise<void> {
    try {
      this.pref = await preferences.getPreferences(context, this.PREF_NAME);
    } catch (err) {
      console.error(`Failed to get preferences. Code: ${(err as BusinessError).code}, message: ${(err as BusinessError).message}`);
    }
  }

  async putValue(key: string, value: preferences.ValueType): Promise<void> {
    if (!this.pref) return;
    await this.pref.put(key, value);
    await this.pref.flush();
  }

  async getValue(key: string, defaultValue: preferences.ValueType): Promise<preferences.ValueType> {
    if (!this.pref) return defaultValue;
    return await this.pref.get(key, defaultValue);
  }
}
