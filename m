Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36305 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754569AbcHYGpk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Aug 2016 02:45:40 -0400
Received: by mail-pf0-f195.google.com with SMTP id y134so2658488pfg.3
        for <linux-iio@vger.kernel.org>; Wed, 24 Aug 2016 23:45:01 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 4/4] iio: chemical: vz89x: remove mutex and replace with iio_device_*_direct_mode
Date: Wed, 24 Aug 2016 23:44:50 -0700
Message-Id: <1472107490-11924-5-git-send-email-mranostay@gmail.com>
In-Reply-To: <1472107490-11924-1-git-send-email-mranostay@gmail.com>
References: <1472107490-11924-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There is no reason to have a seperate mutex when indio_dev->mlock can
be used with the iio_device_*_direct_mode helpers. Also avoid a race
condition that is possible with multiple IIO_RESISTANCE reads.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/chemical/vz89x.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
index cd3870ead3fd..5e5d4a9abe63 100644
--- a/drivers/iio/chemical/vz89x.c
+++ b/drivers/iio/chemical/vz89x.c
@@ -16,7 +16,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/of.h>
@@ -52,7 +51,6 @@ struct vz89x_chip_data;
 struct vz89x_data {
 	struct i2c_client *client;
 	const struct vz89x_chip_data *chip;
-	struct mutex lock;
 	int (*xfer)(struct vz89x_data *data, u8 cmd);
 
 	bool is_valid;
@@ -277,26 +275,32 @@ static int vz89x_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&data->lock);
-		ret = vz89x_get_measurement(data);
-		mutex_unlock(&data->lock);
-
+		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
 			return ret;
 
+		ret = vz89x_get_measurement(data);
+		if (ret)
+			goto error_out;
+
 		switch (chan->type) {
 		case IIO_CONCENTRATION:
 			*val = data->buffer[chan->address];
-			return IIO_VAL_INT;
+			ret = IIO_VAL_INT;
+			break;
 		case IIO_RESISTANCE:
 			ret = vz89x_get_resistance_reading(data, chan, val);
 			if (!ret)
-				return IIO_VAL_INT;
+				ret = IIO_VAL_INT;
 			break;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
 		}
-		break;
+
+error_out:
+		iio_device_release_direct_mode(indio_dev);
+
+		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_RESISTANCE:
@@ -390,7 +394,6 @@ static int vz89x_probe(struct i2c_client *client,
 	data->client = client;
 	data->chip = &vz89x_chips[chip_id];
 	data->last_update = jiffies - HZ;
-	mutex_init(&data->lock);
 
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &vz89x_info,
-- 
2.7.4

