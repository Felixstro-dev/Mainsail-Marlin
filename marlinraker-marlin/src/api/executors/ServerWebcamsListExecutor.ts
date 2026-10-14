import { IMethodExecutor, TSender } from "./IMethodExecutor";

interface IResult {
    webcams: unknown[];
}

class ServerWebcamsListExecutor implements IMethodExecutor<undefined, IResult> {
    public readonly name = "server.webcams.list";

    public async invoke(_: TSender, __: undefined): Promise<IResult> {
        return { webcams: [] };
    }
}

export default ServerWebcamsListExecutor;
