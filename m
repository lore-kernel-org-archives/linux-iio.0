Return-Path: <stefan.wahren@i2se.com>
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@gmail.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 1/6] iio: mxs-lradc: clarify supported devices
Date: Sat, 18 Jul 2015 12:30:41 +0000
Message-Id: <1437222646-8742-2-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1437222646-8742-1-git-send-email-stefan.wahren@i2se.com>
References: <1437222646-8742-1-git-send-email-stefan.wahren@i2se.com>
List-ID: <linux-iio@vger.kernel.org>

At the beginning the driver supported only i.MX28 SoC, but now the
whole MXS platform. So remove any confusing comments which apply
only to i.MX28.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../bindings/staging/iio/adc/mxs-lradc.txt         |    2 +-
 drivers/staging/iio/adc/mxs-lradc.c                |   18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt b/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
index 3075377..555fb11 100644
--- a/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
+++ b/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
@@ -1,4 +1,4 @@
-* Freescale i.MX28 LRADC device driver
+* Freescale MXS LRADC device driver
 
 Required properties:
 - compatible: Should be "fsl,imx23-lradc" for i.MX23 SoC and "fsl,imx28-lradc"
diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index d7c5223..1ccb367 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -1,5 +1,5 @@
 /*
- * Freescale i.MX28 LRADC driver
+ * Freescale MXS LRADC driver
  *
  * Copyright (c) 2012 DENX Software Engineering, GmbH.
  * Marek Vasut <marex@denx.de>
@@ -1392,7 +1392,7 @@ static const struct iio_chan_spec mxs_lradc_chan_spec[] = {
 	MXS_ADC_CHAN(4, IIO_VOLTAGE),
 	MXS_ADC_CHAN(5, IIO_VOLTAGE),
 	MXS_ADC_CHAN(6, IIO_VOLTAGE),
-	MXS_ADC_CHAN(7, IIO_VOLTAGE),	/* VBATT */
+	MXS_ADC_CHAN(7, IIO_VOLTAGE),
 	/* Combined Temperature sensors */
 	{
 		.type = IIO_TEMP,
@@ -1411,12 +1411,12 @@ static const struct iio_chan_spec mxs_lradc_chan_spec[] = {
 		.scan_index = -1,
 		.channel = 9,
 	},
-	MXS_ADC_CHAN(10, IIO_VOLTAGE),	/* VDDIO */
-	MXS_ADC_CHAN(11, IIO_VOLTAGE),	/* VTH */
-	MXS_ADC_CHAN(12, IIO_VOLTAGE),	/* VDDA */
-	MXS_ADC_CHAN(13, IIO_VOLTAGE),	/* VDDD */
-	MXS_ADC_CHAN(14, IIO_VOLTAGE),	/* VBG */
-	MXS_ADC_CHAN(15, IIO_VOLTAGE),	/* VDD5V */
+	MXS_ADC_CHAN(10, IIO_VOLTAGE),
+	MXS_ADC_CHAN(11, IIO_VOLTAGE),
+	MXS_ADC_CHAN(12, IIO_VOLTAGE),
+	MXS_ADC_CHAN(13, IIO_VOLTAGE),
+	MXS_ADC_CHAN(14, IIO_VOLTAGE),
+	MXS_ADC_CHAN(15, IIO_VOLTAGE),
 };
 
 static int mxs_lradc_hw_init(struct mxs_lradc *lradc)
@@ -1707,6 +1707,6 @@ static struct platform_driver mxs_lradc_driver = {
 module_platform_driver(mxs_lradc_driver);
 
 MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
-MODULE_DESCRIPTION("Freescale i.MX28 LRADC driver");
+MODULE_DESCRIPTION("Freescale MXS LRADC driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
1.7.9.5
