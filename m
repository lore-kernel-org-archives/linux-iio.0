Return-Path: <SRS0=zdXi=YT=it-klinger.de=ak@kernel.org>
Date: Thu, 5 Jan 2017 18:51:15 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, ak@it-klinger.de
Subject: [PATCH v5 0/2] iio: adc: hx711: Add IIO driver for AVIA HX711 ADC
Message-ID: <20170105175115.GA12193@andreas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This series adds IIO driver support for the AVIA HX711 ADC which is 
mostly used in weighting cells.

The first patch adds the new DT binding for which a new vendor avia
was also added.

The second patch is the simple IIO driver implemented as ADC.
The protocol is specific to this device and implemented using GPIOs.

Documentation of the chip can be found here:

https://cdn.sparkfun.com/datasheets/Sensors/ForceFlex/hx711_english.pdf

Changes in v5:
The reviews of Peter and Jonathan induced some improvements and lined out
at least one bug

* Patch 1: "iio: adc: hx711: Add DT binding for avia,hx711"
  - put Acked-By once again on the patch

* Patch 2: "iio: adc: hx711: Add IIO driver for AVIA HX711"
  - improved ugly locking
  - replace devm_iio_device_register() by iio_device_register() because of
    regulator_disable() in remove()
  - added ...scale_available() functions for both channels
  - name channels directly 0 and 1 instead of #define HX711_CHAN_A...
  - added hx711_wait_for_ready() function which is called after every dummy
    read to get sure the DOUT line signals that the device is ready
  - without this check there are cases in which the clock cycle of the next
    read gets interpreted by the device as gain pulses!

Changes in v4:
Thanks to the thorough reviews and suggestions of Jonathan and Lars-Peter
the driver was reworked to better meet the standard ABI of IIO. 

* Patch 1: "iio: adc: hx711: Add DT binding for avia,hx711"
  - added attribute for regulator

* Patch 2: "iio: adc: hx711: Add IIO driver for AVIA HX711"
  - two read channels for physical channels A and B
  - remove gain attribute and use scale as read raw
  - offer scale_available attribute
  - introduced regulator as analog supply; mainly needed for calculating
    the scale
  - simplyfied use of GPIOs
  - measuring input and output with oszilloscope and revised timing behavior
  - many minor changes

Changes in v3:
moved gain from devicetree to sysfs, according to comment of Lars-Peter
Thanks for reviewing and giving suggestions

* Patch 1: "iio: adc: hx711: Add DT binding for avia,hx711"
  - removed property gain

* Patch 2: "iio: adc: hx711: Add IIO driver for AVIA HX711"
  - removed property gain from devicetree
  - added device attribute (rw) for gain
  - support reading from both channels now

Changes in v2:
Lots of updates thanks to Peters review.

* Patch 1: "iio: adc: hx711: Add DT binding for avia,hx711"
  - typo
  - removed unneded section

* Patch 2: "iio: adc: hx711: Add IIO driver for AVIA HX711"
  - updated help text in Kconfig
  - removed dead code
  - removed unused power management
  - reduced channel spec to what is actually used
  - added error handling in case reset of chip not possible

Andreas Klinger (2):
  iio: adc: hx711: Add DT binding for avia,hx711
  iio: adc: hx711: Add IIO driver for AVIA HX711

 .../devicetree/bindings/iio/adc/avia-hx711.txt     |  18 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/adc/Kconfig                            |  19 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/hx711.c                            | 531 +++++++++++++++++++++
 5 files changed, 570 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
 create mode 100644 drivers/iio/adc/hx711.c

-- 
2.1.4
