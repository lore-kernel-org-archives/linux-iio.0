Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: [PATCH v2 1/4] iio: light: ltr501: Fix alignment to match open parenthesis
Date: Wed,  1 Apr 2015 20:51:44 -0700
Message-Id: <ba4a6edd306efb3faa93a5bf136c721e99c5c81e.1427945689.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1427945689.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1427945689.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1427945689.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1427945689.git.sathyanarayanan.kuppuswamy@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

From: Daniel Baluta <daniel.baluta@intel.com>

This makes ltr501 code consistent with the coding style adopted
for the new drivers added to IIO.
We prepare the path for adding support for LTR559 chip.

Reported by checkpatch.pl

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/light/ltr501.c | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 62b7072..883855a 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -58,7 +58,7 @@ static int ltr501_drdy(struct ltr501_data *data, u8 drdy_mask)
 
 	while (tries--) {
 		ret = i2c_smbus_read_byte_data(data->client,
-			LTR501_ALS_PS_STATUS);
+					       LTR501_ALS_PS_STATUS);
 		if (ret < 0)
 			return ret;
 		if ((ret & drdy_mask) == drdy_mask)
@@ -77,7 +77,8 @@ static int ltr501_read_als(struct ltr501_data *data, __le16 buf[2])
 		return ret;
 	/* always read both ALS channels in given order */
 	return i2c_smbus_read_i2c_block_data(data->client,
-		LTR501_ALS_DATA1, 2 * sizeof(__le16), (u8 *) buf);
+					     LTR501_ALS_DATA1,
+					     2 * sizeof(__le16), (u8 *)buf);
 }
 
 static int ltr501_read_ps(struct ltr501_data *data)
@@ -107,7 +108,7 @@ static int ltr501_read_ps(struct ltr501_data *data)
 static const struct iio_chan_spec ltr501_channels[] = {
 	LTR501_INTENSITY_CHANNEL(0, LTR501_ALS_DATA0, IIO_MOD_LIGHT_BOTH, 0),
 	LTR501_INTENSITY_CHANNEL(1, LTR501_ALS_DATA1, IIO_MOD_LIGHT_IR,
-		BIT(IIO_CHAN_INFO_SCALE)),
+				 BIT(IIO_CHAN_INFO_SCALE)),
 	{
 		.type = IIO_PROXIMITY,
 		.address = LTR501_PS_DATA,
@@ -129,8 +130,8 @@ static const int ltr501_ps_gain[4][2] = {
 };
 
 static int ltr501_read_raw(struct iio_dev *indio_dev,
-				struct iio_chan_spec const *chan,
-				int *val, int *val2, long mask)
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
 {
 	struct ltr501_data *data = iio_priv(indio_dev);
 	__le16 buf[2];
@@ -149,7 +150,7 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
 			if (ret < 0)
 				return ret;
 			*val = le16_to_cpu(chan->address == LTR501_ALS_DATA1 ?
-				buf[0] : buf[1]);
+					   buf[0] : buf[1]);
 			return IIO_VAL_INT;
 		case IIO_PROXIMITY:
 			mutex_lock(&data->lock_ps);
@@ -199,8 +200,8 @@ static int ltr501_get_ps_gain_index(int val, int val2)
 }
 
 static int ltr501_write_raw(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       int val, int val2, long mask)
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
 {
 	struct ltr501_data *data = iio_priv(indio_dev);
 	int i;
@@ -219,7 +220,8 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
 			else
 				return -EINVAL;
 			return i2c_smbus_write_byte_data(data->client,
-				LTR501_ALS_CONTR, data->als_contr);
+							 LTR501_ALS_CONTR,
+							 data->als_contr);
 		case IIO_PROXIMITY:
 			i = ltr501_get_ps_gain_index(val, val2);
 			if (i < 0)
@@ -227,7 +229,8 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
 			data->ps_contr &= ~LTR501_CONTR_PS_GAIN_MASK;
 			data->ps_contr |= i << LTR501_CONTR_PS_GAIN_SHIFT;
 			return i2c_smbus_write_byte_data(data->client,
-				LTR501_PS_CONTR, data->ps_contr);
+							 LTR501_PS_CONTR,
+							 data->ps_contr);
 		default:
 			return -EINVAL;
 		}
@@ -279,7 +282,7 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
 
 	/* figure out which data needs to be ready */
 	if (test_bit(0, indio_dev->active_scan_mask) ||
-		test_bit(1, indio_dev->active_scan_mask))
+	    test_bit(1, indio_dev->active_scan_mask))
 		mask |= LTR501_STATUS_ALS_RDY;
 	if (test_bit(2, indio_dev->active_scan_mask))
 		mask |= LTR501_STATUS_PS_RDY;
@@ -290,7 +293,9 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
 
 	if (mask & LTR501_STATUS_ALS_RDY) {
 		ret = i2c_smbus_read_i2c_block_data(data->client,
-			LTR501_ALS_DATA1, sizeof(als_buf), (u8 *) als_buf);
+						    LTR501_ALS_DATA1,
+						    sizeof(als_buf),
+						    (u8 *)als_buf);
 		if (ret < 0)
 			return ret;
 		if (test_bit(0, indio_dev->active_scan_mask))
@@ -306,8 +311,7 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
 		buf[j++] = ret & LTR501_PS_DATA_MASK;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buf,
-		iio_get_time_ns());
+	iio_push_to_buffers_with_timestamp(indio_dev, buf, iio_get_time_ns());
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
@@ -330,11 +334,11 @@ static int ltr501_init(struct ltr501_data *data)
 	data->ps_contr = ret | LTR501_CONTR_ACTIVE;
 
 	return ltr501_write_contr(data->client, data->als_contr,
-		data->ps_contr);
+				  data->ps_contr);
 }
 
 static int ltr501_probe(struct i2c_client *client,
-			  const struct i2c_device_id *id)
+			const struct i2c_device_id *id)
 {
 	struct ltr501_data *data;
 	struct iio_dev *indio_dev;
@@ -368,7 +372,7 @@ static int ltr501_probe(struct i2c_client *client,
 		return ret;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-		ltr501_trigger_handler, NULL);
+					 ltr501_trigger_handler, NULL);
 	if (ret)
 		return ret;
 
@@ -386,8 +390,8 @@ error_unreg_buffer:
 static int ltr501_powerdown(struct ltr501_data *data)
 {
 	return ltr501_write_contr(data->client,
-		data->als_contr & ~LTR501_CONTR_ACTIVE,
-		data->ps_contr & ~LTR501_CONTR_ACTIVE);
+				  data->als_contr & ~LTR501_CONTR_ACTIVE,
+				  data->ps_contr & ~LTR501_CONTR_ACTIVE);
 }
 
 static int ltr501_remove(struct i2c_client *client)
@@ -405,14 +409,14 @@ static int ltr501_remove(struct i2c_client *client)
 static int ltr501_suspend(struct device *dev)
 {
 	struct ltr501_data *data = iio_priv(i2c_get_clientdata(
-		to_i2c_client(dev)));
+					    to_i2c_client(dev)));
 	return ltr501_powerdown(data);
 }
 
 static int ltr501_resume(struct device *dev)
 {
 	struct ltr501_data *data = iio_priv(i2c_get_clientdata(
-		to_i2c_client(dev)));
+					    to_i2c_client(dev)));
 
 	return ltr501_write_contr(data->client, data->als_contr,
 		data->ps_contr);
-- 
1.9.1
