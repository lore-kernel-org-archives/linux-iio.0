Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35361 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752338AbcHSKfF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Aug 2016 06:35:05 -0400
Date: Thu, 18 Aug 2016 09:09:00 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: magnetometer: mag3110: claim direct mode during raw
 reads
Message-ID: <20160818160849.GA21203@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Driver was checking for direct mode but not locking it.  Use
claim/release helper functions to guarantee the device stays
in direct mode during raw reads.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
Changes in v2:
 added breaks in switch to prevent fall through

 drivers/iio/magnetometer/mag3110.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index f2be4a0..f2b3bd7 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -154,34 +154,41 @@ static int mag3110_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (iio_buffer_enabled(indio_dev))
-			return -EBUSY;
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
 
 		switch (chan->type) {
 		case IIO_MAGN: /* in 0.1 uT / LSB */
 			ret = mag3110_read(data, buffer);
 			if (ret < 0)
-				return ret;
+				goto release;
 			*val = sign_extend32(
 				be16_to_cpu(buffer[chan->scan_index]), 15);
-			return IIO_VAL_INT;
+			ret = IIO_VAL_INT;
+			break;
 		case IIO_TEMP: /* in 1 C / LSB */
 			mutex_lock(&data->lock);
 			ret = mag3110_request(data);
 			if (ret < 0) {
 				mutex_unlock(&data->lock);
-				return ret;
+				goto release;
 			}
 			ret = i2c_smbus_read_byte_data(data->client,
 				MAG3110_DIE_TEMP);
 			mutex_unlock(&data->lock);
 			if (ret < 0)
-				return ret;
+				goto release;
 			*val = sign_extend32(ret, 7);
-			return IIO_VAL_INT;
+			ret = IIO_VAL_INT;
+			break;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
 		}
+release:
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_MAGN:
-- 
2.1.4

