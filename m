Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:43109 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392AbaFVT6X (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 22 Jun 2014 15:58:23 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: kristina.martsenko@gmail.com, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/7] iio: adis: Switch sampling frequency attr to core support.
Date: Sun, 22 Jun 2014 20:59:44 +0100
Message-Id: <1403467186-26639-6-git-send-email-jic23@kernel.org>
In-Reply-To: <1403467186-26639-1-git-send-email-jic23@kernel.org>
References: <1403467186-26639-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

By using the info_mask_shared_by_all element of the channel spec, acce
to the sampling frequency becomes available to in kernel users of the
driver.  It also shortens and simplifies the code.

This particular conversion was made more complicated by the shared library
and the fact that a number of the drivers do not actually have support for
setting or reading the sampling frequency.  The hardware, in those cases
investigated supports it. It's just never been implemented.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/gyro/adis16260.c               | 124 +++++++++++------------------
 drivers/staging/iio/accel/adis16201_core.c |  14 ++--
 drivers/staging/iio/accel/adis16203_core.c |  11 +--
 drivers/staging/iio/accel/adis16204_core.c |  12 +--
 drivers/staging/iio/accel/adis16209_core.c |  18 +++--
 drivers/staging/iio/accel/adis16240_core.c |  12 +--
 include/linux/iio/imu/adis.h               |  33 ++++----
 7 files changed, 99 insertions(+), 125 deletions(-)

diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
index 22b6fb8..75fe0ed 100644
--- a/drivers/iio/gyro/adis16260.c
+++ b/drivers/iio/gyro/adis16260.c
@@ -101,65 +101,6 @@
 #define ADIS16260_SCAN_TEMP	3
 #define ADIS16260_SCAN_ANGL	4
 
-static ssize_t adis16260_read_frequency(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct adis *adis = iio_priv(indio_dev);
-	int ret, len = 0;
-	u16 t;
-	int sps;
-	ret = adis_read_reg_16(adis, ADIS16260_SMPL_PRD, &t);
-	if (ret)
-		return ret;
-
-	if (spi_get_device_id(adis->spi)->driver_data) /* If an adis16251 */
-		sps = (t & ADIS16260_SMPL_PRD_TIME_BASE) ? 8 : 256;
-	else
-		sps = (t & ADIS16260_SMPL_PRD_TIME_BASE) ? 66 : 2048;
-	sps /= (t & ADIS16260_SMPL_PRD_DIV_MASK) + 1;
-	len = sprintf(buf, "%d\n", sps);
-	return len;
-}
-
-static ssize_t adis16260_write_frequency(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct adis *adis = iio_priv(indio_dev);
-	unsigned int val;
-	int ret;
-	u8 t;
-
-	ret = kstrtouint(buf, 10, &val);
-	if (ret)
-		return ret;
-
-	mutex_lock(&indio_dev->mlock);
-	if (spi_get_device_id(adis->spi)->driver_data)
-		t = 256 / val;
-	else
-		t = 2048 / val;
-
-	if (t > ADIS16260_SMPL_PRD_DIV_MASK)
-		t = ADIS16260_SMPL_PRD_DIV_MASK;
-	else if (t > 0)
-		t--;
-
-	if (t >= 0x0A)
-		adis->spi->max_speed_hz = ADIS16260_SPI_SLOW;
-	else
-		adis->spi->max_speed_hz = ADIS16260_SPI_FAST;
-	ret = adis_write_reg_8(adis, ADIS16260_SMPL_PRD, t);
-
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret ? ret : len;
-}
-
 /* Power down the device */
 static int adis16260_stop_device(struct iio_dev *indio_dev)
 {
@@ -174,18 +115,19 @@ static int adis16260_stop_device(struct iio_dev *indio_dev)
 	return ret;
 }
 
