import { IMethodExecutor, TSender } from "./IMethodExecutor";
import MarlinRaker from "../../MarlinRaker";

class MachineTimelapseLastFrameInfoExecutor implements IMethodExecutor<undefined, unknown> {
    public readonly name = "machine.timelapse.lastframeinfo";
    public constructor(private readonly marlinRaker: MarlinRaker) {}
    public invoke(_: TSender, __: undefined): unknown {
        return this.marlinRaker.timelapse.getLastFrameInfo();
    }
}

export default MachineTimelapseLastFrameInfoExecutor;
