# HydraPet Smart Coaster / HydraPet 智能杯垫

HydraPet Smart Coaster is a 3D-printable smart pet water coaster concept. It combines a floating cup insert, a load-cell weight path, an OLED display, a side LED light band, and internal trays for the selected electronics.

HydraPet 智能杯垫是一个可 3D 打印的宠物饮水智能杯垫概念模型。它包含浮动承重杯垫、称重传感器受力路径、OLED 显示窗口、侧面 LED 灯带，以及为已选电子模块预留的内部安装结构。

## Current Model / 当前模型

- Overall size: 100 mm diameter, 35 mm height.
- 外形尺寸：直径 100 mm，高度 35 mm。
- Two-piece shell: upper shell and lower shell with screw bosses and seam lip.
- 双壳体结构：上壳和下壳，带螺丝柱与装配止口。
- Floating cup insert transfers bowl weight to a 75 mm straight-bar load cell.
- 浮动杯垫把水碗重量传到 75 mm 条形称重传感器。
- Side light band uses an open window, top/bottom slots for an insertable diffuser strip, and an inner annular groove for a 2.7 mm LED strip.
- 侧面灯带采用开口窗口结构，开口后方有上下卡槽可插入柔光片，内侧再预留适配 2.7 mm 灯带的环形凹槽。
- Front OLED opening exposes only the active screen area; the 27 x 27 mm PCB is hidden behind the front bezel.
- 正面 OLED 只露出屏幕显示区域，27 x 27 mm 电路板隐藏在面板后方。

## Electronics Dimensions / 电子模块尺寸

Dimensions are based on the reference images in `size_of_elec/`.

以下尺寸来自 `size_of_elec/` 文件夹中的参考图片。

| Part | Size |
| --- | --- |
| ESP32-S3 board / ESP32-S3 开发板 | 51.66 x 20.32 mm |
| HX711 module / HX711 称重模块 | 30 x 18 mm |
| OLED PCB / OLED 电路板 | 27 x 27 x 2 mm |
| OLED visible window / OLED 可视窗口 | about 22 x 11.5 mm |
| Buzzer module / 蜂鸣器模块 | 34 x 22 x 12 mm |
| Button module / 按键模块 | 34 x 22 x 16 mm |
| LED strip / LED 灯带 | 5 V, 2.7 mm wide, 60 LEDs/m |

## Files / 文件说明

- `hydrapet_smart_coaster.scad` - OpenSCAD source model.
- `hydrapet_smart_coaster.scad` - OpenSCAD 模型源文件。
- `hydrapet_smart_coaster_preview.html` - interactive browser preview.
- `hydrapet_smart_coaster_preview.html` - 浏览器交互预览页面。
- `droplet-oled-preview.html` - OLED droplet animation preview.
- `droplet-oled-preview.html` - OLED 水滴动画预览页面。
- `droplet-oled-variants.html` - OLED visual variant preview.
- `droplet-oled-variants.html` - OLED 视觉方案变体页面。
- `size_of_elec/` - electronics dimension reference images.
- `size_of_elec/` - 电子元件尺寸参考图片。

## OpenSCAD Usage / OpenSCAD 使用方法

Open `hydrapet_smart_coaster.scad` in OpenSCAD and change `view_mode` near the top of the file:

在 OpenSCAD 中打开 `hydrapet_smart_coaster.scad`，然后修改文件顶部的 `view_mode`：

```scad
view_mode = "section";
```

Available modes / 可选模式：

- `assembled` - full assembled model / 完整装配模型
- `exploded` - exploded assembly view / 爆炸视图
- `top_shell` - upper shell only / 仅上壳
- `bottom_shell` - lower shell only / 仅下壳
- `cup_insert` - floating insert only / 仅浮动杯垫
- `section` - cutaway section view / 剖面视图

To preview electronics envelopes, set:

如需查看电子元件参考占位，设置：

```scad
show_reference_parts = true;
```

## Print And Assembly Notes / 打印与装配说明

- Print a small tolerance test before printing the full enclosure.
- 打印完整外壳前，建议先打印小尺寸公差测试件。
- The cup insert must remain loose and should not touch the outer shell, otherwise weight readings may be inaccurate.
- 浮动杯垫必须保持可活动，不应碰到外壳，否则称重读数可能不准确。
- Install the OLED from inside the shell. From outside, only the display window should be visible.
- OLED 从壳体内部安装；外侧只能看到显示窗口，不能看到电路板。
- Insert a thin milky PET, frosted acrylic, or silicone diffuser strip into the side window slots, then place the LED strip into the inner annular groove behind it.
- 将薄的乳白 PET、磨砂亚克力或硅胶柔光片插入侧面窗口卡槽，再把 LED 灯带贴入其后方的内壁环形凹槽。

## Status / 状态

This is still a prototype model. Before final printing, check real component tolerances, connector height, wire bend radius, waterproofing, and bowl fit.

当前仍是原型模型。最终打印前，请确认真实元件公差、接口高度、线材弯折空间、防水方式，以及水碗适配情况。