-static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
-		adis16260_read_frequency,
-		adis16260_write_frequency);
-
 static const struct iio_chan_spec adis16260_channels[] = {
 	ADIS_GYRO_CHAN(X, ADIS16260_GYRO_OUT, ADIS16260_SCAN_GYRO,
 		BIT(IIO_CHAN_INFO_CALIBBIAS) |
-		BIT(IIO_CHAN_INFO_CALIBSCALE), 14),
-	ADIS_INCLI_CHAN(X, ADIS16260_ANGL_OUT, ADIS16260_SCAN_ANGL, 0, 14),
-	ADIS_TEMP_CHAN(ADIS16260_TEMP_OUT, ADIS16260_SCAN_TEMP, 12),
-	ADIS_SUPPLY_CHAN(ADIS16260_SUPPLY_OUT, ADIS16260_SCAN_SUPPLY, 12),
-	ADIS_AUX_ADC_CHAN(ADIS16260_AUX_ADC, ADIS16260_SCAN_AUX_ADC, 12),
+		BIT(IIO_CHAN_INFO_CALIBSCALE),
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), 14),
+	ADIS_INCLI_CHAN(X, ADIS16260_ANGL_OUT, ADIS16260_SCAN_ANGL, 0,
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), 14),
+	ADIS_TEMP_CHAN(ADIS16260_TEMP_OUT, ADIS16260_SCAN_TEMP,
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), 12),
+	ADIS_SUPPLY_CHAN(ADIS16260_SUPPLY_OUT, ADIS16260_SCAN_SUPPLY,
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), 12),
+	ADIS_AUX_ADC_CHAN(ADIS16260_AUX_ADC, ADIS16260_SCAN_AUX_ADC,
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), 12),
 	IIO_CHAN_SOFT_TIMESTAMP(5),
 };
 
@@ -258,6 +200,20 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 
 		*val = val16;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = adis_read_reg_16(adis, ADIS16260_SMPL_PRD, &val16);
+		if (ret)
+			return ret;
+
+		if (spi_get_device_id(adis->spi)->driver_data)
+		/* If an adis16251 */
+			*val = (val16 & ADIS16260_SMPL_PRD_TIME_BASE) ?
+				8 : 256;
+		else
+			*val = (val16 & ADIS16260_SMPL_PRD_TIME_BASE) ?
+				66 : 2048;
+		*val /= (val16 & ADIS16260_SMPL_PRD_DIV_MASK) + 1;
+		return IIO_VAL_INT;
 	}
 	return -EINVAL;
 }
@@ -269,7 +225,9 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 			       long mask)
 {
 	struct adis *adis = iio_priv(indio_dev);
+	int ret;
 	u8 addr;
+	u8 t;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
@@ -284,21 +242,31 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 
 		addr = adis16260_addresses[chan->scan_index][1];
 		return adis_write_reg_16(adis, addr, val);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		mutex_lock(&indio_dev->mlock);
+		if (spi_get_device_id(adis->spi)->driver_data)
+			t = 256 / val;
+		else
+			t = 2048 / val;
+
+		if (t > ADIS16260_SMPL_PRD_DIV_MASK)
+			t = ADIS16260_SMPL_PRD_DIV_MASK;
+		else if (t > 0)
+			t--;
+
+		if (t >= 0x0A)
+			adis->spi->max_speed_hz = ADIS16260_SPI_SLOW;
+		else
+			adis->spi->max_speed_hz = ADIS16260_SPI_FAST;
+		ret = adis_write_reg_8(adis, ADIS16260_SMPL_PRD, t);
+
+		mutex_unlock(&indio_dev->mlock);
+		return ret;
 	}
 	return -EINVAL;
 }
 
-static struct attribute *adis16260_attributes[] = {
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group adis16260_attribute_group = {
-	.attrs = adis16260_attributes,
-};
-
 static const struct iio_info adis16260_info = {
-	.attrs = &adis16260_attribute_group,
 	.read_raw = &adis16260_read_raw,
 	.write_raw = &adis16260_write_raw,
 	.update_scan_mode = adis_update_scan_mode,
diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index 2105576..50ba1fa 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -131,17 +131,17 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_chan_spec adis16201_channels[] = {
-	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT, ADIS16201_SCAN_SUPPLY, 12),
-	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT, ADIS16201_SCAN_TEMP, 12),
+  ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT, ADIS16201_SCAN_SUPPLY, 0, 12),
+  ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT, ADIS16201_SCAN_TEMP, 0, 12),
 	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT, ADIS16201_SCAN_ACC_X,
-		BIT(IIO_CHAN_INFO_CALIBBIAS), 14),
+		BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
 	ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT, ADIS16201_SCAN_ACC_Y,
