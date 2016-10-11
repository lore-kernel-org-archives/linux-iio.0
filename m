Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32972 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752376AbcJKT4g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Oct 2016 15:56:36 -0400
Date: Tue, 11 Oct 2016 12:56:27 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: ltr501: claim direct mode during select raw reads
Message-ID: <20161011195620.GA9539@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Driver was checking for direct mode but not locking it.  Use
claim/release helper functions to guarantee the device stays
in direct mode during required raw read cases.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
 drivers/iio/light/ltr501.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 3afc53a..c2ac3cd 100644
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
@@ -648,14 +650,16 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
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
 			mutex_lock(&data->lock_als);
 			ret = ltr501_read_als(data, buf);
 			mutex_unlock(&data->lock_als);
+			iio_device_release_direct_mode(indio_dev);
 			if (ret < 0)
 				return ret;
 			*val = le16_to_cpu(chan->address == LTR501_ALS_DATA1 ?
@@ -665,11 +669,13 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
 			mutex_lock(&data->lock_ps);
 			ret = ltr501_read_ps(data);
 			mutex_unlock(&data->lock_ps);
+			iio_device_release_direct_mode(indio_dev);
 			if (ret < 0)
 				return ret;
 			*val = ret & LTR501_PS_DATA_MASK;
 			return IIO_VAL_INT;
 		default:
+			iio_device_release_direct_mode(indio_dev);
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_SCALE:
-- 
2.1.4

