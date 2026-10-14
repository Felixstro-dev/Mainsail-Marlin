import assert from "node:assert/strict";
import test from "node:test";
import TimelapseManager from "../src/timelapse/TimelapseManager";

test("returns safe default timelapse settings", () => {
    const manager = new TimelapseManager();
    const settings = manager.getSettings();

    assert.equal(settings.enabled, false);
    assert.equal(settings.mode, "layermacro");
    assert.deepEqual(manager.getLastFrameInfo(), {
        framecount: 0,
        lastframefile: "",
    });
});

test("updates and validates timelapse settings", () => {
    const manager = new TimelapseManager();

    assert.equal(manager.updateSettings({ enabled: true, hyperlapse_cycle: 45 }).enabled, true);
    assert.equal(manager.getSettings().hyperlapse_cycle, 45);
    assert.throws(() => manager.updateSettings({ mode: "invalid" as never }), /Invalid timelapse mode/);
    assert.throws(() => manager.updateSettings({ hyperlapse_cycle: 0 }), /must be positive/);
});
