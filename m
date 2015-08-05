Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-232.synserver.de ([212.40.185.232]:1037 "EHLO
	smtp-out-230.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751861AbbHENii (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Aug 2015 09:38:38 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/9] iio: adis16260: Add ADIS16266 support
Date: Wed,  5 Aug 2015 15:38:18 +0200
Message-Id: <1438781901-28000-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1438781901-28000-1-git-send-email-lars@metafoo.de>
References: <1438781901-28000-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ADIS16266 is mostly register compatible to the ADIS16260. The
difference is a different gyroscope scale factor as well not having the
relative angular displacement channel.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/gyro/adis16260.c | 137 +++++++++++++++++++++++++++++++------------
 1 file changed, 98 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
index 75fe0ed..00c6ad9 100644
--- a/drivers/iio/gyro/adis16260.c
+++ b/drivers/iio/gyro/adis16260.c
@@ -101,19 +101,24 @@
 #define ADIS16260_SCAN_TEMP	3
 #define ADIS16260_SCAN_ANGL	4
 
-/* Power down the device */
-static int adis16260_stop_device(struct iio_dev *indio_dev)
-{
-	struct adis *adis = iio_priv(indio_dev);
-	int ret;
-	u16 val = ADIS16260_SLP_CNT_POWER_OFF;
+struct adis16260_chip_info {
+	unsigned int gyro_max_val;
+	unsigned int gyro_max_scale;
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
+};
 
-	ret = adis_write_reg_16(adis, ADIS16260_SLP_CNT, val);
-	if (ret)
-		dev_err(&indio_dev->dev, "problem with turning device off: SLP_CNT");
+struct adis16260 {
+	const struct adis16260_chip_info *info;
 
-	return ret;
-}
+	struct adis adis;
+};
+
+enum adis16260_type {
+	ADIS16251,
+	ADIS16260,
+	ADIS16266,
+};
 
 static const struct iio_chan_spec adis16260_channels[] = {
 	ADIS_GYRO_CHAN(X, ADIS16260_GYRO_OUT, ADIS16260_SCAN_GYRO,
@@ -131,6 +136,55 @@ static const struct iio_chan_spec adis16260_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(5),
 };
 
+static const struct iio_chan_spec adis16266_channels[] = {
+	ADIS_GYRO_CHAN(X, ADIS16260_GYRO_OUT, ADIS16260_SCAN_GYRO,
+		BIT(IIO_CHAN_INFO_CALIBBIAS) |
+		BIT(IIO_CHAN_INFO_CALIBSCALE),
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), 14),
+	ADIS_TEMP_CHAN(ADIS16260_TEMP_OUT, ADIS16260_SCAN_TEMP,
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), 12),
+	ADIS_SUPPLY_CHAN(ADIS16260_SUPPLY_OUT, ADIS16260_SCAN_SUPPLY,
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), 12),
+	ADIS_AUX_ADC_CHAN(ADIS16260_AUX_ADC, ADIS16260_SCAN_AUX_ADC,
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), 12),
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+};
+
+static const struct adis16260_chip_info adis16260_chip_info_table[] = {
+	[ADIS16251] = {
+		.gyro_max_scale = 80,
+		.gyro_max_val = IIO_RAD_TO_DEGREE(4368),
+		.channels = adis16260_channels,
+		.num_channels = ARRAY_SIZE(adis16260_channels),
+	},
+	[ADIS16260] = {
+		.gyro_max_scale = 320,
+		.gyro_max_val = IIO_RAD_TO_DEGREE(4368),
+		.channels = adis16260_channels,
+		.num_channels = ARRAY_SIZE(adis16260_channels),
+	},
+	[ADIS16266] = {
+		.gyro_max_scale = 14000,
+		.gyro_max_val = IIO_RAD_TO_DEGREE(3357),
+		.channels = adis16266_channels,
+		.num_channels = ARRAY_SIZE(adis16266_channels),
+	},
+};
+
+/* Power down the device */
+static int adis16260_stop_device(struct iio_dev *indio_dev)
+{
+	struct adis16260 *adis16260 = iio_priv(indio_dev);
+	int ret;
+	u16 val = ADIS16260_SLP_CNT_POWER_OFF;
+
+	ret = adis_write_reg_16(&adis16260->adis, ADIS16260_SLP_CNT, val);
+	if (ret)
+		dev_err(&indio_dev->dev, "problem with turning device off: SLP_CNT");
+
+	return ret;
+}
+
 static const u8 adis16260_addresses[][2] = {
 	[ADIS16260_SCAN_GYRO] = { ADIS16260_GYRO_OFF, ADIS16260_GYRO_SCALE },
 };
