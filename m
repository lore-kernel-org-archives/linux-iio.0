Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 03/67] staging:iio:dummy move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:38:09 +0000
Message-Id: <1361997553-31058-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/iio_simple_dummy.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index aee76c7..abfee6d 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -71,25 +71,25 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		/* What other information is available? */
-		.info_mask =
+		.info_mask_separate =
 		/*
 		 * in_voltage0_raw
 		 * Raw (unscaled no bias removal etc) measurement
 		 * from the device.
 		 */
-		IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		IIO_CHAN_INFO_RAW |
 		/*
 		 * in_voltage0_offset
 		 * Offset for userspace to apply prior to scale
 		 * when converting to standard units (microvolts)
 		 */
-		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
+		IIO_CHAN_INFO_OFFSET |
 		/*
 		 * in_voltage0_scale
 		 * Multipler for userspace to apply post offset
 		 * when converting to standard units (microvolts)
 		 */
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		IIO_CHAN_INFO_SCALE,
 		/* The ordering of elements in the buffer via an enum */
 		.scan_index = voltage0,
 		.scan_type = { /* Description of storage in buffer */
@@ -118,19 +118,18 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
 		.indexed = 1,
 		.channel = 1,
 		.channel2 = 2,
-		.info_mask =
 		/*
 		 * in_voltage1-voltage2_raw
 		 * Raw (unscaled no bias removal etc) measurement
 		 * from the device.
 		 */
-		IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		.info_mask_separate = IIO_CHAN_INFO_RAW,
 		/*
 		 * in_voltage-voltage_scale
 		 * Shared version of scale - shared by differential
 		 * input channels of type IIO_VOLTAGE.
 		 */
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_shared_by_type = IIO_CHAN_INFO_SCALE,
 		.scan_index = diffvoltage1m2,
 		.scan_type = { /* Description of storage in buffer */
 			.sign = 's', /* signed */
@@ -146,9 +145,8 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
 		.indexed = 1,
 		.channel = 3,
 		.channel2 = 4,
-		.info_mask =
-		IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate = IIO_CHAN_INFO_RAW,
+		.info_mask_shared_by_type = IIO_CHAN_INFO_SCALE,
 		.scan_index = diffvoltage3m4,
 		.scan_type = {
 			.sign = 's',
@@ -166,15 +164,14 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
 		.modified = 1,
 		/* Channel 2 is use for modifiers */
 		.channel2 = IIO_MOD_X,
-		.info_mask =
-		IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		.info_mask_separate = IIO_CHAN_INFO_RAW |
 		/*
 		 * Internal bias correction value. Applied
 		 * by the hardware or driver prior to userspace
 		 * seeing the readings. Typically part of hardware
 		 * calibration.
 		 */
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
+		IIO_CHAN_INFO_CALIBBIAS,
 		.scan_index = accelx,
 		.scan_type = { /* Description of storage in buffer */
 			.sign = 's', /* signed */
@@ -191,7 +188,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
 	/* DAC channel out_voltage0_raw */
 	{
 		.type = IIO_VOLTAGE,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
+		.info_mask_separate = IIO_CHAN_INFO_RAW,
 		.output = 1,
 		.indexed = 1,
 		.channel = 0,
@@ -204,8 +201,8 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
  * @chan:	the channel whose data is to be read
  * @val:	first element of returned value (typically INT)
  * @val2:	second element of returned value (typically MICRO)
- * @mask:	what we actually want to read. 0 is the channel, everything else
- *		is as per the info_mask in iio_chan_spec.
+ * @mask:	what we actually want to read as per the info_mask_*
+ *		in iio_chan_spec.
  */
 static int iio_dummy_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -287,8 +284,8 @@ static int iio_dummy_read_raw(struct iio_dev *indio_dev,
  * @chan:	the channel whose data is to be written
  * @val:	first element of value to set (typically INT)
  * @val2:	second element of value to set (typically MICRO)
- * @mask:	what we actually want to write. 0 is the channel, everything else
- *		is as per the info_mask in iio_chan_spec.
+ * @mask:	what we actually want to write as per the info_mask_*
+ *		in iio_chan_spec.
  *
  * Note that all raw writes are assumed IIO_VAL_INT and info mask elements
  * are assumed to be IIO_INT_PLUS_MICRO unless the callback write_raw_get_fmt
-- 
1.8.1.1
