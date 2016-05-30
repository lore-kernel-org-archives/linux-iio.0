Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35200 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbcE3CwH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 22:52:07 -0400
Received: by mail-pf0-f194.google.com with SMTP id f144so13754365pfa.2
        for <linux-iio@vger.kernel.org>; Sun, 29 May 2016 19:52:07 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, amsfield22@gmail.com,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: hudmidity: hdc100x: fix incorrect shifting and scaling
Date: Sun, 29 May 2016 19:52:02 -0700
Message-Id: <1464576722-6902-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Shifting sensor data to the right 2 bits was incorrect and caused the
scaling values + offsets to be invalid.

Reported-by: Alison Schofield <amsfield22@gmail.com>
Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/humidity/hdc100x.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 3070983..a03832a 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -164,14 +164,14 @@ static int hdc100x_get_measurement(struct hdc100x_data *data,
 		dev_err(&client->dev, "cannot read high byte measurement");
 		return ret;
 	}
-	val = ret << 6;
+	val = ret << 8;
 
 	ret = i2c_smbus_read_byte(client);
 	if (ret < 0) {
 		dev_err(&client->dev, "cannot read low byte measurement");
 		return ret;
 	}
-	val |= ret >> 2;
+	val |= ret;
 
 	return val;
 }
@@ -212,17 +212,17 @@ static int hdc100x_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		if (chan->type == IIO_TEMP) {
 			*val = 165000;
-			*val2 = 65536 >> 2;
+			*val2 = 65536;
 			return IIO_VAL_FRACTIONAL;
 		} else {
-			*val = 0;
-			*val2 = 10000;
-			return IIO_VAL_INT_PLUS_MICRO;
+			*val = 100;
+			*val2 = 65536;
+			return IIO_VAL_FRACTIONAL;
 		}
 		break;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = -3971;
-		*val2 = 879096;
+		*val = -15887;
+		*val2 = 515151;
 		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
-- 
2.7.4

