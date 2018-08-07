Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44251 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeHGWTp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Aug 2018 18:19:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so8321527pgp.11
        for <linux-iio@vger.kernel.org>; Tue, 07 Aug 2018 13:03:44 -0700 (PDT)
From: David Frey <dpfrey@gmail.com>
To: linux-iio@vger.kernel.org, himanshujha199640@gmail.com
Cc: David Frey <dpfrey@gmail.com>
Subject: [PATCH 2/2] iio: bme680: simplify oversampling handling
Date: Tue,  7 Aug 2018 13:07:21 -0700
Message-Id: <20180807200721.22033-3-dpfrey@gmail.com>
In-Reply-To: <20180807200721.22033-1-dpfrey@gmail.com>
References: <20180807200721.22033-1-dpfrey@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Temperature, pressure and humidity all expose and oversampling setting
that works in the same way.  Provide common handling for the
oversampling sysfs attributes.

Signed-off-by: David Frey <dpfrey@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 65 +++++++++++---------------------------
 1 file changed, 19 insertions(+), 46 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 0e79d03ecc40..446cf1cbef23 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -91,8 +91,6 @@ static const struct iio_chan_spec bme680_channels[] = {
 	},
 };
 
-static const int bme680_oversampling_avail[] = { 1, 2, 4, 8, 16 };
-
 static int bme680_read_calib(struct bme680_data *data,
 			     struct bme680_calib *calib)
 {
@@ -783,49 +781,14 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
-static int bme680_write_oversampling_ratio_temp(struct bme680_data *data,
-						int val)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(bme680_oversampling_avail); i++) {
-		if (bme680_oversampling_avail[i] == val) {
-			data->oversampling_temp = ilog2(val);
-
-			return bme680_chip_config(data);
-		}
-	}
-
-	return -EINVAL;
-}
-
-static int bme680_write_oversampling_ratio_press(struct bme680_data *data,
-						 int val)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(bme680_oversampling_avail); i++) {
-		if (bme680_oversampling_avail[i] == val) {
-			data->oversampling_press = ilog2(val);
-
-			return bme680_chip_config(data);
-		}
-	}
-
-	return -EINVAL;
-}
-
-static int bme680_write_oversampling_ratio_humid(struct bme680_data *data,
-						 int val)
+static int bme680_oversampling_value_to_setting(int value)
 {
 	int i;
-
-	for (i = 0; i < ARRAY_SIZE(bme680_oversampling_avail); i++) {
-		if (bme680_oversampling_avail[i] == val) {
-			data->oversampling_humid = ilog2(val);
-
-			return bme680_chip_config(data);
-		}
+	/* valid values are 2^n where n >=0 && n <= 4 */
+	for (i = 0; i <= 4; i++) {
+		u8 setting = (1 << i);
+		if (setting == value)
+			return setting;
 	}
 
 	return -EINVAL;
@@ -839,16 +802,26 @@ static int bme680_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+	{
+		int os_setting = bme680_oversampling_value_to_setting(val);
+		if (os_setting < 0)
+			return -EINVAL;
+
 		switch (chan->type) {
 		case IIO_TEMP:
-			return bme680_write_oversampling_ratio_temp(data, val);
+			data->oversampling_temp = os_setting;
+			break;
 		case IIO_PRESSURE:
-			return bme680_write_oversampling_ratio_press(data, val);
+			data->oversampling_press = os_setting;
+			break;
 		case IIO_HUMIDITYRELATIVE:
-			return bme680_write_oversampling_ratio_humid(data, val);
+			data->oversampling_humid = os_setting;
+			break;
 		default:
 			return -EINVAL;
 		}
+		return bme680_chip_config(data);
+	}
 	default:
 		return -EINVAL;
 	}
-- 
2.11.0

