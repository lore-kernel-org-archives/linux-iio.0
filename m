Return-Path: <SRS0=zW5g=EX=gmail.com=embed3d@kernel.org>
From: Philipp Rossak <embed3d@gmail.com>
To: lee.jones@linaro.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	maxime.ripard@free-electrons.com,
	wens@csie.org,
	linux@armlinux.org.uk,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	davem@davemloft.net,
	hans.verkuil@cisco.com,
	mchehab@kernel.org,
	rask@formelder.dk,
	clabbe.montjoie@gmail.com,
	sean@mess.org,
	krzk@kernel.org,
	quentin.schulz@free-electrons.com,
	icenowy@aosc.io,
	edu.molinas@gmail.com,
	singhalsimran0@gmail.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@googlegroups.com
Subject: [PATCH v2 00/16] IIO-based thermal sensor driver for Allwinner H3 and A83T SoC
Date: Mon, 29 Jan 2018 00:29:03 +0100
Message-Id: <20180128232919.12639-1-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Allwiner H3 and A83T SoCs have a thermal sensor, which is a large refactored
version of the old Allwinner "GPADC" (although it have already only
thermal part left in A33).

This patch tried to add support for the sensor in H3 and A83T based on
the A33 thermal sensor driver by Quentin Schulz, which is already merged.

This Patchseries is based on Icenowy Zhengs v4 patchseries [1]. 
The first 5 patches are reworked patches from the v4 patchseries. 
The rest of the patches add step by step a feature to support multible
sensors, nvmem calibration and interupts. This patchseries should make it
easy also to add other sunxi SoCs, like the H5, A64 and A80.

Patches that adds support for H5, A64 and A80 SoCs are allready prepared,
and will be upstreamed if this patchseries is applied and the testing is done.

I tried to pick up all the feedback from [1]. I hope I didn't miss anything.

Regards,
Philipp 

@Jonathan
	Could you please check Patch 8 again. I moved some code from 
	Patch 8 to 9. Please chek it again, if your still ok with it.
	But I think it sould be ok.

changes since v1:
	* collecting all acks 
	* rewording commits/fix typos
	* move code in place where it is used
	* fix naming conventions of defines
	* clarify commits
	* update documentation to cover the new nvmem calibraion
	* change nvmem calibration

Icenowy Zheng (1):
  iio: adc: sun4i-gpadc-iio: rename A33-specified registers to contain
    A33

Philipp Rossak (15):
  dt-bindings: update the Allwinner GPADC device tree binding for H3 &
    A83T
  arm: config: sunxi_defconfig: enable SUN4I_GPADC
  iio: adc: sun4i-gpadc-iio: rework: sampling start/end code readout reg
  iio: adc: sun4i-gpadc-iio: rework: support clocks and reset
  iio: adc: sun4i-gpadc-iio: rework: support multiple sensors
  iio: adc: sun4i-gpadc-iio: rework: support nvmem calibration data
  iio: adc: sun4i-gpadc-iio: rework: add interrupt support
  iio: adc: sun4i-gpadc-iio: add support for H3 thermal sensor
  iio: adc: sun4i-gpadc-iio: add support for A83T thermal sensor
  arm: dts: sunxi-h3-h5: add support for the thermal sensor in H3 and H5
  arm: dts: sun8i: h3: add support for the thermal sensor in H3
  arm: dts: sun8i: h3: add thermal zone to H3
  arm: dts: sun8i: h3: enable H3 sid controller
  arm: dts: sun8i: a83t: add support for the thermal sensor in A83T
  arm: dts: sun8i: a83t: add thermal zone to A83T

 .../devicetree/bindings/mfd/sun4i-gpadc.txt        |  50 ++-
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |  28 ++
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  21 ++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |   9 +
 arch/arm/configs/sunxi_defconfig                   |   1 +
 drivers/iio/adc/sun4i-gpadc-iio.c                  | 367 ++++++++++++++++++++-
 include/linux/mfd/sun4i-gpadc.h                    |  51 ++-
 7 files changed, 503 insertions(+), 24 deletions(-)

-- 
2.11.0