@@ -140,7 +194,9 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 			      int *val, int *val2,
 			      long mask)
 {
-	struct adis *adis = iio_priv(indio_dev);
+	struct adis16260 *adis16260 = iio_priv(indio_dev);
+	const struct adis16260_chip_info *info = adis16260->info;
+	struct adis *adis = &adis16260->adis;
 	int ret;
 	u8 addr;
 	s16 val16;
@@ -152,15 +208,9 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
-			*val = 0;
-			if (spi_get_device_id(adis->spi)->driver_data) {
-				/* 0.01832 degree / sec */
-				*val2 = IIO_DEGREE_TO_RAD(18320);
-			} else {
-				/* 0.07326 degree / sec */
-				*val2 = IIO_DEGREE_TO_RAD(73260);
-			}
-			return IIO_VAL_INT_PLUS_MICRO;
+			*val = info->gyro_max_scale;
+			*val2 = info->gyro_max_val;
+			return IIO_VAL_FRACTIONAL;
 		case IIO_INCLI:
 			*val = 0;
 			*val2 = IIO_DEGREE_TO_RAD(36630);
@@ -224,7 +274,8 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 			       int val2,
 			       long mask)
 {
-	struct adis *adis = iio_priv(indio_dev);
+	struct adis16260 *adis16260 = iio_priv(indio_dev);
+	struct adis *adis = &adis16260->adis;
 	int ret;
 	u8 addr;
 	u8 t;
@@ -305,35 +356,42 @@ static const struct adis_data adis16260_data = {
 
 static int adis16260_probe(struct spi_device *spi)
 {
+	const struct spi_device_id *id;
+	struct adis16260 *adis16260;
 	struct iio_dev *indio_dev;
-	struct adis *adis;
 	int ret;
 
+	id = spi_get_device_id(spi);
+	if (!id)
+		return -ENODEV;
+
 	/* setup the industrialio driver allocated elements */
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adis));
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adis16260));
 	if (!indio_dev)
 		return -ENOMEM;
-	adis = iio_priv(indio_dev);
+	adis16260 = iio_priv(indio_dev);
 	/* this is only used for removal purposes */
 	spi_set_drvdata(spi, indio_dev);
 
-	indio_dev->name = spi_get_device_id(spi)->name;
+	adis16260->info = &adis16260_chip_info_table[id->driver_data];
+
+	indio_dev->name = id->name;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &adis16260_info;
-	indio_dev->channels = adis16260_channels;
-	indio_dev->num_channels = ARRAY_SIZE(adis16260_channels);
+	indio_dev->channels = adis16260->info->channels;
+	indio_dev->num_channels = adis16260->info->num_channels;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = adis_init(adis, indio_dev, spi, &adis16260_data);
+	ret = adis_init(&adis16260->adis, indio_dev, spi, &adis16260_data);
 	if (ret)
 		return ret;
 
-	ret = adis_setup_buffer_and_trigger(adis, indio_dev, NULL);
+	ret = adis_setup_buffer_and_trigger(&adis16260->adis, indio_dev, NULL);
 	if (ret)
 		return ret;
 
 	/* Get the device into a sane initial state */
-	ret = adis_initial_startup(adis);
+	ret = adis_initial_startup(&adis16260->adis);
 	if (ret)
 		goto error_cleanup_buffer_trigger;
 	ret = iio_device_register(indio_dev);
@@ -343,18 +401,18 @@ static int adis16260_probe(struct spi_device *spi)
 	return 0;
 
 error_cleanup_buffer_trigger:
-	adis_cleanup_buffer_and_trigger(adis, indio_dev);
+	adis_cleanup_buffer_and_trigger(&adis16260->adis, indio_dev);
 	return ret;
 }
 
 static int adis16260_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct adis *adis = iio_priv(indio_dev);
+	struct adis16260 *adis16260 = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 	adis16260_stop_device(indio_dev);
-	adis_cleanup_buffer_and_trigger(adis, indio_dev);
+	adis_cleanup_buffer_and_trigger(&adis16260->adis, indio_dev);
 
 	return 0;
 }
@@ -364,11 +422,12 @@ static int adis16260_remove(struct spi_device *spi)
  * support for the on chip filtering.
  */
 static const struct spi_device_id adis16260_id[] = {
-	{"adis16260", 0},
-	{"adis16265", 0},
-	{"adis16250", 0},
-	{"adis16255", 0},
-	{"adis16251", 1},
+	{"adis16260", ADIS16260},
+	{"adis16265", ADIS16260},
+	{"adis16266", ADIS16266},
+	{"adis16250", ADIS16260},
+	{"adis16255", ADIS16260},
+	{"adis16251", ADIS16251},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, adis16260_id);
-- 
2.1.4

