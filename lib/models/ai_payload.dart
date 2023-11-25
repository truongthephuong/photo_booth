
import 'dart:convert';
import 'dart:core';

class AnimePayload {
  final String prompt;
  final String negativePrompt;
  final String samplerName;
  final int batchSize;
  final int steps;
  final int cfgScale;
  final int width;
  final int height;
  final bool overrideSettingsRestoreAfterwards;
  final String samplerIndex;
  final List<String> scriptArgs;
  final bool sendImages;
  final bool saveImages;
  final AlwaysonScripts alwaysonScripts;

  String toJson() {
    return jsonEncode(toMap());
  }

  AnimePayload ({
    required this.prompt,
    required this.negativePrompt,
    required this.samplerName,
    required this.batchSize,
    required this.steps,
    required this.cfgScale,
    required this.width,
    required this.height,
    required this.overrideSettingsRestoreAfterwards,
    required this.samplerIndex,
    required this.scriptArgs,
    required this.sendImages,
    required this.saveImages,
    required this.alwaysonScripts,
  });

  Map<String, dynamic> toMap() {
    return {
      'prompt': prompt,
      'negative_prompt': negativePrompt,
      'sampler_name': samplerName,
      'batch_size': batchSize,
      'steps': steps,
      'cfg_scale': cfgScale,
      'width': width,
      'height': height,
      'override_settings_restore_afterwards': overrideSettingsRestoreAfterwards,
      'sampler_index': samplerIndex,
      'script_args': scriptArgs,
      'send_images': sendImages,
      'save_images': saveImages,
      'alwayson_scripts': alwaysonScripts.toMap(),
    };
  }

}

class ControlNetArgs {
  final String controlMode;
  final bool enabled;
  final int guidanceEnd;
  final int guidanceStart;
  final String inputImage;
  final String inputMode;
  final bool isUi;
  final bool loopback;
  final bool lowVram;
  final String model;
  final String module;
  final String outputDir;
  final bool pixelPerfect;
  final int processorRes;
  final String resizeMode;
  final double thresholdA;
  final double thresholdB;
  final double weight;

  ControlNetArgs({
    required this.controlMode,
    required this.enabled,
    required this.guidanceEnd,
    required this.guidanceStart,
    required this.inputImage,
    required this.inputMode,
    required this.isUi,
    required this.loopback,
    required this.lowVram,
    required this.model,
    required this.module,
    required this.outputDir,
    required this.pixelPerfect,
    required this.processorRes,
    required this.resizeMode,
    required this.thresholdA,
    required this.thresholdB,
    required this.weight,
  });

  Map<String, dynamic> toMap() {
    return {
      'control_mode': controlMode,
      'enabled': enabled,
      'guidance_end': guidanceEnd,
      'guidance_start': guidanceStart,
      'input_image': inputImage,
      'input_mode': inputMode,
      'is_ui': isUi,
      'loopback': loopback,
      'low_vram': lowVram,
      'model': model,
      'module': module,
      'output_dir': outputDir,
      'pixel_perfect': pixelPerfect,
      'processor_res': processorRes,
      'resize_mode': resizeMode,
      'threshold_a': thresholdA,
      'threshold_b': thresholdB,
      'weight': weight,
    };
  }
}

class AlwaysonScripts {
  final ControlNetArgs controlNet;

  AlwaysonScripts({
    required this.controlNet,
  });

  Map<String, dynamic> toMap() {
    return {
      'ControlNet': {
        'args': [controlNet.toMap()],
      },
    };
  }
}