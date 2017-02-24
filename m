Return-Path: <SRS0=fWxU=2F=jmondi.org=jacopo+renesas@kernel.org>
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org,
	wsa+renesas@sang-engineering.com,
	magnus.damm@gmail.com,
	laurent.pinchart@ideasonboard.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	meerw@pmeerw.net,
	robh+dt@kernel.org,
	mark.rutland@arm.com
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 0/4] iio: adc: Maxim max961x driver
Date: Fri, 24 Feb 2017 16:05:52 +0100
Message-Id: <1487948756-25172-1-git-send-email-jacopo+renesas@jmondi.org>
List-ID: <linux-iio@vger.kernel.org>

Hello!

This series adds driver and documentation for Maxim max9611/max9612
high-side current sense amplifier with 12-bit ADC and I2c interface.
It also registers two devices installed on VDD_0.8V and DVFS_0.8V lines
in Renesas r87796 Salvator-X board.

The device provides several functionalities, and only some of them are
currently supported by this driver.
Particularly, the on-board op-amp and analog comparator are not currently
supported.

A simplified integration schematic drawing is here reported:

 ----o----/\/\/-----o-------|LOAD|---
     |    shunt     |
 ____|______________|___
 |  RS+            RS-  |
 |   |-----gain-----|   |
 |          |           |
 |          |           |
 |max961x   |->| ADC |===== I2c
 |______________________|


The device provides though its 12-bits ADC the following informations:
- Common input voltage on RS+
- Voltage drop between RS+ and RS- ends
- Die temperature

All of the above ones are exposed though IIO with _raw and _scale values
(plus _input for milli degree Celsius die temperature).

>From the above values the driver calculates the current flowing between
RS+ and RS- ends, using the shunt resistor value provided by device tree, and
the power load. Again this values are exposed through _raw and _scale
attributes, which I'm not completely sure it's acceptables as they are
calculated values and not natively provided by the current sense amplifier.
I would like to hear IIO people opinions on this, if they should be better
exposed though some other attributes which are not _raw and _scale, or if
their calculation should be completely left to userspace tools.

Thanks
   j

Jacopo Mondi (4):
  Documentation: dt-bindings: iio: Add max961x
  iio: Documentation: Add max961x sysfs documentation
  iio: adc: Add max9611/9612 ADC driver
  arm64: dts: salvator-x: Add current sense amplifiers

 .../ABI/testing/sysfs-bus-iio-adc-max961x          |   5 +
 .../devicetree/bindings/iio/adc/max961x.txt        |  27 +
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  17 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/max961x.c                          | 648 +++++++++++++++++++++
 6 files changed, 708 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max961x
 create mode 100644 Documentation/devicetree/bindings/iio/adc/max961x.txt
 create mode 100644 drivers/iio/adc/max961x.c

-- 
2.7.4
