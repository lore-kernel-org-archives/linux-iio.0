Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-025.synserver.de ([212.40.185.25]:1086 "EHLO
	smtp-out-025.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447Ab2BTLxr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2012 06:53:47 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 3/6] staging:iio:dac:ad5064: Prepare driver for the addition of chip variants
Date: Mon, 20 Feb 2012 12:55:17 +0100
Message-Id: <1329738920-14281-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1329738920-14281-1-git-send-email-lars@metafoo.de>
References: <1329738920-14281-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Prepare the driver for the addition of chip variants with a different number of
channels. This is done by not hard-coding the number of channels, but instead
add a field to the chip info struct holding the number of channels. Also do not
embed the channel specs into the chip info, but rather store them independently.
This allows sharing the same channel spec between different chip infos.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/ad5064.c |   61 +++++++++++++++++++++-----------------
 1 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5064.c b/drivers/staging/iio/dac/ad5064.c
index 52fef75..40db679 100644
--- a/drivers/staging/iio/dac/ad5064.c
+++ b/drivers/staging/iio/dac/ad5064.c
@@ -19,7 +19,8 @@
 #include "../sysfs.h"
 #include "dac.h"
 
-#define AD5064_DAC_CHANNELS			4
+#define AD5064_MAX_DAC_CHANNELS			4
+#define AD5064_MAX_VREFS			4
 
 #define AD5064_ADDR(x)				((x) << 20)
 #define AD5064_CMD(x)				((x) << 24)
@@ -46,11 +47,13 @@
  * struct ad5064_chip_info - chip specific information
  * @shared_vref:	whether the vref supply is shared between channels
  * @channel:		channel specification
-*/
+ * @num_channels:	number of channels
+ */
 
 struct ad5064_chip_info {
 	bool shared_vref;
-	struct iio_chan_spec channel[AD5064_DAC_CHANNELS];
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
 };
 
 /**
@@ -67,10 +70,10 @@ struct ad5064_chip_info {
 struct ad5064_state {
 	struct spi_device		*spi;
 	const struct ad5064_chip_info	*chip_info;
-	struct regulator_bulk_data	vref_reg[AD5064_DAC_CHANNELS];
-	bool				pwr_down[AD5064_DAC_CHANNELS];
-	u8				pwr_down_mode[AD5064_DAC_CHANNELS];
-	unsigned int			dac_cache[AD5064_DAC_CHANNELS];
+	struct regulator_bulk_data	vref_reg[AD5064_MAX_VREFS];
+	bool				pwr_down[AD5064_MAX_DAC_CHANNELS];
+	u8				pwr_down_mode[AD5064_MAX_DAC_CHANNELS];
+	unsigned int			dac_cache[AD5064_MAX_DAC_CHANNELS];
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -280,40 +283,44 @@ static struct iio_chan_spec_ext_info ad5064_ext_info[] = {
 	.ext_info = ad5064_ext_info,				\
 }
 
+#define DECLARE_AD5064_CHANNELS(name, bits) \
+const struct iio_chan_spec name[] = { \
+	AD5064_CHANNEL(0, bits), \
+	AD5064_CHANNEL(1, bits), \
+	AD5064_CHANNEL(2, bits), \
+	AD5064_CHANNEL(3, bits), \
+}
+
+static DECLARE_AD5064_CHANNELS(ad5024_channels, 12);
+static DECLARE_AD5064_CHANNELS(ad5044_channels, 14);
+static DECLARE_AD5064_CHANNELS(ad5064_channels, 16);
+
 static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
 	[ID_AD5024] = {
 		.shared_vref = false,
-		.channel[0] = AD5064_CHANNEL(0, 12),
-		.channel[1] = AD5064_CHANNEL(1, 12),
-		.channel[2] = AD5064_CHANNEL(2, 12),
-		.channel[3] = AD5064_CHANNEL(3, 12),
+		.channels = ad5024_channels,
+		.num_channels = 4,
 	},
 	[ID_AD5044] = {
 		.shared_vref = false,
-		.channel[0] = AD5064_CHANNEL(0, 14),
-		.channel[1] = AD5064_CHANNEL(1, 14),
-		.channel[2] = AD5064_CHANNEL(2, 14),
-		.channel[3] = AD5064_CHANNEL(3, 14),
+		.channels = ad5044_channels,
+		.num_channels = 4,
 	},
 	[ID_AD5064] = {
 		.shared_vref = false,
-		.channel[0] = AD5064_CHANNEL(0, 16),
-		.channel[1] = AD5064_CHANNEL(1, 16),
-		.channel[2] = AD5064_CHANNEL(2, 16),
-		.channel[3] = AD5064_CHANNEL(3, 16),
+		.channels = ad5064_channels,
+		.num_channels = 4,
 	},
 	[ID_AD5064_1] = {
 		.shared_vref = true,
-		.channel[0] = AD5064_CHANNEL(0, 16),
-		.channel[1] = AD5064_CHANNEL(1, 16),
-		.channel[2] = AD5064_CHANNEL(2, 16),
-		.channel[3] = AD5064_CHANNEL(3, 16),
+		.channels = ad5064_channels,
+		.num_channels = 4,
 	},
 };
 
 static inline unsigned int ad5064_num_vref(struct ad5064_state *st)
 {
-	return st->chip_info->shared_vref ? 1 : AD5064_DAC_CHANNELS;
+	return st->chip_info->shared_vref ? 1 : st->chip_info->num_channels;
 }
 
 static const char * const ad5064_vref_names[] = {
@@ -359,7 +366,7 @@ static int __devinit ad5064_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_reg;
 
-	for (i = 0; i < AD5064_DAC_CHANNELS; ++i) {
+	for (i = 0; i < st->chip_info->num_channels; ++i) {
 		st->pwr_down_mode[i] = AD5064_LDAC_PWRDN_1K;
 		st->dac_cache[i] = 0x8000;
 	}
@@ -368,8 +375,8 @@ static int __devinit ad5064_probe(struct spi_device *spi)
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad5064_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = st->chip_info->channel;
-	indio_dev->num_channels = AD5064_DAC_CHANNELS;
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = st->chip_info->num_channels;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-- 
1.7.9

