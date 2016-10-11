Return-Path: <amsfield22@gmail.com>
Date: Tue, 11 Oct 2016 12:57:23 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: ltr501: claim direct mode during raw writes
Message-ID: <20161011195714.GA9549@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Driver was checking for direct mode but not locking it.  Use
claim/release helper functions to guarantee the device stays
in direct mode during all raw write operations.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
 drivers/iio/light/ltr501.c | 71 +++++++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 3afc53a..0f1032d 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -729,8 +729,9 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
 	int i, ret, freq_val, freq_val2;
 	struct ltr501_chip_info *info = data->chip_info;
 
-	if (iio_buffer_enabled(indio_dev))
-		return -EBUSY;
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -739,39 +740,50 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
 			i = ltr501_get_gain_index(info->als_gain,
 						  info->als_gain_tbl_size,
 						  val, val2);
-			if (i < 0)
-				return -EINVAL;
+			if (i < 0) {
+				ret = -EINVAL;
+				goto release;
+			}
 
 			data->als_contr &= ~info->als_gain_mask;
 			data->als_contr |= i << info->als_gain_shift;
 
-			return regmap_write(data->regmap, LTR501_ALS_CONTR,
-					    data->als_contr);
+			ret = regmap_write(data->regmap, LTR501_ALS_CONTR,
+					   data->als_contr);
+			goto release;
 		case IIO_PROXIMITY:
 			i = ltr501_get_gain_index(info->ps_gain,
 						  info->ps_gain_tbl_size,
 						  val, val2);
-			if (i < 0)
-				return -EINVAL;
+			if (i < 0) {
+				ret = -EINVAL;
+				goto release;
+			}
 			data->ps_contr &= ~LTR501_CONTR_PS_GAIN_MASK;
 			data->ps_contr |= i << LTR501_CONTR_PS_GAIN_SHIFT;
 
-			return regmap_write(data->regmap, LTR501_PS_CONTR,
-					    data->ps_contr);
+			ret = regmap_write(data->regmap, LTR501_PS_CONTR,
+					   data->ps_contr);
+			goto release;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
+			goto release;
 		}
 	case IIO_CHAN_INFO_INT_TIME:
 		switch (chan->type) {
 		case IIO_INTENSITY:
-			if (val != 0)
-				return -EINVAL;
+			if (val != 0) {
+				ret = -EINVAL;
+				goto release;
+			}
 			mutex_lock(&data->lock_als);
 			i = ltr501_set_it_time(data, val2);
 			mutex_unlock(&data->lock_als);
-			return i;
+			ret = i;
+			goto release;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
+			goto release;
 		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		switch (chan->type) {
@@ -779,45 +791,46 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
 			ret = ltr501_als_read_samp_freq(data, &freq_val,
 							&freq_val2);
 			if (ret < 0)
-				return ret;
+				goto release;
 
 			ret = ltr501_als_write_samp_freq(data, val, val2);
 			if (ret < 0)
-				return ret;
+				goto release;
 
 			/* update persistence count when changing frequency */
 			ret = ltr501_write_intr_prst(data, chan->type,
 						     0, data->als_period);
 
 			if (ret < 0)
-				return ltr501_als_write_samp_freq(data,
-								  freq_val,
-								  freq_val2);
-			return ret;
+				ret = ltr501_als_write_samp_freq(data, freq_val,
+								 freq_val2);
+			goto release;
 		case IIO_PROXIMITY:
 			ret = ltr501_ps_read_samp_freq(data, &freq_val,
 						       &freq_val2);
 			if (ret < 0)
-				return ret;
+				goto release;
 
 			ret = ltr501_ps_write_samp_freq(data, val, val2);
 			if (ret < 0)
-				return ret;
+				goto release;
 
 			/* update persistence count when changing frequency */
 			ret = ltr501_write_intr_prst(data, chan->type,
 						     0, data->ps_period);
 
 			if (ret < 0)
-				return ltr501_ps_write_samp_freq(data,
-								 freq_val,
-								 freq_val2);
-			return ret;
+				ret = ltr501_ps_write_samp_freq(data, freq_val,
+								freq_val2);
+			goto release;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
+			goto release;
 		}
 	}
-	return -EINVAL;
+release:
+	iio_device_release_direct_mode(indio_dev);
+	return ret;
 }
 
 static int ltr501_read_thresh(struct iio_dev *indio_dev,
-- 
2.1.4
