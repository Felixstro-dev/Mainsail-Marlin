import { IMethodExecutor, TSender } from "./IMethodExecutor";
import MarlinRaker from "../../MarlinRaker";
import { TimelapseSettings } from "../../timelapse/TimelapseManager";

class MachineTimelapsePostSettingsExecutor implements IMethodExecutor<Partial<TimelapseSettings>, unknown> {
    public readonly name = "machine.timelapse.post_settings";
    public readonly httpMethod = "post" as const;
    public constructor(private readonly marlinRaker: MarlinRaker) {}
    public invoke(_: TSender, params: Partial<TimelapseSettings>): unknown {
        return this.marlinRaker.timelapse.updateSettings(params);
    }
}

export default MachineTimelapsePostSettingsExecutor;
