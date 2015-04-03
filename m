Return-Path: <antoine.tenart@free-electrons.com>
From: Antoine Tenart <antoine.tenart@free-electrons.com>
To: sebastian.hesselbarth@gmail.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>,
	zmxu@marvell.com,
	jszhang@marvell.com,
	yrliao@marvell.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] ARM: berlin: ADC support
Date: Fri,  3 Apr 2015 15:06:45 +0200
Message-Id: <1428066409-30392-1-git-send-email-antoine.tenart@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>

Hi,

The Berlin ADC provides 8 channels, with one connected to a temperature
sensor. The temperature sensor has its own registers and both the ADC
and the temperature sensor need to be configured when using it.

This series is based on the two Berlin controllers rework series:
- https://lkml.org/lkml/2015/3/6/511
- https://lkml.org/lkml/2015/3/6/535

Antoine

Changes since v1:
        - updated to use regmap_update_bits()
        - fixed mixed berlin/berlin2 and some prefixes
        - reworked channel definitions
        - moved to IIO_CHAN_INFO_PROCESSED for the tsen
        - fixed some typos
        - cosmetic changes

Antoine Tenart (4):
  iio: adc: add support for Berlin
  Documentation: bindings: document the Berlin ADC driver
  ARM: berlin: add an ADC node for the BG2Q
  ARM: berlin: enable the ADC on the BG2Q DMP

 .../devicetree/bindings/iio/adc/berlin2_adc.txt    |  19 ++
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts         |   4 +
 arch/arm/boot/dts/berlin2q.dtsi                    |   8 +
 drivers/iio/adc/Kconfig                            |   7 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/berlin2-adc.c                      | 379 +++++++++++++++++++++
 6 files changed, 418 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt
 create mode 100644 drivers/iio/adc/berlin2-adc.c

-- 
2.3.4
