Return-Path: <harald@ccbib.org>
From: Harald Geyer <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
	Marek Vasut <marex@denx.de>,
	linux-arm-kernel@lists.infradead.org,
	Harald Geyer <harald@ccbib.org>
Subject: [PATCH 0/3] mxs-lradc: Add support for current sources
Date: Fri, 22 Apr 2016 13:52:24 +0000
Message-Id: <1461333147-11873-1-git-send-email-harald@ccbib.org>
List-ID: <linux-iio@vger.kernel.org>

Patch 1/3 changes the driver and updates the binding documentation
(I guess it is still in staging.)

Patches 2/3 and 3/3 add the devicetree nodes to imx23 and imx28 boards.
I'd like to get input whether this is actually desired. On boards where
these regulators would never be enabled this costs a few extra bytes of
RAM for allocation of the device data, because the nodes can't be easily
removed in .dts files which are including the .dtsi files. The alternative
is to add the new nodes to many .dts files, which would be a lot code
duplication.

Harald Geyer (3):
  iio: mxs-lradc: Add regulators for current sources
  ARM: dts: imx23: Provide regulators for the current sources of the
    LRADC
  ARM: dts: imx28: Provide regulators for the current sources of the
    LRADC

 .../bindings/staging/iio/adc/mxs-lradc.txt         |  29 ++++
 arch/arm/boot/dts/imx23.dtsi                       |   8 ++
 arch/arm/boot/dts/imx28.dtsi                       |   8 ++
 drivers/iio/adc/Kconfig                            |   1 +
 drivers/iio/adc/mxs-lradc.c                        | 152 +++++++++++++++++++++
 5 files changed, 198 insertions(+)

-- 
2.1.4
