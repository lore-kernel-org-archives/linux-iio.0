Return-Path: <SRS0=s4UA=EE=free-electrons.com=quentin.schulz@kernel.org>
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	wens@csie.org,
	sre@kernel.org,
	linux@armlinux.org.uk,
	maxime.ripard@free-electrons.com,
	lee.jones@linaro.org
Cc: linux-iio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	linux-sunxi@googlegroups.com,
	Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v2 00/16] add support for AXP813 ADC and battery power supply
Date: Tue,  9 Jan 2018 10:33:31 +0100
Message-Id: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>

The AXP813 PMIC is relatively close to the already supported AXP20X and
AXP22X. It provides three different power outputs: battery, AC and USB, and
measures a few different things: temperature, power supply status, current
current and voltage supplied, maximum current limit, battery capacity, min
and max voltage limits.

One of its two GPIOs can be used as an ADC.

There are a few differences with AXP20X/AXP22X PMICs though:
  - a different constant charge current formula,
  - battery temperature, GPIO0 and battery voltages are the only voltages
  measurable,
  - all data are stored on 12 bits (AXP20X/AXP22X had one type of data that
  was stored on 13 bits),
  - different scales and offsets,
  - a different ADC rate formula and register,

This patch series adds support for the PMIC's ADC and battery power supply
in the existing drivers.

Make the axp20x MFD automatically probe the ADC driver, add the battery
power supply node in axp81x node and enable it for the TBS A711 since it
has a soldered battery.

v2:
  - introduce data structure instead of ID for variant specific code in
  battery driver,
  - add DT binding for ADC driver,
  - make mfd probe the ADC driver via DT as well so that its IIO channels
  can be consumed by other drivers via DT mapping,

Thanks,
Quentin

Quentin Schulz (16):
  iio: adc: axp20x_adc: put ADC rate setting in a per-variant function
  dt-bindings: iio: adc: add binding for X-Powers AXP PMICs ADC
  iio: adc: axp20x_adc: make it possible to probe from DT
  ARM: dtsi: axp209: add node for ADC
  ARM: dtsi: axp22x: add node for ADC
  mfd: axp20x: make AXP209/22x cells probe their ADC via DT
  dt-bindings: iio: adc: axp20x_adc: add AXP813 variant
  iio: adc: axp20x_adc: add support for AXP813 ADC
  ARM: dtsi: axp81x: add node for ADC
  mfd: axp20x: probe axp20x_adc driver for AXP813
  power: supply: axp20x_battery: use data structure instead of ID for variant specific code
  dt-bindings: power: supply: axp20x: add AXP813 battery DT binding
  power: supply: axp20x_battery: add support for AXP813
  mfd: axp20x: add battery power supply cell for AXP813
  ARM: dtsi: axp81x: add battery power supply subnode
  ARM: dtsi: sun8i: a711: enable battery power supply subnode

 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt          |  48 ++++++++++++++++++++++-
 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt |   8 ++--
 arch/arm/boot/dts/axp209.dtsi                                     |   5 ++-
 arch/arm/boot/dts/axp22x.dtsi                                     |   5 ++-
 arch/arm/boot/dts/axp81x.dtsi                                     |  10 +++++-
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts                         |   4 ++-
 drivers/iio/adc/axp20x_adc.c                                      | 160 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 drivers/mfd/axp20x.c                                              |  13 +++++-
 drivers/power/supply/axp20x_battery.c                             | 134 ++++++++++++++++++++++++++++++++++++++++++++++--------------
 include/linux/mfd/axp20x.h                                        |   2 +-
 10 files changed, 345 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt

base-commit: 895c0dde398510a5b5ded60e5064c11b94bd30ca
-- 
git-series 0.9.1