-		BIT(IIO_CHAN_INFO_CALIBBIAS), 14),
-	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC, ADIS16201_SCAN_AUX_ADC, 12),
+		BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
+	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC, ADIS16201_SCAN_AUX_ADC, 0, 12),
 	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT, ADIS16201_SCAN_INCLI_X,
-		BIT(IIO_CHAN_INFO_CALIBBIAS), 14),
+		BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
 	ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT, ADIS16201_SCAN_INCLI_Y,
-		BIT(IIO_CHAN_INFO_CALIBBIAS), 14),
+		BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
 	IIO_CHAN_SOFT_TIMESTAMP(7)
 };
 
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 409a28e..f472137 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -99,13 +99,14 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_chan_spec adis16203_channels[] = {
-	ADIS_SUPPLY_CHAN(ADIS16203_SUPPLY_OUT, ADIS16203_SCAN_SUPPLY, 12),
-	ADIS_AUX_ADC_CHAN(ADIS16203_AUX_ADC, ADIS16203_SCAN_AUX_ADC, 12),
+	ADIS_SUPPLY_CHAN(ADIS16203_SUPPLY_OUT, ADIS16203_SCAN_SUPPLY, 0, 12),
+	ADIS_AUX_ADC_CHAN(ADIS16203_AUX_ADC, ADIS16203_SCAN_AUX_ADC, 0, 12),
 	ADIS_INCLI_CHAN(X, ADIS16203_XINCL_OUT, ADIS16203_SCAN_INCLI_X,
-		BIT(IIO_CHAN_INFO_CALIBBIAS), 14),
+		BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
 	/* Fixme: Not what it appears to be - see data sheet */
-	ADIS_INCLI_CHAN(Y, ADIS16203_YINCL_OUT, ADIS16203_SCAN_INCLI_Y, 0, 14),
-	ADIS_TEMP_CHAN(ADIS16203_TEMP_OUT, ADIS16203_SCAN_TEMP, 12),
+	ADIS_INCLI_CHAN(Y, ADIS16203_YINCL_OUT, ADIS16203_SCAN_INCLI_Y,
+		0, 0, 14),
+	ADIS_TEMP_CHAN(ADIS16203_TEMP_OUT, ADIS16203_SCAN_TEMP, 0, 12),
 	IIO_CHAN_SOFT_TIMESTAMP(5),
 };
 
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index b8ea768..19eaebc 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -136,15 +136,15 @@ static int adis16204_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_chan_spec adis16204_channels[] = {
-	ADIS_SUPPLY_CHAN(ADIS16204_SUPPLY_OUT, ADIS16204_SCAN_SUPPLY, 12),
-	ADIS_AUX_ADC_CHAN(ADIS16204_AUX_ADC, ADIS16204_SCAN_AUX_ADC, 12),
-	ADIS_TEMP_CHAN(ADIS16204_TEMP_OUT, ADIS16204_SCAN_TEMP, 12),
+	ADIS_SUPPLY_CHAN(ADIS16204_SUPPLY_OUT, ADIS16204_SCAN_SUPPLY, 0, 12),
+	ADIS_AUX_ADC_CHAN(ADIS16204_AUX_ADC, ADIS16204_SCAN_AUX_ADC, 0, 12),
+	ADIS_TEMP_CHAN(ADIS16204_TEMP_OUT, ADIS16204_SCAN_TEMP, 0, 12),
 	ADIS_ACCEL_CHAN(X, ADIS16204_XACCL_OUT, ADIS16204_SCAN_ACC_X,
-		BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK), 14),
+		BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK), 0, 14),
 	ADIS_ACCEL_CHAN(Y, ADIS16204_YACCL_OUT, ADIS16204_SCAN_ACC_Y,
-		BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK), 14),
+		BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK), 0, 14),
 	ADIS_ACCEL_CHAN(ROOT_SUM_SQUARED_X_Y, ADIS16204_XY_RSS_OUT,
-		ADIS16204_SCAN_ACC_XY, BIT(IIO_CHAN_INFO_PEAK), 14),
+		ADIS16204_SCAN_ACC_XY, BIT(IIO_CHAN_INFO_PEAK), 0, 14),
 	IIO_CHAN_SOFT_TIMESTAMP(5),
 };
 
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 4492e51..374dc6e 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -130,16 +130,18 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_chan_spec adis16209_channels[] = {
-	ADIS_SUPPLY_CHAN(ADIS16209_SUPPLY_OUT, ADIS16209_SCAN_SUPPLY, 14),
-	ADIS_TEMP_CHAN(ADIS16209_TEMP_OUT, ADIS16209_SCAN_TEMP, 12),
+	ADIS_SUPPLY_CHAN(ADIS16209_SUPPLY_OUT, ADIS16209_SCAN_SUPPLY, 0, 14),
+	ADIS_TEMP_CHAN(ADIS16209_TEMP_OUT, ADIS16209_SCAN_TEMP, 0, 12),
 	ADIS_ACCEL_CHAN(X, ADIS16209_XACCL_OUT, ADIS16209_SCAN_ACC_X,
-		BIT(IIO_CHAN_INFO_CALIBBIAS), 14),
+		BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
 	ADIS_ACCEL_CHAN(Y, ADIS16209_YACCL_OUT, ADIS16209_SCAN_ACC_Y,
-		BIT(IIO_CHAN_INFO_CALIBBIAS), 14),
-	ADIS_AUX_ADC_CHAN(ADIS16209_AUX_ADC, ADIS16209_SCAN_AUX_ADC, 12),
-	ADIS_INCLI_CHAN(X, ADIS16209_XINCL_OUT, ADIS16209_SCAN_INCLI_X, 0, 14),
-	ADIS_INCLI_CHAN(Y, ADIS16209_YINCL_OUT, ADIS16209_SCAN_INCLI_Y, 0, 14),
-	ADIS_ROT_CHAN(X, ADIS16209_ROT_OUT, ADIS16209_SCAN_ROT, 0, 14),
+		BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
+	ADIS_AUX_ADC_CHAN(ADIS16209_AUX_ADC, ADIS16209_SCAN_AUX_ADC, 0, 12),
+	ADIS_INCLI_CHAN(X, ADIS16209_XINCL_OUT, ADIS16209_SCAN_INCLI_X,
+		0, 0, 14),
+	ADIS_INCLI_CHAN(Y, ADIS16209_YINCL_OUT, ADIS16209_SCAN_INCLI_Y,
+		0, 0, 14),
+	ADIS_ROT_CHAN(X, ADIS16209_ROT_OUT, ADIS16209_SCAN_ROT, 0, 0, 14),
 	IIO_CHAN_SOFT_TIMESTAMP(8)
 };
 
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 3a303a0..74ace2a 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -173,15 +173,15 @@ static int adis16240_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_chan_spec adis16240_channels[] = {
-	ADIS_SUPPLY_CHAN(ADIS16240_SUPPLY_OUT, ADIS16240_SCAN_SUPPLY, 10),
-	ADIS_AUX_ADC_CHAN(ADIS16240_AUX_ADC, ADIS16240_SCAN_AUX_ADC, 10),
+	ADIS_SUPPLY_CHAN(ADIS16240_SUPPLY_OUT, ADIS16240_SCAN_SUPPLY, 0, 10),
+	ADIS_AUX_ADC_CHAN(ADIS16240_AUX_ADC, ADIS16240_SCAN_AUX_ADC, 0, 10),
 	ADIS_ACCEL_CHAN(X, ADIS16240_XACCL_OUT, ADIS16240_SCAN_ACC_X,
-		BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK), 10),
+		BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK), 0, 10),
 	ADIS_ACCEL_CHAN(Y, ADIS16240_YACCL_OUT, ADIS16240_SCAN_ACC_Y,
-		BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK), 10),
+		BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK), 0, 10),
 	ADIS_ACCEL_CHAN(Z, ADIS16240_ZACCL_OUT, ADIS16240_SCAN_ACC_Z,
-		BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK), 10),
-	ADIS_TEMP_CHAN(ADIS16240_TEMP_OUT, ADIS16240_SCAN_TEMP, 10),
+		BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK), 0, 10),
+	ADIS_TEMP_CHAN(ADIS16240_TEMP_OUT, ADIS16240_SCAN_TEMP, 0, 10),
 	IIO_CHAN_SOFT_TIMESTAMP(6)
 };
 
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index b665dc7..fa2d01e 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -157,13 +157,14 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, unsigned int error_mask,
 	int *val);
 
