Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33373 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752388AbcJKTuo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Oct 2016 15:50:44 -0400
Date: Tue, 11 Oct 2016 12:33:12 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: pressure: mpl3115: claim direct mode during raw reads
Message-ID: <20161011193306.GA8724@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Driver was checking for direct mode but not locking it.  Use
claim/release helper functions to guarantee the device stays
in direct mode during raw reads.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
 drivers/iio/pressure/mpl3115.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 6392d7b..fb36f7d 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -82,8 +82,9 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (iio_buffer_enabled(indio_dev))
-			return -EBUSY;
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
 
 		switch (chan->type) {
 		case IIO_PRESSURE: /* in 0.25 pascal / LSB */
@@ -91,31 +92,35 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
 			ret = mpl3115_request(data);
 			if (ret < 0) {
 				mutex_unlock(&data->lock);
-				return ret;
+				goto release;
 			}
 			ret = i2c_smbus_read_i2c_block_data(data->client,
 				MPL3115_OUT_PRESS, 3, (u8 *) &tmp);
 			mutex_unlock(&data->lock);
 			if (ret < 0)
-				return ret;
+				goto release;
 			*val = be32_to_cpu(tmp) >> 12;
-			return IIO_VAL_INT;
+			ret = IIO_VAL_INT;
 		case IIO_TEMP: /* in 0.0625 celsius / LSB */
 			mutex_lock(&data->lock);
 			ret = mpl3115_request(data);
 			if (ret < 0) {
 				mutex_unlock(&data->lock);
-				return ret;
+				goto release;
 			}
 			ret = i2c_smbus_read_i2c_block_data(data->client,
 				MPL3115_OUT_TEMP, 2, (u8 *) &tmp);
 			mutex_unlock(&data->lock);
 			if (ret < 0)
-				return ret;
+				goto release;
 			*val = sign_extend32(be32_to_cpu(tmp) >> 20, 11);
-			return IIO_VAL_INT;
+			ret = IIO_VAL_INT;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
+
+release:
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
 		}
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
-- 
2.1.4

