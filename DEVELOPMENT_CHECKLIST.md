# Development Checklist / 开发清单

This checklist tracks the next practical steps for turning HydraPet Smart Coaster from a concept preview into a buildable prototype.

这份清单用于跟踪 HydraPet Smart Coaster 从概念预览走向可制作原型的后续工作。

## 1. Product Scope / 产品范围

- [ ] Define the primary use case: pet water bowl coaster, smart hydration reminder, or decorative display base.
- [ ] 明确核心使用场景：宠物饮水碗杯垫、智能饮水提醒器，或带显示效果的装饰底座。
- [ ] Decide the first prototype target: visual demo, 3D-printable enclosure, or electronics-ready enclosure.
- [ ] 确认第一版原型目标：视觉展示、可 3D 打印外壳，或可安装电子元件的外壳。
- [ ] List target dimensions for common pet bowls.
- [ ] 记录常见宠物碗适配尺寸。

## 2. Mechanical Design / 结构设计

- [ ] Review `hydrapet_smart_coaster.scad` for printable wall thickness, edge radius, and tolerances.
- [ ] 检查 `hydrapet_smart_coaster.scad` 的可打印壁厚、圆角和装配公差。
- [ ] Add parameter notes for diameter, height, sensor bay, cable slot, and display window.
- [ ] 补充直径、高度、传感器仓、走线槽、显示窗口等参数说明。
- [ ] Export a first STL test file and record slicer settings.
- [ ] 导出第一版 STL 测试文件，并记录切片参数。
- [ ] Test fit with a real bowl or a printed mock bowl footprint.
- [ ] 使用真实宠物碗或打印轮廓件进行适配测试。

## 3. Electronics / 电子硬件

- [ ] Choose the controller board, such as ESP32-C3, ESP32-S3, or another low-power MCU.
- [ ] 选择主控板，例如 ESP32-C3、ESP32-S3 或其他低功耗 MCU。
- [ ] Choose the display module for the droplet OLED concept.
- [ ] 确认水滴 OLED 概念对应的显示模块。
- [ ] Decide whether weight sensing, capacitive sensing, or water-level sensing is needed.
- [ ] 决定是否需要重量感应、电容感应或水位感应。
- [ ] Draft a simple wiring diagram.
- [ ] 绘制基础接线图。
- [ ] Check battery, charging, and waterproofing requirements.
- [ ] 检查电池、充电和防水需求。

## 4. Firmware And Interaction / 固件与交互

- [ ] Define basic states: idle, water detected, low water, reminder, and charging.
- [ ] 定义基础状态：待机、检测到饮水、低水量、提醒、充电。
- [ ] Map OLED droplet animations to those states.
- [ ] 将 OLED 水滴动画映射到不同状态。
- [ ] Decide whether Bluetooth, Wi-Fi, or offline-only mode is needed.
- [ ] 决定是否需要蓝牙、Wi-Fi，或仅离线运行。
- [ ] Build a first firmware skeleton once hardware is selected.
- [ ] 硬件选型完成后，搭建第一版固件框架。

## 5. Preview Pages / 预览页面

- [ ] Add usage notes to `hydrapet_smart_coaster_preview.html`.
- [ ] 为 `hydrapet_smart_coaster_preview.html` 增加使用说明。
- [ ] Keep OLED visual variants and the final chosen preview clearly separated.
- [ ] 区分 OLED 视觉方案变体和最终选定预览。
- [ ] Add screenshots or GIFs to the README after the design stabilizes.
- [ ] 设计稳定后，在 README 中加入截图或 GIF。

## 6. Testing / 测试

- [ ] Verify that all preview HTML files open correctly in a browser.
- [ ] 确认所有 HTML 预览文件都能在浏览器中正常打开。
- [ ] Print a small tolerance test piece before printing the full shell.
- [ ] 打印完整外壳前，先打印小尺寸公差测试件。
- [ ] Record issues from each print or electronics test.
- [ ] 记录每次打印或电子测试中发现的问题。
- [ ] Create a release checklist before sharing files publicly.
- [ ] 对外分享文件前，建立发布检查清单。

## 7. Documentation / 文档

- [ ] Add a short usage section to the README.
- [ ] 在 README 中补充简短使用方法。
- [ ] Add required tools: browser, OpenSCAD, slicer, and optional firmware tools.
- [ ] 补充所需工具：浏览器、OpenSCAD、切片软件，以及可选固件工具。
- [ ] Add license information.
- [ ] 补充许可证信息。
- [ ] Add build photos, renders, or screenshots when available.
- [ ] 有实物或渲染后，补充制作照片、渲染图或截图。

## 8. Release / 发布

- [ ] Tag the first usable design as `v0.1.0`.
- [ ] 将第一版可用设计标记为 `v0.1.0`。
- [ ] Attach exported STL or 3MF files to a GitHub Release.
- [ ] 在 GitHub Release 中附加导出的 STL 或 3MF 文件。
- [ ] Note known limitations and next improvements.
- [ ] 记录已知限制和后续改进方向。
