import assert from "node:assert/strict";
import test from "node:test";
import ParserUtil from "../src/printer/ParserUtil";

test("parses Marlin firmware identification", () => {
    const [info, capabilities] = ParserUtil.parseM115Response(
        "FIRMWARE_NAME:Marlin 2.1.0 (Github) MACHINE_TYPE:Cartesian\nCap:EMERGENCY_PARSER:1"
    );
    assert.equal(info.firmwareName, "Marlin 2.1.0 (Github)");
    assert.equal(info.machineType, "Cartesian");
    assert.equal(capabilities.EMERGENCY_PARSER, true);
});

test("parses heater temperatures and targets", () => {
    const heaters = ParserUtil.parseM105Response("ok T:229.00 /230.00 B:84.96 /85.00 @:55 B@:58");
    assert.deepEqual(heaters, {
        T: { temp: 229, target: 230, power: 0.43 },
        B: { temp: 84.96, target: 85, power: 0.46 },
    });
});

test("parses positions and ignores invalid temperature lines", () => {
    assert.deepEqual(ParserUtil.parseM114Response("X:180.40 Y:-3.00 Z:0.00 E:0.00 Count X:18040"), [
        180.4,
        -3,
        0,
        0,
    ]);
    assert.equal(ParserUtil.parseM105Response("echo:busy: processing"), null);
});

test("trims comments without changing command semantics", () => {
    assert.equal(ParserUtil.trimGcodeLine(" G1 X10 ; move to test"), "G1 X10");
    assert.equal(ParserUtil.trimGcodeLine(" ; comment only"), "");
});
