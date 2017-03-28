Return-Path: <SRS0=AFNH=3F=aosc.io=icenowy@kernel.org>
From: Icenowy Zheng <icenowy@aosc.io>
To: Lee Jones <lee.jones@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Icenowy Zheng <icenowy@aosc.io>
Subject: [RFC PATCH 0/3] IIO-based thermal sensor driver for Allwinner H3 SoC
Date: Wed, 29 Mar 2017 01:30:10 +0800
Message-Id: <20170328173013.16539-1-icenowy@aosc.io>
List-ID: <linux-iio@vger.kernel.org>

Allwiner H3 SoC has a thermal sensor, which is a large refactored version of
the old Allwinner "GPADC" (although it have already only thermal part left
in A33).

This patch tried to add support for the sensor in H3 based on the A33
thermal sensor patchset by Quentin Schulz at [1].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/495505.html

Icenowy Zheng (3):
  dt-bindings: update the Allwinner GPADC device tree binding for H3
  iio: adc: sun4i-gpadc-iio: add support for H3 thermal sensor
  ARM: sun8i: h3: add support for the thermal sensor in H3

 .../devicetree/bindings/mfd/sun4i-gpadc.txt        |  23 +++-
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  26 +++++
 drivers/iio/adc/sun4i-gpadc-iio.c                  | 130 ++++++++++++++++++---
 include/linux/mfd/sun4i-gpadc.h                    |  33 +++++-
 4 files changed, 188 insertions(+), 24 deletions(-)

-- 
2.12.0