-#define ADIS_VOLTAGE_CHAN(addr, si, chan, name, bits) { \
+#define ADIS_VOLTAGE_CHAN(addr, si, chan, name, info_all, bits) { \
 	.type = IIO_VOLTAGE, \
 	.indexed = 1, \
 	.channel = (chan), \
 	.extend_name = name, \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
 		BIT(IIO_CHAN_INFO_SCALE), \
+	.info_mask_shared_by_all = info_all, \
 	.address = (addr), \
 	.scan_index = (si), \
 	.scan_type = { \
@@ -174,19 +175,20 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 	}, \
 }
 
-#define ADIS_SUPPLY_CHAN(addr, si, bits) \
-	ADIS_VOLTAGE_CHAN(addr, si, 0, "supply", bits)
+#define ADIS_SUPPLY_CHAN(addr, si, info_all, bits) \
+	ADIS_VOLTAGE_CHAN(addr, si, 0, "supply", info_all, bits)
 
-#define ADIS_AUX_ADC_CHAN(addr, si, bits) \
-	ADIS_VOLTAGE_CHAN(addr, si, 1, NULL, bits)
+#define ADIS_AUX_ADC_CHAN(addr, si, info_all, bits) \
+	ADIS_VOLTAGE_CHAN(addr, si, 1, NULL, info_all, bits)
 
