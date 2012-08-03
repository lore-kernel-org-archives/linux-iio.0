Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Marek Vasut <marex@denx.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Juergen Beisert <jbe@pengutronix.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Wolfgang Denk <wd@denx.de>
Subject: [PATCH 0/3] i.MX28 LRADC driver
Date: Fri,  3 Aug 2012 17:28:38 +0200
Message-Id: <1344007721-11595-1-git-send-email-marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Introduce the i.MX28 LRADC driver and support tech that comes with it.

Marek Vasut (3):
  IIO: Add 4-byte unsigned reads into generic-buffer example
  IIO: Add basic MXS LRADC driver
  IIO: arm: Add LRADC to i.MX28 dts

 arch/arm/boot/dts/imx28.dtsi                       |    3 +
 drivers/staging/iio/Documentation/generic_buffer.c |   10 +
 drivers/staging/iio/adc/Kconfig                    |   12 +
 drivers/staging/iio/adc/Makefile                   |    1 +
 drivers/staging/iio/adc/mxs-lradc.c                |  591 ++++++++++++++++++++
 5 files changed, 617 insertions(+)
 create mode 100644 drivers/staging/iio/adc/mxs-lradc.c

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Juergen Beisert <jbe@pengutronix.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Wolfgang Denk <wd@denx.de>
-- 
1.7.10.4
