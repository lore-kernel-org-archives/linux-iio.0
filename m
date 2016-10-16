Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35455 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbcJPFCV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2016 01:02:21 -0400
Date: Sat, 15 Oct 2016 22:02:19 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: light: ltr501: claim direct mode during raw writes
Message-ID: <20161016050209.GA15218@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Driver was checking for direct mode but not locking it.  Use
claim/release helper functions to guarantee the device stays
in direct mode during all raw write operations.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
Changes in v2:
  Replaced 'goto release' statements with breaks.
  The release helper function remains in the same place as in version
  one of patch, but now break statements control the flow rather than
  jumping out with goto's.
  
  I may have 'break'd more than needed at tail end of nested switch.
  Tried to follow official c language definition.  


 drivers/iio/light/ltr501.c | 81 +++++++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 3afc53a..8f9d5cf 100644
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
@@ -739,85 +740,105 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
 			i = ltr501_get_gain_index(info->als_gain,
 						  info->als_gain_tbl_size,
 						  val, val2);
-			if (i < 0)
-				return -EINVAL;
+			if (i < 0) {
+				ret = -EINVAL;
+				break;
+			}
 
 			data->als_contr &= ~info->als_gain_mask;
 			data->als_contr |= i << info->als_gain_shift;
 
-			return regmap_write(data->regmap, LTR501_ALS_CONTR,
-					    data->als_contr);
+			ret = regmap_write(data->regmap, LTR501_ALS_CONTR,
+					   data->als_contr);
+			break;
 		case IIO_PROXIMITY:
 			i = ltr501_get_gain_index(info->ps_gain,
 						  info->ps_gain_tbl_size,
 						  val, val2);
-			if (i < 0)
-				return -EINVAL;
+			if (i < 0) {
+				ret = -EINVAL;
+				break;
+			}
 			data->ps_contr &= ~LTR501_CONTR_PS_GAIN_MASK;
 			data->ps_contr |= i << LTR501_CONTR_PS_GAIN_SHIFT;
 
-			return regmap_write(data->regmap, LTR501_PS_CONTR,
-					    data->ps_contr);
+			ret = regmap_write(data->regmap, LTR501_PS_CONTR,
+					   data->ps_contr);
+			break;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
+			break;
 		}
+		break;
+
 	case IIO_CHAN_INFO_INT_TIME:
 		switch (chan->type) {
 		case IIO_INTENSITY:
-			if (val != 0)
-				return -EINVAL;
+			if (val != 0) {
+				ret = -EINVAL;
+				break;
+			}
 			mutex_lock(&data->lock_als);
-			i = ltr501_set_it_time(data, val2);
+			ret = ltr501_set_it_time(data, val2);
 			mutex_unlock(&data->lock_als);
-			return i;
+			break;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
+			break;
 		}
+		break;
+
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		switch (chan->type) {
 		case IIO_INTENSITY:
 			ret = ltr501_als_read_samp_freq(data, &freq_val,
 							&freq_val2);
 			if (ret < 0)
-				return ret;
+				break;
 
 			ret = ltr501_als_write_samp_freq(data, val, val2);
 			if (ret < 0)
-				return ret;
+				break;
 
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
+			break;
 		case IIO_PROXIMITY:
 			ret = ltr501_ps_read_samp_freq(data, &freq_val,
 						       &freq_val2);
 			if (ret < 0)
-				return ret;
+				break;
 
 			ret = ltr501_ps_write_samp_freq(data, val, val2);
 			if (ret < 0)
-				return ret;
+				break;
 
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
+			break;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
+			break;
 		}
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
 	}
-	return -EINVAL;
+
+	iio_device_release_direct_mode(indio_dev);
+	return ret;
 }
 
 static int ltr501_read_thresh(struct iio_dev *indio_dev,
-- 
2.1.4

