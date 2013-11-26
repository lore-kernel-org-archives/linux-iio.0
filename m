Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:20912 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754438Ab3KZCHd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Nov 2013 21:07:33 -0500
From: Fugang Duan <B38611@freescale.com>
To: <jic23@kernel.org>, <sachin.kamat@linaro.org>
CC: <shawn.guo@linaro.org>, <b20596@freescale.com>,
	<linux-iio@vger.kernel.org>
Subject: [PATCH v2 0/3] *** iio:adc:imx: Add Freescale vf610 ADC driver support ***
Date: Tue, 26 Nov 2013 09:42:49 +0800
Message-ID: <1385430172-16642-1-git-send-email-B38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The patch set is to enable Vybrid VF610 ADC driver.

Please see the Reference Manual of the ADC:
http://cache.freescale.com/files/32bit/doc/ref_manual/VYBRIDRM.pdf?fpsp=1&WT_TYPE=
Reference%20Manuals&WT_VENDOR=FREESCALE&WT_FILE_FORMAT=pdf&WT_ASSET=Documentation

*** Change ***
* V2:
- Rename the driver after "vf610_adc".

* V1:
Feature:
- Enable Vybrid vf610 board ADC0 in dts file.
- ADC driver only support software trigger for the init version.
- ADC configuration support dts set.
Note: Since the ADC IP is used for Freescale Vybrid VF610, i.MX6SLX, i.MX7 serial sillicons,


Fugang Duan (3):
  ARM: dts: vf610-twr: Add ADC support
  iio:adc:imx: add Freescale Vybrid vf610 adc driver
  Documentation: add the binding file for Freescale vf610 ADC driver

 .../devicetree/bindings/iio/adc/vf610-adc.txt      |   57 ++
 arch/arm/boot/dts/vf610-twr.dts                    |   14 +
 arch/arm/boot/dts/vf610.dtsi                       |   26 +
 drivers/iio/adc/Kconfig                            |   11 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/vf610_adc.c                        |  747 ++++++++++++++++++++
 6 files changed, 856 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
 create mode 100644 drivers/iio/adc/vf610_adc.c

-- 
1.7.2.rc3


