Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49068 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932455AbbLNNyl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 14 Dec 2015 08:54:41 -0500
From: Markus Pargmann <mpa@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lee Jones <lee.jones@linaro.org>
Cc: Denis Carikli <denis@eukrea.com>,
	=?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Fabio Estevam <festevam@gmail.com>,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v10 0/8] imx25 adc and touchscreen driver
Date: Mon, 14 Dec 2015 14:53:46 +0100
Message-Id: <1450101234-2191-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

v10 includes minor fixes in the gcq driver code and the renamed two DT
properties for the touchscreen which now include the units in the name.

Best Regards,

Markus


Denis Carikli (2):
  ARM: dts: imx25: Add TSC and ADC support
  ARM: imx_v4_v5_defconfig: Add I.MX25 Touchscreen controller and ADC
    support.

Markus Pargmann (6):
  ARM: dt: Binding documentation for imx25 ADC/TSC
  ARM: dt: Binding documentation for imx25 GCQ
  ARM: dt: Binding documentation for imx25 touchscreen controller
  mfd: fsl imx25 Touchscreen ADC driver
  iio: adc: fsl,imx25-gcq driver
  input: touchscreen: imx25 tcq driver

 .../devicetree/bindings/iio/adc/fsl,imx25-gcq.txt  |  58 ++
 .../bindings/input/touchscreen/fsl-mx25-tcq.txt    |  35 ++
 .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    |  47 ++
 arch/arm/boot/dts/imx25.dtsi                       |  29 +-
 arch/arm/configs/imx_v4_v5_defconfig               |   4 +
 drivers/iio/adc/Kconfig                            |   7 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/fsl-imx25-gcq.c                    | 417 ++++++++++++++
 drivers/input/touchscreen/Kconfig                  |   9 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/fsl-imx25-tcq.c          | 596 +++++++++++++++++++++
 drivers/mfd/Kconfig                                |   9 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/fsl-imx25-tsadc.c                      | 203 +++++++
 include/dt-bindings/iio/adc/fsl-imx25-gcq.h        |  18 +
 include/linux/mfd/imx25-tsadc.h                    | 140 +++++
 16 files changed, 1573 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
 create mode 100644 drivers/iio/adc/fsl-imx25-gcq.c
 create mode 100644 drivers/input/touchscreen/fsl-imx25-tcq.c
 create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
 create mode 100644 include/dt-bindings/iio/adc/fsl-imx25-gcq.h
 create mode 100644 include/linux/mfd/imx25-tsadc.h

-- 
2.6.2

