Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/3] staging:iio:imu:adis16400 add control of data filtering.
Date: Sun, 27 Nov 2011 11:39:13 +0000
Message-Id: <1322393954-31525-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1322393954-31525-1-git-send-email-jic23@kernel.org>
References: <1322393954-31525-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@cam.ac.uk>

Bartlett filter used.  Values read of figures on datasheet
so far from precise.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/adis16400.h      |    2 +
 drivers/staging/iio/imu/adis16400_core.c |  177 +++++++++++++++++++++++------
 2 files changed, 142 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/imu/adis16400.h
index f3546ee..83d133e 100644
--- a/drivers/staging/iio/imu/adis16400.h
+++ b/drivers/staging/iio/imu/adis16400.h
@@ -148,12 +148,14 @@ struct adis16400_chip_info {
  * @tx:			transmit buffer
  * @rx:			receive buffer
  * @buf_lock:		mutex to protect tx and rx
+ * @filt_int:		integer part of requested filter frequency
  **/
 struct adis16400_state {
 	struct spi_device		*us;
 	struct iio_trigger		*trig;
 	struct mutex			buf_lock;
 	struct adis16400_chip_info	*variant;
+	int				filt_int;
 
 	u8	tx[ADIS16400_MAX_TX] ____cacheline_aligned;
 	u8	rx[ADIS16400_MAX_RX] ____cacheline_aligned;
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index a6da69f..de12f9a 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -161,25 +161,65 @@ error_ret:
 	return ret;
 }
 
+static int adis16400_get_freq(struct iio_dev *indio_dev)
+{
+	u16 t;
+	int sps, ret;
+
+	ret = adis16400_spi_read_reg_16(indio_dev, ADIS16400_SMPL_PRD, &t);
+	if (ret < 0)
+		return ret;
+	sps =  (t & ADIS16400_SMPL_PRD_TIME_BASE) ? 53 : 1638;
+	sps /= (t & ADIS16400_SMPL_PRD_DIV_MASK) + 1;
+
+	return sps;
+}
+
 static ssize_t adis16400_read_frequency(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	int ret, len = 0;
-	u16 t;
-	int sps;
-	ret = adis16400_spi_read_reg_16(indio_dev,
-			ADIS16400_SMPL_PRD,
-			&t);
-	if (ret)
+	ret = adis16400_get_freq(indio_dev);
+	if (ret < 0)
 		return ret;
-	sps =  (t & ADIS16400_SMPL_PRD_TIME_BASE) ? 53 : 1638;
-	sps /= (t & ADIS16400_SMPL_PRD_DIV_MASK) + 1;
-	len = sprintf(buf, "%d SPS\n", sps);
+	len = sprintf(buf, "%d SPS\n", ret);
 	return len;
 }
 
+static const unsigned adis16400_3db_divisors[] = {
+	[0] = 2, /* Special case */
+	[1] = 5,
+	[2] = 10,
+	[3] = 50,
+	[4] = 200,
+};
+
+static int adis16400_set_filter(struct iio_dev *indio_dev, int sps, int val)
+{
+	int i, ret;
+	u16 val16;
+	for (i = ARRAY_SIZE(adis16400_3db_divisors) - 1; i >= 0; i--)
+		if (sps/adis16400_3db_divisors[i] > val)
+			break;
+	if (i == -1)
+		ret = -EINVAL;
+	else {
+		ret = adis16400_spi_read_reg_16(indio_dev,
+						ADIS16400_SENS_AVG,
+						&val16);
+		if (ret < 0)
+			goto error_ret;
+
+		ret = adis16400_spi_write_reg_16(indio_dev,
+						 ADIS16400_SENS_AVG,
+						 (val16 & ~0x03) | i);
+	}
+error_ret:
+	return ret;
+}
+
 static ssize_t adis16400_write_frequency(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf,
@@ -210,6 +250,7 @@ static ssize_t adis16400_write_frequency(struct device *dev,
 			ADIS16400_SMPL_PRD,
 			t);
 
+	/* Also update the filter */
 	mutex_unlock(&indio_dev->mlock);
 
 	return ret ? ret : len;
@@ -455,13 +496,15 @@ static u8 adis16400_addresses[17][2] = {
 	[incli_y] = { ADIS16300_ROLL_OUT }
 };
 
+
 static int adis16400_write_raw(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan,
 			       int val,
 			       int val2,
 			       long mask)
 {
-	int ret;
+	struct adis16400_state *st = iio_priv(indio_dev);
+	int ret, sps;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
@@ -471,6 +514,21 @@ static int adis16400_write_raw(struct iio_dev *indio_dev,
 				val);
 		mutex_unlock(&indio_dev->mlock);
 		return ret;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		/* Need to cache values so we can update if the frequency
+		   changes */
+		mutex_lock(&indio_dev->mlock);
+		st->filt_int = val;
+		/* Work out update to current value */
+		sps = adis16400_get_freq(indio_dev);
+		if (sps < 0) {
+			mutex_unlock(&indio_dev->mlock);
+			return sps;
+		}
+
+		ret = adis16400_set_filter(indio_dev, sps, val);
+		mutex_unlock(&indio_dev->mlock);
+		return ret;
 	default:
 		return -EINVAL;
 	}
@@ -548,6 +606,24 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 		*val = 198;
 		*val2 = 160000;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		mutex_lock(&indio_dev->mlock);
+		/* Need both the number of taps and the sampling frequency */
+		ret = adis16400_spi_read_reg_16(indio_dev,
+						ADIS16400_SENS_AVG,
+						&val16);
+		if (ret < 0) {
+			mutex_unlock(&indio_dev->mlock);
+			return ret;
+		}
+		ret = adis16400_get_freq(indio_dev);
+		if (ret > 0)
+			*val = ret/adis16400_3db_divisors[val16 & 0x03];
+		*val2 = 0;
+		mutex_unlock(&indio_dev->mlock);
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}
@@ -568,7 +644,8 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
 		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = gyro_x,
 		.scan_index = ADIS16400_SCAN_GYRO_X,
 		.scan_type = IIO_ST('s', 14, 16, 0)
@@ -577,7 +654,8 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
 		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = gyro_y,
 		.scan_index = ADIS16400_SCAN_GYRO_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -586,7 +664,8 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
 		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = gyro_z,
 		.scan_index = ADIS16400_SCAN_GYRO_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -595,7 +674,8 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
 		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = accel_x,
 		.scan_index = ADIS16400_SCAN_ACC_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -604,7 +684,8 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
 		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = accel_y,
 		.scan_index = ADIS16400_SCAN_ACC_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -613,7 +694,8 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
 		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = accel_z,
 		.scan_index = ADIS16400_SCAN_ACC_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -621,7 +703,8 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.type = IIO_MAGN,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = magn_x,
 		.scan_index = ADIS16400_SCAN_MAGN_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -629,7 +712,8 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.type = IIO_MAGN,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = magn_y,
 		.scan_index = ADIS16400_SCAN_MAGN_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -637,7 +721,8 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.type = IIO_MAGN,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = magn_z,
 		.scan_index = ADIS16400_SCAN_MAGN_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -677,7 +762,8 @@ static struct iio_chan_spec adis16350_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
 		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = gyro_x,
 		.scan_index = ADIS16400_SCAN_GYRO_X,
 		.scan_type = IIO_ST('s', 14, 16, 0)
@@ -686,7 +772,8 @@ static struct iio_chan_spec adis16350_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
 		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = gyro_y,
 		.scan_index = ADIS16400_SCAN_GYRO_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -695,7 +782,8 @@ static struct iio_chan_spec adis16350_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
 		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = gyro_z,
 		.scan_index = ADIS16400_SCAN_GYRO_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -704,7 +792,8 @@ static struct iio_chan_spec adis16350_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
 		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = accel_x,
 		.scan_index = ADIS16400_SCAN_ACC_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -713,7 +802,8 @@ static struct iio_chan_spec adis16350_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
 		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = accel_y,
 		.scan_index = ADIS16400_SCAN_ACC_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -722,7 +812,8 @@ static struct iio_chan_spec adis16350_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
 		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = accel_z,
 		.scan_index = ADIS16400_SCAN_ACC_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -732,7 +823,8 @@ static struct iio_chan_spec adis16350_channels[] = {
 		.channel = 0,
 		.extend_name = "x",
 		.info_mask = IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = temp0,
 		.scan_index = ADIS16350_SCAN_TEMP_X,
 		.scan_type = IIO_ST('s', 12, 16, 0),
@@ -742,7 +834,8 @@ static struct iio_chan_spec adis16350_channels[] = {
 		.channel = 1,
 		.extend_name = "y",
 		.info_mask = IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = temp1,
 		.scan_index = ADIS16350_SCAN_TEMP_Y,
 		.scan_type = IIO_ST('s', 12, 16, 0),
@@ -783,7 +876,8 @@ static struct iio_chan_spec adis16300_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
 		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = gyro_x,
 		.scan_index = ADIS16400_SCAN_GYRO_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -792,7 +886,8 @@ static struct iio_chan_spec adis16300_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
 		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = accel_x,
 		.scan_index = ADIS16400_SCAN_ACC_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -801,7 +896,8 @@ static struct iio_chan_spec adis16300_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
 		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = accel_y,
 		.scan_index = ADIS16400_SCAN_ACC_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -810,7 +906,8 @@ static struct iio_chan_spec adis16300_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
 		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = accel_z,
 		.scan_index = ADIS16400_SCAN_ACC_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -857,7 +954,8 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
 		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = gyro_x,
 		.scan_index = ADIS16400_SCAN_GYRO_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -866,7 +964,8 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
 		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = gyro_y,
 		.scan_index = ADIS16400_SCAN_GYRO_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -875,7 +974,8 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
 		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = gyro_z,
 		.scan_index = ADIS16400_SCAN_GYRO_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -884,7 +984,8 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
 		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = accel_x,
 		.scan_index = ADIS16400_SCAN_ACC_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -893,7 +994,8 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
 		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = accel_y,
 		.scan_index = ADIS16400_SCAN_ACC_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -902,7 +1004,8 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
 		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = accel_z,
 		.scan_index = ADIS16400_SCAN_ACC_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
-- 
1.7.7.3
