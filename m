Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:32910 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263AbcCIFzu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Mar 2016 00:55:50 -0500
Received: by mail-pa0-f51.google.com with SMTP id fl4so30576597pad.0
        for <linux-iio@vger.kernel.org>; Tue, 08 Mar 2016 21:55:50 -0800 (PST)
Date: Wed, 9 Mar 2016 12:55:43 +0700
From: Lee Jones <lee.jones@linaro.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Denis Carikli <denis@eukrea.com>,
	Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Fabio Estevam <festevam@gmail.com>
Subject: [GIT PULL v2] Immutable branch between MFD, Input and IIO [with fix]
Message-ID: <20160309055543.GQ13692@x1>
References: <1450101234-2191-1-git-send-email-mpa@pengutronix.de>
 <20160211155633.GB20693@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160211155633.GB20693@x1>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Please pull this new tag.  It contains a fix.

The following changes since commit 36f90b0a2ddd60823fe193a85e60ff1906c2a9b3:

  Linux 4.5-rc2 (2016-01-31 18:12:16 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-input-iio-v4.6-v2

for you to fetch changes up to 0708677558dd7d03e70292549433f0f6b04a5e00:

  iio: adc/imx25-gcq: Move incorrect do_div (2016-03-09 12:50:51 +0700)

----------------------------------------------------------------
Immutable branch between MFD, Input and IIO [with fix] due for v4.6

----------------------------------------------------------------
Arnd Bergmann (1):
      iio: adc/imx25-gcq: Move incorrect do_div

Markus Pargmann (6):
      mfd: Add DT binding documentation for imx25 ADC/TSC
      iio: Add binding documentation for imx25 GCQ
      Input: add binding documentation for imx25 touchscreen controller
      mfd: fsl-imx25-tsadc: Register touchscreen ADC driver
      iio: adc: Add imx25-gcq ADC driver
      Input: touchscreen: Add imx25 TCQ driver

 .../devicetree/bindings/iio/adc/fsl,imx25-gcq.txt  |  58 ++
 .../bindings/input/touchscreen/fsl-mx25-tcq.txt    |  35 ++
 .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    |  47 ++
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
 14 files changed, 1543 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
 create mode 100644 drivers/iio/adc/fsl-imx25-gcq.c
 create mode 100644 drivers/input/touchscreen/fsl-imx25-tcq.c
 create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
 create mode 100644 include/dt-bindings/iio/adc/fsl-imx25-gcq.h
 create mode 100644 include/linux/mfd/imx25-tsadc.h

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
