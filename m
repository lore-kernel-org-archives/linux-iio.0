Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:35865 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752588AbdCWMmH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Mar 2017 08:42:07 -0400
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org, wsa+renesas@sang-engineering.com,
        magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/4] iio: adc: Maxim max9611 driver
Date: Thu, 23 Mar 2017 13:41:09 +0100
Message-Id: <1490272873-2532-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello!

Second round for Maxim max9611/max9612 high-side current sense amplifier driver.

For reference, a simplified integration schematic drawing is here reported:

 ----o----/\/\/-----o-------|LOAD|---
     |    shunt     |
 ____|______________|___
 |  RS+            RS-  |
 |   |-----gain-----|   |
 |          |           |
 |          |           |
 |max9611   |->| ADC |===== I2c
 |______________________|

public datasheet available at
https://datasheets.maximintegrated.com/en/ds/MAX9611-MAX9612.pdf

Compared to v1, all channels whose values are calculated using parameters
depending on the applied gain have been transformed in "processed" channels.

Gain selection procedure is performed in kernel space, and gain-dependent
values (current sense amplifier gain and offset) are not exposed to userspace
anymore.

output reported from iio_info tool:
iio:device0: max9611_vdd
                6 channels found:
                        voltage0:  (input)
                        1 channel-specific attributes found:
                                attr 0: input value: 4.085000000
                        voltage1:  (input)
                        3 channel-specific attributes found:
                                attr 0: scale value: 14
                                attr 1: offset value: 1
                                attr 2: raw value: 59
                        shunt:  (input)
                        2 channel-specific attributes found:
                                attr 0: resistor_power value: 5000
                                attr 1: resistor_current value: 5000
                        power:  (input)
                        1 channel-specific attributes found:
                                attr 0: input value: 663.404000000
                        temp:  (input)
                        2 channel-specific attributes found:
                                attr 0: scale value: 0.480076812
                                attr 1: raw value: 59
                        current:  (input)
                        1 channel-specific attributes found:
                                attr 0: input value: 817.000000000

Tested on Salvator-X M3-W board.

Thanks
   j

v1 -> v2:
- Drop wildcard (max961x) in driver, documentation and dt-bindings. Use
  max9611 instead.
- Make 3 processed channels for csa voltage, csa current and power load
- Remove wrapper functions around i2c buffer access
- Add locking in read_raw()
- Make 2 separate attributes for shunt resistor: current and power
- Renamed shunt resistor attribute
- Fixed several review comments

Jacopo Mondi (4):
  Documentation: dt-bindings: iio: Add max9611 ADC
  iio: Documentation: Add max9611 sysfs documentation
  iio: adc: Add Maxim max9611 ADC driver
  arm64: dts: salvator-x: Add current sense amplifiers


 .../ABI/testing/sysfs-bus-iio-adc-max9611          |  16 +
 .../devicetree/bindings/iio/adc/max9611.txt        |  27 +
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  18 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/max9611.c                          | 590 +++++++++++++++++++++
 6 files changed, 662 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max9611
 create mode 100644 Documentation/devicetree/bindings/iio/adc/max9611.txt
 create mode 100644 drivers/iio/adc/max9611.c

-- 
2.7.4

