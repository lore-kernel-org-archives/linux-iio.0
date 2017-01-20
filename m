Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34203 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753464AbdATUss (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Jan 2017 15:48:48 -0500
Date: Fri, 20 Jan 2017 12:39:32 -0800
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: magnetometer: mag3110: claim direct mode during raw
 writes
Message-ID: <20170120203924.GA2196@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Driver was checking for direct mode but not locking it.  Use
claim/release helper functions to guarantee the device stays
in direct mode during raw writes.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
 drivers/iio/magnetometer/mag3110.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index f2b3bd7..b4f643f 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -222,29 +222,39 @@ static int mag3110_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct mag3110_data *data = iio_priv(indio_dev);
-	int rate;
+	int rate, ret;
 
-	if (iio_buffer_enabled(indio_dev))
-		return -EBUSY;
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		rate = mag3110_get_samp_freq_index(data, val, val2);
-		if (rate < 0)
-			return -EINVAL;
+		if (rate < 0) {
+			ret = -EINVAL;
+			break;
+		}
 
 		data->ctrl_reg1 &= ~MAG3110_CTRL_DR_MASK;
 		data->ctrl_reg1 |= rate << MAG3110_CTRL_DR_SHIFT;
-		return i2c_smbus_write_byte_data(data->client,
+		ret = i2c_smbus_write_byte_data(data->client,
 			MAG3110_CTRL_REG1, data->ctrl_reg1);
+		break;
 	case IIO_CHAN_INFO_CALIBBIAS:
-		if (val < -10000 || val > 10000)
-			return -EINVAL;
-		return i2c_smbus_write_word_swapped(data->client,
+		if (val < -10000 || val > 10000) {
+			ret = -EINVAL;
+			break;
+		}
+		ret = i2c_smbus_write_word_swapped(data->client,
 			MAG3110_OFF_X + 2 * chan->scan_index, val << 1);
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		break;
 	}
+	iio_device_release_direct_mode(indio_dev);
+	return ret;
 }
 
 static irqreturn_t mag3110_trigger_handler(int irq, void *p)
-- 
2.1.4

