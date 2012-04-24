Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org,
	drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 08/11] staging:iio:dac:ad5446: Consolidate store_sample and store_pwr_down functions
Date: Tue, 24 Apr 2012 18:49:38 +0200
Message-Id: <1335286181-20474-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1335286181-20474-1-git-send-email-lars@metafoo.de>
References: <1335286181-20474-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The devices supported by this drivers only have a single shift register, which
contains both the power down mode and the output sample. So writing the power
down mode and the output sample can be done by the same function. Call this
function prepare_write as it will prepare the spi message for a write. Also
introduce a small helper function which performs the whole write by calling the
chip the specific prepare function followed by a spi_sync.

The two power down bits are always placed ontop of the msb of the output sample,
so we can easily calculate their position by adding the channels shift to the
channels realbits.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/ad5446.c |   75 +++++++++++++-------------------------
 drivers/staging/iio/dac/ad5446.h |    6 +--
 2 files changed, 28 insertions(+), 53 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index 20c414c..731cd05 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -24,35 +24,16 @@
 
 #include "ad5446.h"
 
-static int ad5446_store_sample(struct ad5446_state *st, unsigned val)
+static int ad5446_write(struct ad5446_state *st, unsigned val)
 {
 	__be16 data = cpu_to_be16(val);
 	return spi_write(st->spi, &data, sizeof(data));
 }
 
-static int ad5660_store_sample(struct ad5446_state *st, unsigned val)
+static int ad5660_write(struct ad5446_state *st, unsigned val)
 {
 	uint8_t data[3];
 
-	val |= AD5660_LOAD;
-	data[0] = (val >> 16) & 0xFF;
-	data[1] = (val >> 8) & 0xFF;
-	data[2] = val & 0xFF;
-
-	return spi_write(st->spi, data, sizeof(data));
-}
-
-static int ad5620_store_pwr_down(struct ad5446_state *st, unsigned mode)
-{
-	__be16 data = cpu_to_be16(mode << 14);
-	return spi_write(st->spi, &data, sizeof(data));
-}
-
-static int ad5660_store_pwr_down(struct ad5446_state *st, unsigned mode)
-{
-	unsigned val = mode << 16;
-	uint8_t data[3];
-
 	data[0] = (val >> 16) & 0xFF;
 	data[1] = (val >> 8) & 0xFF;
 	data[2] = val & 0xFF;
@@ -114,6 +95,8 @@ static ssize_t ad5446_write_dac_powerdown(struct iio_dev *indio_dev,
 					    const char *buf, size_t len)
 {
 	struct ad5446_state *st = iio_priv(indio_dev);
+	unsigned int shift;
+	unsigned int val;
 	bool powerdown;
 	int ret;
 
@@ -124,11 +107,14 @@ static ssize_t ad5446_write_dac_powerdown(struct iio_dev *indio_dev,
 	mutex_lock(&indio_dev->mlock);
 	st->pwr_down = powerdown;
 
-	if (st->pwr_down)
-		ret = st->chip_info->store_pwr_down(st, st->pwr_down_mode);
-	else
-		ret = st->chip_info->store_sample(st, st->cached_val);
+	if (st->pwr_down) {
+		shift = chan->scan_type.realbits + chan->scan_type.shift;
+		val = st->pwr_down_mode << shift;
+	} else {
+		val = st->cached_val;
+	}
 
+	ret = st->chip_info->write(st, val);
 	mutex_unlock(&indio_dev->mlock);
 
 	return ret ? ret : len;
@@ -171,74 +157,65 @@ static const struct iio_chan_spec_ext_info ad5064_ext_info_powerdown[] = {
 static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
 	[ID_AD5444] = {
 		.channel = AD5446_CHANNEL(12, 16, 2),
-		.store_sample = ad5446_store_sample,
+		.write = ad5446_write,
 	},
 	[ID_AD5446] = {
 		.channel = AD5446_CHANNEL(14, 16, 0),
-		.store_sample = ad5446_store_sample,
+		.write = ad5446_write,
 	},
 	[ID_AD5541A] = {
 		.channel = AD5446_CHANNEL(16, 16, 0),
-		.store_sample = ad5446_store_sample,
+		.write = ad5446_write,
 	},
 	[ID_AD5512A] = {
 		.channel = AD5446_CHANNEL(12, 16, 4),
-		.store_sample = ad5446_store_sample,
+		.write = ad5446_write,
 	},
 	[ID_AD5553] = {
 		.channel = AD5446_CHANNEL(14, 16, 0),
-		.store_sample = ad5446_store_sample,
+		.write = ad5446_write,
 	},
 	[ID_AD5601] = {
 		.channel = AD5446_CHANNEL_POWERDOWN(8, 16, 6),
-		.store_sample = ad5446_store_sample,
-		.store_pwr_down = ad5620_store_pwr_down,
+		.write = ad5446_write,
 	},
 	[ID_AD5611] = {
 		.channel = AD5446_CHANNEL_POWERDOWN(10, 16, 4),
-		.store_sample = ad5446_store_sample,
-		.store_pwr_down = ad5620_store_pwr_down,
+		.write = ad5446_write,
 	},
 	[ID_AD5621] = {
 		.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 2),
-		.store_sample = ad5446_store_sample,
-		.store_pwr_down = ad5620_store_pwr_down,
+		.write = ad5446_write,
 	},
 	[ID_AD5620_2500] = {
 		.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 2),
 		.int_vref_mv = 2500,
-		.store_sample = ad5446_store_sample,
-		.store_pwr_down = ad5620_store_pwr_down,
+		.write = ad5446_write,
 	},
 	[ID_AD5620_1250] = {
 		.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 2),
 		.int_vref_mv = 1250,
-		.store_sample = ad5446_store_sample,
-		.store_pwr_down = ad5620_store_pwr_down,
+		.write = ad5446_write,
 	},
 	[ID_AD5640_2500] = {
 		.channel = AD5446_CHANNEL_POWERDOWN(14, 16, 0),
 		.int_vref_mv = 2500,
-		.store_sample = ad5446_store_sample,
-		.store_pwr_down = ad5620_store_pwr_down,
+		.write = ad5446_write,
 	},
 	[ID_AD5640_1250] = {
 		.channel = AD5446_CHANNEL_POWERDOWN(14, 16, 0),
 		.int_vref_mv = 1250,
-		.store_sample = ad5446_store_sample,
-		.store_pwr_down = ad5620_store_pwr_down,
+		.write = ad5446_write,
 	},
 	[ID_AD5660_2500] = {
 		.channel = AD5446_CHANNEL_POWERDOWN(16, 16, 0),
 		.int_vref_mv = 2500,
-		.store_sample = ad5660_store_sample,
-		.store_pwr_down = ad5660_store_pwr_down,
+		.write = ad5660_write,
 	},
 	[ID_AD5660_1250] = {
 		.channel = AD5446_CHANNEL_POWERDOWN(16, 16, 0),
 		.int_vref_mv = 1250,
-		.store_sample = ad5660_store_sample,
-		.store_pwr_down = ad5660_store_pwr_down,
+		.write = ad5660_write,
 	},
 };
 
