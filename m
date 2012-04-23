Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-085.synserver.de ([212.40.185.85]:1049 "EHLO
	smtp-out-078.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753769Ab2DWRtZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Apr 2012 13:49:25 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/8] staging:iio:dac:ad5446: Consolidate store_sample and store_pwr_down functions
Date: Mon, 23 Apr 2012 19:51:36 +0200
Message-Id: <1335203497-11041-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1335203497-11041-1-git-send-email-lars@metafoo.de>
References: <1335203497-11041-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The devices supported by this drivers only have a single shift register, which
contains both the power down mode and the output sample. So writing the power
down mode and the output sample can be done by the same function. The two power
down bits are always placed ontop of the msb of the output sample, so we can
easily calculate their position by adding the channels shift to the channels
realbits.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/ad5446.c |   38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index c767024..90461b2 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -31,21 +31,6 @@ static void ad5446_store_sample(struct ad5446_state *st, unsigned val)
 
 static void ad5660_store_sample(struct ad5446_state *st, unsigned val)
 {
-	val |= AD5660_LOAD;
-	st->data.d24[0] = (val >> 16) & 0xFF;
-	st->data.d24[1] = (val >> 8) & 0xFF;
-	st->data.d24[2] = val & 0xFF;
-}
-
-static void ad5620_store_pwr_down(struct ad5446_state *st, unsigned mode)
-{
-	st->data.d16 = cpu_to_be16(mode << 14);
-}
-
-static void ad5660_store_pwr_down(struct ad5446_state *st, unsigned mode)
-{
-	unsigned val = mode << 16;
-
 	st->data.d24[0] = (val >> 16) & 0xFF;
 	st->data.d24[1] = (val >> 8) & 0xFF;
 	st->data.d24[2] = val & 0xFF;
@@ -105,6 +90,8 @@ static ssize_t ad5446_write_dac_powerdown(struct iio_dev *indio_dev,
 					    const char *buf, size_t len)
 {
 	struct ad5446_state *st = iio_priv(indio_dev);
+	unsigned int shift;
+	unsigned int val;
 	bool powerdown;
 	int ret;
 
@@ -115,10 +102,14 @@ static ssize_t ad5446_write_dac_powerdown(struct iio_dev *indio_dev,
 	mutex_lock(&indio_dev->mlock);
 	st->pwr_down = powerdown;
 
-	if (st->pwr_down)
-		st->chip_info->store_pwr_down(st, st->pwr_down_mode);
-	else
-		st->chip_info->store_sample(st, st->cached_val);
+	if (st->pwr_down) {
+		shift = chan->scan_type.realbits + chan->scan_type.shift;
+		val = st->pwr_down_mode << shift;
+	} else {
+		val = st->cached_val;
+	}
+
+	st->chip_info->store_sample(st, val);
 
 	ret = spi_sync(st->spi, &st->msg);
 	mutex_unlock(&indio_dev->mlock);
@@ -186,53 +177,44 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
 	[ID_AD5601] = {
 		.channel = AD5446_CHANNEL_POWERDOWN(8, 16, 6),
 		.store_sample = ad5446_store_sample,
-		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5611] = {
 		.channel = AD5446_CHANNEL_POWERDOWN(10, 16, 4),
 		.store_sample = ad5446_store_sample,
-		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5621] = {
 		.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 2),
 		.store_sample = ad5446_store_sample,
-		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5620_2500] = {
 		.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 2),
 		.int_vref_mv = 2500,
 		.store_sample = ad5446_store_sample,
-		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5620_1250] = {
 		.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 2),
 		.int_vref_mv = 1250,
 		.store_sample = ad5446_store_sample,
-		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5640_2500] = {
 		.channel = AD5446_CHANNEL_POWERDOWN(14, 16, 0),
 		.int_vref_mv = 2500,
 		.store_sample = ad5446_store_sample,
-		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5640_1250] = {
 		.channel = AD5446_CHANNEL_POWERDOWN(14, 16, 0),
 		.int_vref_mv = 1250,
 		.store_sample = ad5446_store_sample,
-		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5660_2500] = {
 		.channel = AD5446_CHANNEL_POWERDOWN(16, 16, 0),
 		.int_vref_mv = 2500,
 		.store_sample = ad5660_store_sample,
-		.store_pwr_down = ad5660_store_pwr_down,
 	},
 	[ID_AD5660_1250] = {
 		.channel = AD5446_CHANNEL_POWERDOWN(16, 16, 0),
 		.int_vref_mv = 1250,
 		.store_sample = ad5660_store_sample,
-		.store_pwr_down = ad5660_store_pwr_down,
 	},
 };
 
-- 
1.7.9.5

