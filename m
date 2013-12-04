Return-Path: <fugang.duan@freescale.com>
From: Fugang Duan <B38611@freescale.com>
To: <jic23@kernel.org>
CC: <shawn.guo@linaro.org>, <b20596@freescale.com>, <mark.rutland@arm.com>,
	<otavio@ossystems.com.br>, <pmeerw@pmeerw.net>, <lars@metafoo.de>,
	<linux-iio@vger.kernel.org>
Subject: [PATCH v4 0/3] *** iio:adc:imx: Add Freescale vf610 ADC driver support ***
Date: Wed, 4 Dec 2013 18:00:00 +0800
Message-ID: <1386151203-29728-1-git-send-email-B38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

The patch set is to enable Vybrid VF610 ADC driver.

Please see the Reference Manual of the ADC:
http://cache.freescale.com/files/32bit/doc/ref_manual/VYBRIDRM.pdf?fpsp=1&WT_TYPE=
Reference%20Manuals&WT_VENDOR=FREESCALE&WT_FILE_FORMAT=pdf&WT_ASSET=Documentation

*** Change Log***
* V4: (review by:
	Shawn Guo <shawn.guo@linaro.org>
	Jonathan Cameron <jic23@kernel.org>
	Mark Rutland <mark.rutland@arm.com>
	Otavio Salvador <otavio@ossystems.com.br>
	Peter Meerwald <pmeerw@pmeerw.net>
	Lars-Peter Clausen <lars@metafoo.de>)
- Describe ADC refrence voltage with fixed regulator.
- Remove ADC configuration from DT, let them change at runtime.
- Add "VF610_" prefix for ADC register define.
- Update devicetree binding Documentation.

* V3: (review by Shawn Guo)
- DTS properties: use prefix "fsl," instead of "vf610".
- Drop DTS unnessary comments, and add "vref" optional propert comments.
- Modify driver format.
- Remove driver debug code.
- Remove the of_device_id .data init.
- Remove unnecessary device node check.
- Add clk_prepare_enable() return check.

* V2: (Simply review by Jonathan Cameron)
- Rename the driver after "vf610_adc".

* V1:
Feature:
- Enable Vybrid vf610 board ADC0 in dts file.
- ADC driver only support software trigger for the init version.
- ADC configuration support dts set.
Note: Since the ADC IP is used for Freescale Vybrid VF610, i.MX6SLX, i.MX7 serial sillicons.

Fugang Duan (3):
  ARM: dts: vf610-twr: Add ADC support
  iio:adc:imx: add Freescale Vybrid vf610 adc driver
  Documentation: add the binding file for Freescale vf610 ADC driver

 .../devicetree/bindings/iio/adc/vf610-adc.txt      |   42 +
 arch/arm/boot/dts/vf610-twr.dts                    |   19 +
 arch/arm/boot/dts/vf610.dtsi                       |   26 +
 drivers/iio/adc/Kconfig                            |   10 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/vf610_adc.c                        |  954 ++++++++++++++++++++
 6 files changed, 1052 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
 create mode 100644 drivers/iio/adc/vf610_adc.c

-- 
1.7.2.rc3
