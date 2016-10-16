Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36815 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbcJPFA5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2016 01:00:57 -0400
Date: Sat, 15 Oct 2016 22:00:53 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: light: ltr501: claim direct mode during select raw
 reads
Message-ID: <20161016050044.GA15207@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Driver was checking for direct mode but not locking it.  Use
claim/release helper functions to guarantee the device stays
in direct mode during required raw read cases.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
Changes in v2:
 Reworked IIO_CHAN_INFO_RAW case so claim and release are
 executed at same level in the switch statements. (rather
 than claims on top level and releases nested in cases)

 drivers/iio/light/ltr501.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 3afc53a..d577477 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -631,14 +631,16 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
-		if (iio_buffer_enabled(indio_dev))
-			return -EBUSY;
-
 		switch (chan->type) {
 		case IIO_LIGHT:
+			ret = iio_device_claim_direct_mode(indio_dev);
+			if (ret)
+				return ret;
+
 			mutex_lock(&data->lock_als);
 			ret = ltr501_read_als(data, buf);
 			mutex_unlock(&data->lock_als);
+			iio_device_release_direct_mode(indio_dev);
 			if (ret < 0)
 				return ret;
 			*val = ltr501_calculate_lux(le16_to_cpu(buf[1]),
@@ -648,8 +650,9 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_RAW:
-		if (iio_buffer_enabled(indio_dev))
-			return -EBUSY;
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
 
 		switch (chan->type) {
 		case IIO_INTENSITY:
@@ -657,21 +660,28 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
 			ret = ltr501_read_als(data, buf);
 			mutex_unlock(&data->lock_als);
 			if (ret < 0)
-				return ret;
+				break;
 			*val = le16_to_cpu(chan->address == LTR501_ALS_DATA1 ?
 					   buf[0] : buf[1]);
-			return IIO_VAL_INT;
+			ret = IIO_VAL_INT;
+			break;
 		case IIO_PROXIMITY:
 			mutex_lock(&data->lock_ps);
 			ret = ltr501_read_ps(data);
 			mutex_unlock(&data->lock_ps);
 			if (ret < 0)
-				return ret;
+				break;
 			*val = ret & LTR501_PS_DATA_MASK;
-			return IIO_VAL_INT;
+			ret = IIO_VAL_INT;
+			break;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
+			break;
 		}
+
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_INTENSITY:
-- 
2.1.4

