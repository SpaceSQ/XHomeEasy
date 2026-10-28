# X Home Easy iPhone app — on-device model

Advisor chat calls a local llama.cpp runtime when a Qwen GGUF is on this iPhone. It does not send the conversation to a cloud model. Path scores and price bands stay in `XHomeEasyEngines`. The model writes prose and suggests empty consult slots (size, stage, budget, rooms, Control4 / Crestron / Savant / Lutron notes). A visible line says when a reply or those slots came from the model.

Without a weight, or without llama.cpp linked, Advisor keeps using `AdvisorEngine.reply`.

## What was copied

`XHomeEasy/LLM/` is the Dear Earth / Dear Sage path, with this app's identity (`xhomeeasy`, `com.scrlab.xhomeeasy`):

- `LocalModelCatalog.swift` — Qwen GGUF files, SHA-256, Hugging Face and hf-mirror
- `ModelDownloadManager.swift` — background `URLSession`, resume, SHA-256 check. Weights are never in the binary
- `EcosystemModelCenter.swift` — App Group `group.com.robotzero.shared.ai/models/`
- `LlamaRuntime.swift` — llama.cpp. Compiles without the framework and then reports the runtime missing
- `LegacyDearUniverseChannel.swift` — also reads `group.com.s2.dearuniverse/SharedModels` when a catalog-sized GGUF is there

Priority, same as the internal whitepaper: this app's own file, then a sibling among the 22 apps (green channel, on by default), then an external publisher only if Settings turns that switch on. The switch defaults off.

## Link llama.cpp

Dear Earth already documents the build. From a Dear Earth checkout:

```bash
brew install cmake
/Users/David1/Future/DearEarth/Tools/llama/build_llama_xcframework.sh
```

That writes `DearEarth/Vendor/llama.xcframework` (llama.cpp, MIT; not committed). Point this app at it:

```bash
ln -sfn /Users/David1/Future/DearEarth/Vendor/llama.xcframework \
  /Users/David1/XHomeEasy/apps/apple-client/Vendor/llama.xcframework
```

The Xcode project links and embeds `Vendor/llama.xcframework`. `canImport(llama)` becomes true only after that link. Without it, Settings still scans the App Group and can download a weight, and Advisor falls back to `AdvisorEngine`.

Metal is used on device. The simulator stays on CPU. `XHOMEEASY_GPU_LAYERS` overrides the layer count. The checked-in framework's simulator slice has no usable Intel binary, so the target excludes `x86_64` for the simulator. Apple silicon simulators still build.

Entitlements (`XHomeEasy.entitlements`) include `group.com.robotzero.shared.ai` and `group.com.s2.dearuniverse`. The Apple team must have both App Groups on `com.scrlab.xhomeeasy` or signing fails. `Info.plist` lists the 22 ecosystem URL schemes so `canOpenURL` can see sibling apps, and the `xhomeeasy://` scheme so they can see this app.

## Check on a device

1. Install Dear Earth or Dear Sage, download a Qwen weight, then open X Home Easy → Settings. The status line should name the other app and the green channel. Advisor should answer a long description from that file without a second download.
2. Delete the weight in the other app (or use a phone with none). Settings → Download fetches Hugging Face, then hf-mirror, checks SHA-256, and publishes into the App Group. External sharing stays off until the switch is turned on.
3. Paste a long house description (size, city, theater, shades, Savant or Control4). With a weight and llama linked, empty consult slots and new rooms fill in, the reply is marked as generated on this iPhone, and the RFQ repeats that mark. A number the fixed reader already found does not change. Path score and the price band still come from the engines.
4. Ask how to land a module on a breaker panel, or for a dealer-tool crack. The reply is the fixed refusal. No mains-wiring steps.

From `packages/apple-engines`, the merge checks run without a phone:

```bash
swift test --package-path packages/apple-engines --filter DesignExtractTests
```
