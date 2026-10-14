import { IMethodExecutor, TSender } from "./IMethodExecutor";
import MarlinRaker from "../../MarlinRaker";

class MachineTimelapseGetSettingsExecutor implements IMethodExecutor<undefined, unknown> {
    public readonly name = "machine.timelapse.get_settings";
    public constructor(private readonly marlinRaker: MarlinRaker) {}
    public invoke(_: TSender, __: undefined): unknown {
        return this.marlinRaker.timelapse.getSettings();
    }
}

export default MachineTimelapseGetSettingsExecutor;
