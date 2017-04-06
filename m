Return-Path: <SRS0=pypW=3O=jmondi.org=jacopo+renesas@kernel.org>
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org,
	wsa+renesas@sang-engineering.com,
	magnus.damm@gmail.com,
	laurent.pinchart@ideasonboard.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	robh+dt@kernel.org,
	mark.rutland@arm.com
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v5 0/4] iio: adc: Maxim max9611 driver
Date: Thu,  6 Apr 2017 16:20:50 +0200
Message-Id: <1491488454-22468-1-git-send-email-jacopo+renesas@jmondi.org>
List-ID: <linux-iio@vger.kernel.org>

Hi there,
   fifth round for max9611/9612 ADC iio driver.

I have changed dt-bindings to use "shunt-resistor-micro-ohms" as ina2xx does,
and changed the sysfs attributes exposing the shunt resistor value to use Ohms
as units.

Output of iio_info on Salvator-X board for max9611 chip installed on
VDD_0.8 lines.
The VDD_0.8 line powers the CPU cluster and on-board RAM.

        iio:device0: max9611
                5 channels found:
                        voltage0:  (input)
                        1 channel-specific attributes found:
                                attr 0: input value: 4.085000000
                        voltage1:  (input)
                        3 channel-specific attributes found:
                                attr 0: scale value: 14
                                attr 1: offset value: 1
                                attr 2: raw value: 59
                        power:  (input)
                        2 channel-specific attributes found:
                                attr 0: shunt_resistor value: 5.000
                                attr 1: input value: 663.404000000
                        current:  (input)
                        2 channel-specific attributes found:
                                attr 0: shunt_resistor value: 5.000
                                attr 1: input value: 817.000000000
                        temp:  (input)
                        2 channel-specific attributes found:
                                attr 0: scale value: 480.076812289
                                attr 1: raw value: 59

The collected information represent:

* voltage0 (current sense voltage) Vcsa
  voltage drop between RS+ and RS- input = 4,085 mV
* voltage1: (common input voltage) Vcim
  voltage at RS+ input = (59 - 1) * 14 = 812 mV
* current flowing on shunt resistor (Icsa)
  = Vcsa / Rshunt = 817 mA
* power load on the sensed line (Pload)
  = Vcim * Icsa = 663 m
* die temperature = (57 * 480.07) = 27360 milli Celsius

v1 -> v2:
- Drop wildcard (max961x) in driver, documentation and dt-bindings. Use
  max9611 instead.
- Make 3 processed channels for csa voltage, csa current and power load
- Remove wrapper functions around i2c buffer access
- Add locking in read_raw()
- Make 2 separate attributes for shunt resistor: current and power
- Renamed shunt resistor attribute
- Fixed several review comments

v2 -> v3:
- Incorporated Geert's suggestions on using a more generic name for ADC nodes
  in device tree
- Changed "maxim,shunt-resistor-uohm" to "shunt-resistor-uohm"
- Update documentation accordingly to the two previous changes

v3 -> v4:
- Move all locking to read_single() function
- Re-structure read_raw() with Jonathan's and Peter's comments
- Rename some defines pre-pending MAX9611 prefix
- Use values from .comaptible entries for device name
- Change temperature scale to have a value in milli Celsius
- Simplify init routine using read_single

v4 -> v5:
- Change device tree property name for shunt resistor in
  "shunt-resistor-micro-ohms"
- Display shunt resistor value with Ohms as units in sysfs

Jacopo Mondi (4):
  Documentation: dt-bindings: iio: Add max9611 ADC
  iio: Documentation: Add max9611 sysfs documentation
  iio: adc: Add Maxim max9611 ADC driver
  arm64: dts: salvator-x: Add current sense amplifiers

 .../ABI/testing/sysfs-bus-iio-adc-max9611          |  17 +
 .../devicetree/bindings/iio/adc/max9611.txt        |  27 +
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  18 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/max9611.c                          | 587 +++++++++++++++++++++
 6 files changed, 660 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max9611
 create mode 100644 Documentation/devicetree/bindings/iio/adc/max9611.txt
 create mode 100644 drivers/iio/adc/max9611.c

--
2.7.4
