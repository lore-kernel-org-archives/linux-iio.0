Return-Path: <ch.naveen@samsung.com>
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cw00.choi@samsung.com,
 gregkh@linuxfoundation.org, naveenkrishna.ch@gmail.com, lars@metafoo.de,
 cpgs@samsung.com, grundler@chromium.org, jic23@kernel.org
Subject: [PATCH 0/4 v2] iio: exynos-adc: use syscon instead of ioremap
Date: Thu, 17 Jul 2014 16:49:49 +0530
Message-id: <1405595993-16661-1-git-send-email-ch.naveen@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

Syscon is a regmap based framework to help various drivers access misc
bits in registers which does not belong to another module.
For example, Power Module, SYSREGs.

With syscon, ADC can use generic regmap API to access
registers of PMU which are registered into syscon.
 
This patch does the following
1. Use the syscon and Regmap API instead of ioremappaing the
   ADC_PHY register from PMU.
2. Moves the exynos-adc.txt from bindings/arm/samsung/
   to bindings/iio/adc/.
3. Updates the Documentation in exynos-adc.txt with syscon phandle
   for the ADC nodes.
4. Updates the Dts files for Exynos3250, Exynos4x12, Exynos5250,
   Exynos5420 with the syscon phandle.

Tested on Exynos5420 based Peach PIT and Exynos5800 based Peach PI
by verifying sysfs entries provided by HWMON based NTC thermistors.

Tested-By for Exynos3250, Exynos4x12 would be appreciated.

Changes since v1:
Adding syscon description in commit message

Rebased on top of v5 version of ADC for exynos3250 from Changwoo.
iio: adc: exynos_adc: Support Exynos3250 ADC and code clean
https://lkml.org/lkml/2014/6/27/16

Naveen Krishna Chatradhi (4):
  iio: exyno-adc: use syscon for PMU register access
  Documentation: dt-bindings: move exynos-adc.txt to more iio/adc/
  Documentation: dt-bindings: update exynos-adc.txt with syscon handle
  ARM: dts: exynos: Add sysreg phandle to ADC node

 .../devicetree/bindings/arm/samsung/exynos-adc.txt |   82 ------------------
 .../devicetree/bindings/iio/adc/exynos-adc.txt     |   87 ++++++++++++++++++++
 arch/arm/boot/dts/exynos3250.dtsi                  |    3 +-
 arch/arm/boot/dts/exynos4x12.dtsi                  |    3 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |    3 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |    3 +-
 drivers/iio/adc/exynos_adc.c                       |   29 +++++--
 7 files changed, 115 insertions(+), 95 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/exynos-adc.txt

-- 
1.7.9.5
