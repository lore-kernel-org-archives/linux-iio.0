Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:41566
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751986Ab3KYJ7K (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Nov 2013 04:59:10 -0500
From: Fugang Duan <B38611@freescale.com>
To: <jic23@kernel.org>, <sachin.kamat@linaro.org>
CC: <shawn.guo@linaro.org>, <b20596@freescale.com>,
	<linux-iio@vger.kernel.org>
Subject: [PATCH v1 0/3] *** iio:adc:imx: Add Freescale Vybrid/IMX ADC driver support ***
Date: Mon, 25 Nov 2013 17:34:28 +0800
Message-ID: <1385372071-5108-1-git-send-email-B38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The patch set is to enable Vybrid VF610 ADC driver. It is the init version.

Please see the Reference Manual of the ADC:
http://cache.freescale.com/files/32bit/doc/ref_manual/VYBRIDRM.pdf?fpsp=1&WT_TYPE=
Reference%20Manuals&WT_VENDOR=FREESCALE&WT_FILE_FORMAT=pdf&WT_ASSET=Documentation

Feature:
* Enable Vybrid vf610 board ADC0 in dts file.
* ADC driver only support software trigger for the init version.
* ADC configuration support dts set.

Note: Since the ADC IP is used for Freescale Vybrid VF610, i.MX6SLX, i.MX7 serial sillicons,
      we name the driver name to "imx_adc".

Test:
* Vybrid vf610-twr board connect ADC0 SE5 pin to one sliding rheostat for ADC test, so
  after kernel up, get the voltage from sys interface:
	cat /sys/bus/iio/devices/iio\:device0/in_voltage5_raw
	cat /sys/bus/iio/devices/iio\:device0/in_voltage_scale

	The current voltage = in_voltage5_raw * in_voltage_scale (uV).


Fugang Duan (3):
  ARM: dts: vf610-twr: Add ADC support
  iio:adc:imx: add Freescale Vybrid board adc driver
  Documentation: add the binding file for Freescale (Vybrid/IMX) ADC
    driver

 .../devicetree/bindings/iio/adc/vf610-adc.txt      |   57 ++
 arch/arm/boot/dts/vf610-twr.dts                    |   14 +
 arch/arm/boot/dts/vf610.dtsi                       |   26 +
 drivers/iio/adc/Kconfig                            |   10 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/imx_adc.c                          |  748 ++++++++++++++++++++
 6 files changed, 856 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
 create mode 100644 drivers/iio/adc/imx_adc.c

-- 
1.7.2.rc3