@@ -280,7 +257,7 @@ static int ad5446_write_raw(struct iio_dev *indio_dev,
 		mutex_lock(&indio_dev->mlock);
 		st->cached_val = val;
 		if (!st->pwr_down)
-			ret = st->chip_info->store_sample(st, val);
+			ret = st->chip_info->write(st, val);
 		mutex_unlock(&indio_dev->mlock);
 		break;
 	default:
diff --git a/drivers/staging/iio/dac/ad5446.h b/drivers/staging/iio/dac/ad5446.h
index 0651816..1a0fb4a 100644
--- a/drivers/staging/iio/dac/ad5446.h
+++ b/drivers/staging/iio/dac/ad5446.h
@@ -51,15 +51,13 @@ struct ad5446_state {
  * struct ad5446_chip_info - chip specific information
  * @channel:		channel spec for the DAC
  * @int_vref_mv:	AD5620/40/60: the internal reference voltage
- * @store_sample:	chip specific helper function to store the datum
- * @store_sample:	chip specific helper function to store the powerpown cmd
+ * @write:		chip specific helper function to write to the register
  */
 
 struct ad5446_chip_info {
 	struct iio_chan_spec	channel;
 	u16			int_vref_mv;
-	int (*store_sample)	(struct ad5446_state *st, unsigned val);
-	int (*store_pwr_down)	(struct ad5446_state *st, unsigned mode);
+	int			(*write)(struct ad5446_state *st, unsigned val);
 };
 
 /**
-- 
1.7.9.5
