Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-051.synserver.de ([212.40.185.51]:1073 "EHLO
	smtp-out-051.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755697Ab3GQOoB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2013 10:44:01 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/15] staging:iio:adis16260: Drop unused 'negate' property
Date: Wed, 17 Jul 2013 16:44:26 +0200
Message-Id: <1374072279-7140-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1374072279-7140-1-git-send-email-lars@metafoo.de>
References: <1374072279-7140-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove the unused 'negate' property from the driver state struct. This also
means we can now use the adis struct directly as the driver data.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adis16260.h               |  9 ----
 drivers/staging/iio/gyro/adis16260_core.c          | 60 ++++++++++------------
 drivers/staging/iio/gyro/adis16260_platform_data.h |  2 -
 3 files changed, 28 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260.h b/drivers/staging/iio/gyro/adis16260.h
index df3c0b7..05bf274 100644
--- a/drivers/staging/iio/gyro/adis16260.h
+++ b/drivers/staging/iio/gyro/adis16260.h
@@ -76,15 +76,6 @@
 #define ADIS16260_SPI_BURST	(u32)(1000 * 1000)
 #define ADIS16260_SPI_FAST	(u32)(2000 * 1000)
 
-/**
- * struct adis16260_state - device instance specific data
- * @negate:		negate the scale parameter
- **/
-struct adis16260_state {
-	unsigned	negate:1;
-	struct adis	adis;
-};
-
 /* At the moment triggers are only used for ring buffer
  * filling. This may change!
  */
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 0b34492..83ec32e 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -29,8 +29,8 @@ static ssize_t adis16260_read_frequency_available(struct device *dev,
 						  char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct adis16260_state *st = iio_priv(indio_dev);
-	if (spi_get_device_id(st->adis.spi)->driver_data)
+	struct adis *adis = iio_priv(indio_dev);
+	if (spi_get_device_id(adis->spi)->driver_data)
 		return sprintf(buf, "%s\n", "0.129 ~ 256");
 	else
 		return sprintf(buf, "%s\n", "256 2048");
@@ -41,15 +41,15 @@ static ssize_t adis16260_read_frequency(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct adis16260_state *st = iio_priv(indio_dev);
+	struct adis *adis = iio_priv(indio_dev);
 	int ret, len = 0;
 	u16 t;
 	int sps;
-	ret = adis_read_reg_16(&st->adis, ADIS16260_SMPL_PRD, &t);
+	ret = adis_read_reg_16(adis, ADIS16260_SMPL_PRD, &t);
 	if (ret)
 		return ret;
 
-	if (spi_get_device_id(st->adis.spi)->driver_data) /* If an adis16251 */
+	if (spi_get_device_id(adis->spi)->driver_data) /* If an adis16251 */
 		sps =  (t & ADIS16260_SMPL_PRD_TIME_BASE) ? 8 : 256;
 	else
 		sps =  (t & ADIS16260_SMPL_PRD_TIME_BASE) ? 66 : 2048;
@@ -64,7 +64,7 @@ static ssize_t adis16260_write_frequency(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct adis16260_state *st = iio_priv(indio_dev);
+	struct adis *adis = iio_priv(indio_dev);
 	long val;
 	int ret;
 	u8 t;
@@ -76,7 +76,7 @@ static ssize_t adis16260_write_frequency(struct device *dev,
 		return -EINVAL;
 
 	mutex_lock(&indio_dev->mlock);
-	if (spi_get_device_id(st->adis.spi)->driver_data) {
+	if (spi_get_device_id(adis->spi)->driver_data) {
 		t = (256 / val);
 		if (t > 0)
 			t--;
@@ -88,12 +88,10 @@ static ssize_t adis16260_write_frequency(struct device *dev,
 		t &= ADIS16260_SMPL_PRD_DIV_MASK;
 	}
 	if ((t & ADIS16260_SMPL_PRD_DIV_MASK) >= 0x0A)
-		st->adis.spi->max_speed_hz = ADIS16260_SPI_SLOW;
+		adis->spi->max_speed_hz = ADIS16260_SPI_SLOW;
 	else
-		st->adis.spi->max_speed_hz = ADIS16260_SPI_FAST;
-	ret = adis_write_reg_8(&st->adis,
-			ADIS16260_SMPL_PRD,
-			t);
+		adis->spi->max_speed_hz = ADIS16260_SPI_FAST;
+	ret = adis_write_reg_8(adis, ADIS16260_SMPL_PRD, t);
 
 	mutex_unlock(&indio_dev->mlock);
 
@@ -103,11 +101,11 @@ static ssize_t adis16260_write_frequency(struct device *dev,
 /* Power down the device */
 static int adis16260_stop_device(struct iio_dev *indio_dev)
 {
-	struct adis16260_state *st = iio_priv(indio_dev);
+	struct adis *adis = iio_priv(indio_dev);
 	int ret;
 	u16 val = ADIS16260_SLP_CNT_POWER_OFF;
 
-	ret = adis_write_reg_16(&st->adis, ADIS16260_SLP_CNT, val);
+	ret = adis_write_reg_16(adis, ADIS16260_SLP_CNT, val);
 	if (ret)
 		dev_err(&indio_dev->dev, "problem with turning device off: SLP_CNT");
 
@@ -146,7 +144,7 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 			      int *val, int *val2,
 			      long mask)
 {
-	struct adis16260_state *st = iio_priv(indio_dev);
+	struct adis *adis = iio_priv(indio_dev);
 	int ret;
 	int bits;
 	u8 addr;
@@ -160,7 +158,7 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
 			*val = 0;
-			if (spi_get_device_id(st->adis.spi)->driver_data) {
+			if (spi_get_device_id(adis->spi)->driver_data) {
 				/* 0.01832 degree / sec */
 				*val2 = IIO_DEGREE_TO_RAD(18320);
 			} else {
@@ -198,7 +196,7 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 		}
 		mutex_lock(&indio_dev->mlock);
 		addr = adis16260_addresses[chan->scan_index][0];
-		ret = adis_read_reg_16(&st->adis, addr, &val16);
+		ret = adis_read_reg_16(adis, addr, &val16);
 		if (ret) {
 			mutex_unlock(&indio_dev->mlock);
 			return ret;
@@ -218,7 +216,7 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 		}
 		mutex_lock(&indio_dev->mlock);
 		addr = adis16260_addresses[chan->scan_index][1];
-		ret = adis_read_reg_16(&st->adis, addr, &val16);
+		ret = adis_read_reg_16(adis, addr, &val16);
 		if (ret) {
 			mutex_unlock(&indio_dev->mlock);
 			return ret;
@@ -236,7 +234,7 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 			       int val2,
 			       long mask)
 {
-	struct adis16260_state *st = iio_priv(indio_dev);
+	struct adis *adis = iio_priv(indio_dev);
 	int bits = 12;
 	s16 val16;
 	u8 addr;
@@ -244,11 +242,11 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 		val16 = val & ((1 << bits) - 1);
 		addr = adis16260_addresses[chan->scan_index][0];
-		return adis_write_reg_16(&st->adis, addr, val16);
+		return adis_write_reg_16(adis, addr, val16);
 	case IIO_CHAN_INFO_CALIBSCALE:
 		val16 = val & ((1 << bits) - 1);
 		addr = adis16260_addresses[chan->scan_index][1];
-		return adis_write_reg_16(&st->adis, addr, val16);
+		return adis_write_reg_16(adis, addr, val16);
 	}
 	return -EINVAL;
 }
@@ -305,18 +303,16 @@ static int adis16260_probe(struct spi_device *spi)
 {
 	int ret;
 	struct adis16260_platform_data *pd = spi->dev.platform_data;
-	struct adis16260_state *st;
 	struct iio_dev *indio_dev;
+	struct adis *adis;
 
 	/* setup the industrialio driver allocated elements */
-	indio_dev = iio_device_alloc(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*adis));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	st = iio_priv(indio_dev);
-	if (pd)
-		st->negate = pd->negate;
+	adis = iio_priv(indio_dev);
 	/* this is only used for removal purposes */
 	spi_set_drvdata(spi, indio_dev);
 
@@ -344,11 +340,11 @@ static int adis16260_probe(struct spi_device *spi)
 	indio_dev->num_channels = ARRAY_SIZE(adis16260_channels_x);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = adis_init(&st->adis, indio_dev, spi, &adis16260_data);
+	ret = adis_init(adis, indio_dev, spi, &adis16260_data);
 	if (ret)
 		goto error_free_dev;
 
-	ret = adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
+	ret = adis_setup_buffer_and_trigger(adis, indio_dev, NULL);
 	if (ret)
 		goto error_free_dev;
 
@@ -367,7 +363,7 @@ static int adis16260_probe(struct spi_device *spi)
 	}
 
 	/* Get the device into a sane initial state */
-	ret = adis_initial_startup(&st->adis);
+	ret = adis_initial_startup(adis);
 	if (ret)
 		goto error_cleanup_buffer_trigger;
 	ret = iio_device_register(indio_dev);
@@ -377,7 +373,7 @@ static int adis16260_probe(struct spi_device *spi)
 	return 0;
 
 error_cleanup_buffer_trigger:
-	adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
+	adis_cleanup_buffer_and_trigger(adis, indio_dev);
 error_free_dev:
 	iio_device_free(indio_dev);
 error_ret:
@@ -387,11 +383,11 @@ error_ret:
 static int adis16260_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct adis16260_state *st = iio_priv(indio_dev);
+	struct adis *adis = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 	adis16260_stop_device(indio_dev);
-	adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
+	adis_cleanup_buffer_and_trigger(adis, indio_dev);
 	iio_device_free(indio_dev);
 
 	return 0;
diff --git a/drivers/staging/iio/gyro/adis16260_platform_data.h b/drivers/staging/iio/gyro/adis16260_platform_data.h
index 12802e9..73c5899 100644
--- a/drivers/staging/iio/gyro/adis16260_platform_data.h
+++ b/drivers/staging/iio/gyro/adis16260_platform_data.h
@@ -11,9 +11,7 @@
 /**
  * struct adis16260_platform_data - instance specific data
  * @direction: x y or z
- * @negate: flag to indicate value should be inverted.
  **/
 struct adis16260_platform_data {
 	char direction;
-	unsigned negate:1;
 };
-- 
1.8.0

