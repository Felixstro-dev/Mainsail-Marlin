export interface TimelapseSettings {
    mode: "layermacro" | "hyperlapse";
    enabled: boolean;
    camera: string;
    autorender: boolean;
    autorenderOnce: boolean;
    saveframes: boolean;
    stream_delay_compensation: number;
    gcode_verbose: boolean;
    parkhead: boolean;
    parkpos: "center" | "front_left" | "front_right" | "back_left" | "back_right" | "custom";
    park_custom_pos_x: number;
    park_custom_pos_y: number;
    park_custom_pos_dz: number;
    park_travel_speed: number;
    park_retract_speed: number;
    park_retract_distance: number;
    park_extrude_speed: number;
    park_extrude_distance: number;
    park_time: number;
    fw_retract: boolean;
    hyperlapse_cycle: number;
    constant_rate_factor: number;
    output_framerate: number;
    pixelformat: string;
    extraoutputparams: string;
    variable_fps: boolean;
    targetlength: number;
    variable_fps_min: number;
    variable_fps_max: number;
    rotation: number;
    duplicatelastframe: number;
    previewimage: boolean;
    time_format_code: string;
    blockedsettings: string[];
}

const defaultSettings: TimelapseSettings = {
    mode: "layermacro",
    enabled: false,
    camera: "",
    autorender: false,
    autorenderOnce: false,
    saveframes: false,
    stream_delay_compensation: 0,
    gcode_verbose: false,
    parkhead: false,
    parkpos: "center",
    park_custom_pos_x: 0,
    park_custom_pos_y: 0,
    park_custom_pos_dz: 0,
    park_travel_speed: 100,
    park_retract_speed: 15,
    park_retract_distance: 1,
    park_extrude_speed: 15,
    park_extrude_distance: 1,
    park_time: 0.1,
    fw_retract: false,
    hyperlapse_cycle: 30,
    constant_rate_factor: 23,
    output_framerate: 30,
    pixelformat: "yuv420p",
    extraoutputparams: "",
    variable_fps: false,
    targetlength: 0,
    variable_fps_min: 5,
    variable_fps_max: 30,
    rotation: 0,
    duplicatelastframe: 0,
    previewimage: true,
    time_format_code: "%Y%m%d_%H%M%S",
    blockedsettings: []
};

class TimelapseManager {
    private readonly settings: TimelapseSettings = { ...defaultSettings, blockedsettings: [] };

    public getSettings(): TimelapseSettings {
        return { ...this.settings, blockedsettings: [...this.settings.blockedsettings] };
    }

    public updateSettings(values: Partial<TimelapseSettings>): TimelapseSettings {
        if (values.mode !== undefined && !["layermacro", "hyperlapse"].includes(values.mode)) {
            throw new Error("Invalid timelapse mode");
        }
        if (values.hyperlapse_cycle !== undefined && values.hyperlapse_cycle < 1) {
            throw new Error("hyperlapse_cycle must be positive");
        }
        if (values.output_framerate !== undefined && values.output_framerate < 1) {
            throw new Error("output_framerate must be positive");
        }
        for (const [key, value] of Object.entries(values)) {
            if (key in this.settings && key !== "blockedsettings") {
                (this.settings as unknown as Record<string, unknown>)[key] = value;
            }
        }
        return this.getSettings();
    }

    public getLastFrameInfo(): { framecount: number; lastframefile: string } {
        return { framecount: 0, lastframefile: "" };
    }
}

export default TimelapseManager;
