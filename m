Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] iio: ad7476: Add support for the ad7091r
Date: Mon, 17 Sep 2012 14:26:48 +0200
Message-Id: <1347884808-26833-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1347884808-26833-1-git-send-email-lars@metafoo.de>
References: <1347884808-26833-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Add support for the ad7091r 12 bit ADC to the ad7476 driver. Although the
ad7091r is not really related to any of the other devices supported by this
driver, luckily for us there are not so many ways (which are not totally insane)
how sampling a single channel ADC via SPI can be implemented and support for the
ad7091r can be added to the driver with just a few adjustments.

The ad7091r requires an external "conversion start" pulse to start a sample
conversion. After the conversion has finished the result can be read via SPI. We
depend on a IIO trigger to generate this signal, as a result only sampling in
buffered mode and not in manual mode is available.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad7476.c |   30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index be2098d..7f2f45a 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -23,9 +23,12 @@
 
 #define RES_MASK(bits)	((1 << (bits)) - 1)
 
+struct ad7476_state;
+
 struct ad7476_chip_info {
 	unsigned int			int_vref_uv;
 	struct iio_chan_spec		channel[2];
+	void (*reset)(struct ad7476_state *);
 };
 
 struct ad7476_state {
@@ -45,6 +48,7 @@ struct ad7476_state {
 };
 
 enum ad7476_supported_device_ids {
+	ID_AD7091R,
 	ID_AD7276,
 	ID_AD7277,
 	ID_AD7278,
@@ -79,6 +83,12 @@ done:
 	return IRQ_HANDLED;
 }
 
+static void ad7091_reset(struct ad7476_state *st)
+{
+	/* Any transfers with 8 scl cycles will reset the device */
+	spi_read(st->spi, st->data, 1);
+}
+
 static int ad7476_scan_direct(struct ad7476_state *st)
 {
 	int ret;
@@ -130,11 +140,11 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-#define _AD7476_CHAN(bits, _shift)				\
+#define _AD7476_CHAN(bits, _shift, _info_mask)			\
 	{							\
 	.type = IIO_VOLTAGE,					\
 	.indexed = 1,						\
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |		\
+	.info_mask = _info_mask |				\
 	IIO_CHAN_INFO_SCALE_SHARED_BIT,				\
 	.scan_type = {						\
 		.sign = 'u',					\
@@ -145,10 +155,18 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 	},							\
 }
 
-#define AD7476_CHAN(bits) _AD7476_CHAN((bits), 13 - (bits))
-#define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits))
+#define AD7476_CHAN(bits) _AD7476_CHAN((bits), 13 - (bits), \
+		IIO_CHAN_INFO_RAW_SEPARATE_BIT)
+#define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits), \
+		IIO_CHAN_INFO_RAW_SEPARATE_BIT)
+#define AD7091R_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), 0)
 
 static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
+	[ID_AD7091R] = {
+		.channel[0] = AD7091R_CHAN(12),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+		.reset = ad7091_reset,
+	},
 	[ID_AD7276] = {
 		.channel[0] = AD7940_CHAN(12),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
@@ -238,6 +256,9 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 	if (ret)
 		goto error_disable_reg;
 
+	if (st->chip_info->reset)
+		st->chip_info->reset(st);
+
 	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_ring_unregister;
@@ -271,6 +292,7 @@ static int __devexit ad7476_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad7476_id[] = {
+	{"ad7091r", ID_AD7091R},
 	{"ad7273", ID_AD7277},
 	{"ad7274", ID_AD7276},
 	{"ad7276", ID_AD7276},
-- 
1.7.10.4
