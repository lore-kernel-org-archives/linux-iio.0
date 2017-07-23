Return-Path: <SRS0=tGfR=62=aosc.io=icenowy@kernel.org>
From: Icenowy Zheng <icenowy@aosc.io>
To: Lee Jones <lee.jones@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-sunxi@googlegroups.com,
	Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v3 0/5] IIO-based thermal sensor driver for Allwinner H3 SoC
Date: Sun, 23 Jul 2017 22:13:49 +0800
Message-Id: <20170723141354.42646-1-icenowy@aosc.io>
List-ID: <linux-iio@vger.kernel.org>

Allwiner H3 SoC has a thermal sensor, which is a large refactored version of
the old Allwinner "GPADC" (although it have already only thermal part left
in A33).

This patch tried to add support for the sensor in H3 based on the A33 thermal
sensor driver by Quentin Schulz, which is already merged.

Icenowy Zheng (5):
  dt-bindings: update the Allwinner GPADC device tree binding for H3
  iio: adc: sun4i-gpadc-iio: rename A23/A33-specified registers to
    contain A23
  iio: adc: sun4i-gpadc-iio: add support for H3 thermal sensor
  ARM: sun8i: h3: add support for the thermal sensor in H3
  ARM: sun8i: h3: add partial CPU thermal zone

 .../devicetree/bindings/mfd/sun4i-gpadc.txt        |  25 ++-
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  26 +++
 drivers/iio/adc/sun4i-gpadc-iio.c                  | 228 +++++++++++++++++----
 include/linux/mfd/sun4i-gpadc.h                    |  33 ++-
 4 files changed, 267 insertions(+), 45 deletions(-)

-- 
2.13.0
