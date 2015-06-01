Return-Path: <mfuzzey@parkeon.com>
Subject: [PATCH V5 5/7] iio: mma8452: Add support for transient event
 debouncing
To: Jonathan Cameron <jic23@kernel.org>
From: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: linux-iio@vger.kernel.org
Date: Mon, 01 Jun 2015 15:39:54 +0200
Message-ID: <20150601133954.24925.6468.stgit@localhost>
In-Reply-To: <20150601133943.24925.83080.stgit@localhost>
References: <20150601133943.24925.83080.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

Allow the debouce counter for transient events to be configured
using the sysfs attribute events/in_accel_thresh_rising_period

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/iio/accel/mma8452.c |   76 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index f30eb9b..7429df3 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -38,6 +38,7 @@
 #define MMA8452_TRANSIENT_SRC_ZTRANSE		BIT(5)
 #define MMA8452_TRANSIENT_THS 0x1f
 #define MMA8452_TRANSIENT_THS_MASK	0x7f
+#define MMA8452_TRANSIENT_COUNT 0x20
 #define MMA8452_OFF_X 0x2f
 #define MMA8452_OFF_Y 0x30
 #define MMA8452_OFF_Z 0x31
@@ -124,6 +125,12 @@ static int mma8452_get_int_plus_micros_index(const int (*vals)[2], int n,
 	return -EINVAL;
 }
 
+static int mma8452_get_odr_index(struct mma8452_data *data)
+{
+	return (data->ctrl_reg1 & MMA8452_CTRL_DR_MASK) >>
+			MMA8452_CTRL_DR_SHIFT;
+}
+
 static const int mma8452_samp_freq[8][2] = {
 	{800, 0}, {400, 0}, {200, 0}, {100, 0}, {50, 0}, {12, 500000},
 	{6, 250000}, {1, 560000}
@@ -139,6 +146,18 @@ static const int mma8452_scales[3][2] = {
 	{0, 9577}, {0, 19154}, {0, 38307}
 };
 
+/* Datasheet table 35  (step time vs sample frequency) */
+static const int mma8452_transient_time_step_us[8] = {
+	1250,
+	2500,
+	5000,
+	10000,
+	20000,
+	20000,
+	20000,
+	20000
+};
+
 static ssize_t mma8452_show_samp_freq_avail(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -198,8 +217,7 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
 		*val2 = mma8452_scales[i][1];
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		i = (data->ctrl_reg1 & MMA8452_CTRL_DR_MASK) >>
-			MMA8452_CTRL_DR_SHIFT;
+		i = mma8452_get_odr_index(data);
 		*val = mma8452_samp_freq[i][0];
 		*val2 = mma8452_samp_freq[i][1];
 		return IIO_VAL_INT_PLUS_MICRO;
@@ -297,15 +315,33 @@ static int mma8452_read_thresh(struct iio_dev *indio_dev,
 			       int *val, int *val2)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
-	int ret;
+	int ret, us;
 
-	ret = i2c_smbus_read_byte_data(data->client, MMA8452_TRANSIENT_THS);
-	if (ret < 0)
-		return ret;
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		ret = i2c_smbus_read_byte_data(data->client,
+					       MMA8452_TRANSIENT_THS);
+		if (ret < 0)
+			return ret;
+
+		*val = ret & MMA8452_TRANSIENT_THS_MASK;
+		return IIO_VAL_INT;
 
-	*val = ret & MMA8452_TRANSIENT_THS_MASK;
+	case IIO_EV_INFO_PERIOD:
+		ret = i2c_smbus_read_byte_data(data->client,
+					       MMA8452_TRANSIENT_COUNT);
+		if (ret < 0)
+			return ret;
+
+		us = ret * mma8452_transient_time_step_us[
+				mma8452_get_odr_index(data)];
+		*val = us / USEC_PER_SEC;
+		*val2 = us % USEC_PER_SEC;
+		return IIO_VAL_INT_PLUS_MICRO;
 
-	return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
 }
 
 static int mma8452_write_thresh(struct iio_dev *indio_dev,
@@ -316,9 +352,26 @@ static int mma8452_write_thresh(struct iio_dev *indio_dev,
 				int val, int val2)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
+	int steps;
 
-	return mma8452_change_config(data, MMA8452_TRANSIENT_THS,
-				     val & MMA8452_TRANSIENT_THS_MASK);
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		return mma8452_change_config(data, MMA8452_TRANSIENT_THS,
+					     val & MMA8452_TRANSIENT_THS_MASK);
+
+	case IIO_EV_INFO_PERIOD:
+		steps = (val * USEC_PER_SEC + val2) /
+				mma8452_transient_time_step_us[
+					mma8452_get_odr_index(data)];
+
+		if (steps > 0xff)
+			return -EINVAL;
+
+		return mma8452_change_config(data, MMA8452_TRANSIENT_COUNT,
+					     steps);
+	default:
+		return -EINVAL;
+	}
 }
 
 static int mma8452_read_event_config(struct iio_dev *indio_dev,
@@ -456,7 +509,8 @@ static const struct iio_event_spec mma8452_transient_event[] = {
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_RISING,
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
-		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE)
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+					BIT(IIO_EV_INFO_PERIOD)
 	},
 };
 
