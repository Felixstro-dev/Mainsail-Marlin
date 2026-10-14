import { Duplex } from "stream";
import { SerialPort } from "serialport";

interface ISerialTransport extends Duplex {
    readonly path: string;
    readonly writable: boolean;
    readonly isOpen: boolean;
    open(callback: (error?: Error | null) => void): void;
    close(callback?: (error?: Error | null) => void): void;
    flush(callback: (error?: Error | null) => void): void;
}

class FakeMarlinTransport extends Duplex implements ISerialTransport {

    public readonly path = "fake://marlin";
    public isOpen = false;
    private temperature = 24;
    private readonly responseDelay: number;
    private readonly fragmentResponses: boolean;

    public constructor() {
        super();
        this.responseDelay = Number.parseInt(process.env.MARLINRAKER_FAKE_DELAY ?? "2", 10);
        this.fragmentResponses = process.env.MARLINRAKER_FAKE_FRAGMENT !== "0";
    }

    public open(callback: (error?: Error | null) => void): void {
        if (process.env.MARLINRAKER_FAKE_OPEN_ERROR === "1") {
            callback(new Error("fake transport open failure"));
            return;
        }
        this.isOpen = true;
        const disconnectAfter = Number.parseInt(process.env.MARLINRAKER_FAKE_DISCONNECT_AFTER ?? "0", 10);
        if (disconnectAfter > 0) {
            setTimeout(() => {
                if (this.isOpen) this.close();
            }, disconnectAfter);
        }
        queueMicrotask(() => callback(null));
    }

    public close(callback?: (error?: Error | null) => void): void {
        this.isOpen = false;
        this.push(null);
        this.emit("close");
        callback?.(null);
    }

    public flush(callback: (error?: Error | null) => void): void {
        queueMicrotask(() => callback(null));
    }

    public _read(): void {
        // Responses are pushed by _write.
    }

    public _write(chunk: Buffer, _encoding: BufferEncoding, callback: (error?: Error | null) => void): void {
        const command = chunk.toString("utf8").trim();
        const response = this.responseFor(command);
        const delay = Number.isNaN(this.responseDelay) ? 2 : Math.max(0, this.responseDelay);

        if (process.env.MARLINRAKER_FAKE_TIMEOUT === "1") {
            callback(null);
            return;
        }

        setTimeout(() => {
            if (!this.isOpen) return;
            const payload = `${response.join("\r\n")}\r\n`;
            if (this.fragmentResponses && payload.length > 4) {
                const midpoint = Math.ceil(payload.length / 2);
                this.push(payload.slice(0, midpoint));
                setTimeout(() => this.push(payload.slice(midpoint)), delay);
            } else {
                this.push(payload);
            }
        }, delay);
        callback(null);
    }

    private responseFor(command: string): string[] {
        if (/^M115(?:\s|$)/i.test(command)) {
            return [
                "FIRMWARE_NAME:Marlin 2.1.2 (Fake) MACHINE_TYPE:Cartesian",
                "Cap:AUTOREPORT_TEMP:0",
                "Cap:EMERGENCY_PARSER:1",
                "ok"
            ];
        }
        if (/^M105(?:\s|$)/i.test(command)) {
            this.temperature = Math.min(210, this.temperature + 0.25);
            return [`T:${this.temperature.toFixed(2)} /210.00 B:24.00 /0.00 @:32 B@:0`, "ok"];
        }
        if (/^M114(?:\s|$)/i.test(command)) {
            return ["X:10.00 Y:20.00 Z:0.20 E:0.00 Count X:1000 Y:2000 Z:20", "ok"];
        }
        if (/^M20(?:\s|$)/i.test(command)) {
            return ["Begin file list", "demo.gco 1024 demo.gco", "End file list", "ok"];
        }
        if (/^M119(?:\s|$)/i.test(command)) {
            return ["Reporting endstop status", "x_min: open", "y_min: open", "z_min: TRIGGERED", "ok"];
        }
        if (/^M112(?:\s|$)/i.test(command)) {
            return ["Error: Emergency Stop", "ok"];
        }
        if (/^(?:G|M|T)\S+/i.test(command)) {
            return ["ok"];
        }
        return [`echo:Unknown command: "${command}"`, "ok"];
    }
}

export { FakeMarlinTransport, ISerialTransport };
export default SerialPort;