-#define ADIS_TEMP_CHAN(addr, si, bits) { \
+#define ADIS_TEMP_CHAN(addr, si, info_all, bits) { \
 	.type = IIO_TEMP, \
 	.indexed = 1, \
 	.channel = 0, \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
 		BIT(IIO_CHAN_INFO_SCALE) | \
 		BIT(IIO_CHAN_INFO_OFFSET), \
+	.info_mask_shared_by_all = info_all, \
 	.address = (addr), \
 	.scan_index = (si), \
 	.scan_type = { \
@@ -197,13 +199,14 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 	}, \
 }
 
-#define ADIS_MOD_CHAN(_type, mod, addr, si, info_sep, bits) { \
+#define ADIS_MOD_CHAN(_type, mod, addr, si, info_sep, info_all, bits) { \
 	.type = (_type), \
 	.modified = 1, \
 	.channel2 = IIO_MOD_ ## mod, \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
 		 info_sep, \
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+	.info_mask_shared_by_all = info_all, \
 	.address = (addr), \
 	.scan_index = (si), \
 	.scan_type = { \
@@ -214,17 +217,17 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 	}, \
 }
 
-#define ADIS_ACCEL_CHAN(mod, addr, si, info_sep, bits) \
-	ADIS_MOD_CHAN(IIO_ACCEL, mod, addr, si, info_sep, bits)
+#define ADIS_ACCEL_CHAN(mod, addr, si, info_sep, info_all, bits) \
+	ADIS_MOD_CHAN(IIO_ACCEL, mod, addr, si, info_sep, info_all, bits)
 
-#define ADIS_GYRO_CHAN(mod, addr, si, info_sep, bits) \
-	ADIS_MOD_CHAN(IIO_ANGL_VEL, mod, addr, si, info_sep, bits)
+#define ADIS_GYRO_CHAN(mod, addr, si, info_sep, info_all, bits)		\
+	ADIS_MOD_CHAN(IIO_ANGL_VEL, mod, addr, si, info_sep, info_all, bits)
 
-#define ADIS_INCLI_CHAN(mod, addr, si, info_sep, bits) \
-	ADIS_MOD_CHAN(IIO_INCLI, mod, addr, si, info_sep, bits)
+#define ADIS_INCLI_CHAN(mod, addr, si, info_sep, info_all, bits) \
+	ADIS_MOD_CHAN(IIO_INCLI, mod, addr, si, info_sep, info_all, bits)
 
-#define ADIS_ROT_CHAN(mod, addr, si, info_sep, bits) \
-	ADIS_MOD_CHAN(IIO_ROT, mod, addr, si, info_sep, bits)
+#define ADIS_ROT_CHAN(mod, addr, si, info_sep, info_all, bits) \
+	ADIS_MOD_CHAN(IIO_ROT, mod, addr, si, info_sep, info_all, bits)
 
 #ifdef CONFIG_IIO_ADIS_LIB_BUFFER
 
-- 
2.0.0

