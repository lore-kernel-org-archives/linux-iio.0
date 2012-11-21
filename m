Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-222.synserver.de ([212.40.185.222]:1101 "EHLO
	smtp-out-222.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755239Ab2KUQ1Z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Nov 2012 11:27:25 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/11] staging:iio:ad7793: Implement stricter id checking
Date: Wed, 21 Nov 2012 17:27:13 +0100
Message-Id: <1353515236-21843-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1353515236-21843-1-git-send-email-lars@metafoo.de>
References: <1353515236-21843-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Instead of checking whether the id of the current device matches the id of any
device supported by the driver, check whether it matches the id of the device
which the driver was instantiated for. This makes sure that the driver is not
accidentally instantiated for the wrong device.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7793.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index cbe8a02..0bbfdf3 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -102,8 +102,10 @@
 #define AD7795_CH_AIN1M_AIN1M	8 /* AIN1(-) - AIN1(-) */
 
 /* ID Register Bit Designations (AD7793_REG_ID) */
+#define AD7785_ID		0xB
 #define AD7792_ID		0xA
 #define AD7793_ID		0xB
+#define AD7794_ID		0xF
 #define AD7795_ID		0xF
 #define AD7793_ID_MASK		0xF
 
@@ -130,6 +132,7 @@
  */
 
 struct ad7793_chip_info {
+	unsigned int id;
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
 };
@@ -231,7 +234,7 @@ static int ad7793_setup(struct iio_dev *indio_dev,
 
 	id &= AD7793_ID_MASK;
 
-	if (!((id == AD7792_ID) || (id == AD7793_ID) || (id == AD7795_ID))) {
+	if (id != st->chip_info->id) {
 		dev_err(&st->sd.spi->dev, "device ID query failed\n");
 		goto out;
 	}
@@ -531,22 +534,27 @@ static DECLARE_AD7795_CHANNELS(ad7795, 24, 32);
 
 static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 	[ID_AD7785] = {
+		.id = AD7785_ID,
 		.channels = ad7785_channels,
 		.num_channels = ARRAY_SIZE(ad7785_channels),
 	},
 	[ID_AD7792] = {
+		.id = AD7792_ID,
 		.channels = ad7792_channels,
 		.num_channels = ARRAY_SIZE(ad7792_channels),
 	},
 	[ID_AD7793] = {
+		.id = AD7793_ID,
 		.channels = ad7793_channels,
 		.num_channels = ARRAY_SIZE(ad7793_channels),
 	},
 	[ID_AD7794] = {
+		.id = AD7794_ID,
 		.channels = ad7794_channels,
 		.num_channels = ARRAY_SIZE(ad7794_channels),
 	},
 	[ID_AD7795] = {
+		.id = AD7795_ID,
 		.channels = ad7795_channels,
 		.num_channels = ARRAY_SIZE(ad7795_channels),
 	},
-- 
1.8.0

