Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33359 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750717AbcJKTe2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Oct 2016 15:34:28 -0400
Date: Tue, 11 Oct 2016 12:32:22 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: mma8452: claim direct mode during write raw
Message-ID: <20161011193211.GA8716@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Driver was checking for direct mode but not locking it.  Use
claim/release helper functions to guarantee the device stays
in direct mode during all write raw operations.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
 drivers/iio/accel/mma8452.c | 53 +++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 7951def..cbbc746 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -666,37 +666,43 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 	struct mma8452_data *data = iio_priv(indio_dev);
 	int i, ret;
 
-	if (iio_buffer_enabled(indio_dev))
-		return -EBUSY;
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		i = mma8452_get_samp_freq_index(data, val, val2);
-		if (i < 0)
-			return i;
-
+		if (i < 0) {
+			ret = i;
+			goto release;
+		}
 		data->ctrl_reg1 &= ~MMA8452_CTRL_DR_MASK;
 		data->ctrl_reg1 |= i << MMA8452_CTRL_DR_SHIFT;
 
-		return mma8452_change_config(data, MMA8452_CTRL_REG1,
-					     data->ctrl_reg1);
+		ret = mma8452_change_config(data, MMA8452_CTRL_REG1,
+					    data->ctrl_reg1);
 	case IIO_CHAN_INFO_SCALE:
 		i = mma8452_get_scale_index(data, val, val2);
-		if (i < 0)
-			return i;
+		if (i < 0) {
+			ret = i;
+			goto release;
+		}
 
 		data->data_cfg &= ~MMA8452_DATA_CFG_FS_MASK;
 		data->data_cfg |= i;
 
-		return mma8452_change_config(data, MMA8452_DATA_CFG,
-					     data->data_cfg);
+		ret = mma8452_change_config(data, MMA8452_DATA_CFG,
+					    data->data_cfg);
 	case IIO_CHAN_INFO_CALIBBIAS:
-		if (val < -128 || val > 127)
-			return -EINVAL;
+		if (val < -128 || val > 127) {
+			ret = -EINVAL;
+			goto release;
+		}
 
-		return mma8452_change_config(data,
-					     MMA8452_OFF_X + chan->scan_index,
-					     val);
+		ret = mma8452_change_config(data,
+					    MMA8452_OFF_X + chan->scan_index,
+					    val);
 
 	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
 		if (val == 0 && val2 == 0) {
@@ -705,23 +711,28 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 			data->data_cfg |= MMA8452_DATA_CFG_HPF_MASK;
 			ret = mma8452_set_hp_filter_frequency(data, val, val2);
 			if (ret < 0)
-				return ret;
+				goto release;
 		}
 
-		return mma8452_change_config(data, MMA8452_DATA_CFG,
+		ret = mma8452_change_config(data, MMA8452_DATA_CFG,
 					     data->data_cfg);
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		ret = mma8452_get_odr_index(data);
 
 		for (i = 0; i < ARRAY_SIZE(mma8452_os_ratio); i++) {
-			if (mma8452_os_ratio[i][ret] == val)
-				return mma8452_set_power_mode(data, i);
+			if (mma8452_os_ratio[i][ret] == val) {
+				ret = mma8452_set_power_mode(data, i);
+				goto release;
+			}
 		}
 
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+release:
+	iio_device_release_direct_mode(indio_dev);
+	return ret;
 }
 
 static int mma8452_read_thresh(struct iio_dev *indio_dev,
-- 
2.1.4

