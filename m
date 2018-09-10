Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:59060 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbeIJVLi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Sep 2018 17:11:38 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] staging:iio:ad7606: Add support for the ad7605-4
Date: Mon, 10 Sep 2018 18:16:39 +0200
Message-Id: <20180910161639.13591-2-lars@metafoo.de>
In-Reply-To: <20180910161639.13591-1-lars@metafoo.de>
References: <20180910161639.13591-1-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add support for the AD7605-4 to the AD7606 driver. The AD7605-4 is mostly
interface compatible to the AD7606-6 with the only difference being not
having support for oversampling.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/Kconfig      |  2 +-
 drivers/staging/iio/adc/ad7606.c     | 10 ++++++++++
 drivers/staging/iio/adc/ad7606.h     |  3 +++
 drivers/staging/iio/adc/ad7606_par.c |  3 +++
 drivers/staging/iio/adc/ad7606_spi.c |  1 +
 5 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index e17efb03bac0..9d3062a07460 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -11,7 +11,7 @@ config AD7606
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices:
-	  ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
+	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7606.
diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index c5fe3003075b..44a4757b88cd 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -308,17 +308,24 @@ static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
 	/*
 	 * More devices added in future
 	 */
+	[ID_AD7605_4] = {
+		.channels = ad7606_channels,
+		.num_channels = 5,
+	},
 	[ID_AD7606_8] = {
 		.channels = ad7606_channels,
 		.num_channels = 9,
+		.has_oversampling = true,
 	},
 	[ID_AD7606_6] = {
 		.channels = ad7606_channels,
 		.num_channels = 7,
+		.has_oversampling = true,
 	},
 	[ID_AD7606_4] = {
 		.channels = ad7606_channels,
 		.num_channels = 5,
+		.has_oversampling = true,
 	},
 };
 
@@ -349,6 +356,9 @@ static int ad7606_request_gpios(struct ad7606_state *st)
 	if (IS_ERR(st->gpio_frstdata))
 		return PTR_ERR(st->gpio_frstdata);
 
+	if (!st->chip_info->has_oversampling)
+		return 0;
+
 	st->gpio_os = devm_gpiod_get_array_optional(dev, "oversampling-ratio",
 			GPIOD_OUT_LOW);
 	return PTR_ERR_OR_ZERO(st->gpio_os);
diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index fb56f479e2f1..2a8bc9e87449 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -14,11 +14,13 @@
  * @name:		identification string for chip
  * @channels:		channel specification
  * @num_channels:	number of channels
+ * @has_oversampling:	whether the device has oversampling support
  */
 
 struct ad7606_chip_info {
 	const struct iio_chan_spec	*channels;
 	unsigned int			num_channels;
+	bool				has_oversampling;
 };
 
 /**
@@ -65,6 +67,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 int ad7606_remove(struct device *dev, int irq);
 
 enum ad7606_supported_device_ids {
+	ID_AD7605_4,
 	ID_AD7606_8,
 	ID_AD7606_6,
 	ID_AD7606_4
diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
index 956e38774767..8bd86e727b02 100644
--- a/drivers/staging/iio/adc/ad7606_par.c
+++ b/drivers/staging/iio/adc/ad7606_par.c
@@ -79,6 +79,9 @@ static int ad7606_par_remove(struct platform_device *pdev)
 
 static const struct platform_device_id ad7606_driver_ids[] = {
 	{
+		.name		= "ad7605-4",
+		.driver_data	= ID_AD7605_4,
+	}, {
 		.name		= "ad7606-8",
 		.driver_data	= ID_AD7606_8,
 	}, {
diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
index ffd9d0626ec2..b76ca5a8c059 100644
--- a/drivers/staging/iio/adc/ad7606_spi.c
+++ b/drivers/staging/iio/adc/ad7606_spi.c
@@ -55,6 +55,7 @@ static int ad7606_spi_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad7606_id[] = {
+	{"ad7605-4", ID_AD7605_4},
 	{"ad7606-8", ID_AD7606_8},
 	{"ad7606-6", ID_AD7606_6},
 	{"ad7606-4", ID_AD7606_4},
-- 
2.11.0
