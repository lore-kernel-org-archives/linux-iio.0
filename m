Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54377 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754804AbcIFK0F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Sep 2016 06:26:05 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Cc: Bryan Freed <bfreed@chromium.org>
Subject: [PATCH] iio: light: acpi-als: Add a tuning parameter interface.
Date: Tue,  6 Sep 2016 12:25:54 +0200
Message-Id: <1473157554-4990-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Bryan Freed <bfreed@chromium.org>

Add IIO_CHAN_INFO_CALIBSCALE to the channel to scale up or down
the raw measurements through the IIO framework.

Add IIO_CHAN_INFO_PROCESSED to provide the interface to read the
scaled measurements through the in_illuminance_input file.

Signed-off-by: Bryan Freed <bfreed@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/iio/light/acpi-als.c | 59 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index f0b47c5..40837bc 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -56,7 +56,8 @@ static const struct iio_chan_spec acpi_als_channels[] = {
 		},
 		/* _RAW is here for backward ABI compatibility */
 		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
-					  BIT(IIO_CHAN_INFO_PROCESSED),
+					  BIT(IIO_CHAN_INFO_PROCESSED) |
+					  BIT(IIO_CHAN_INFO_CALIBSCALE),
 	},
 };
 
@@ -76,6 +77,9 @@ struct acpi_als {
 	struct mutex		lock;
 
 	s32			evt_buffer[ACPI_ALS_EVT_BUFFER_SIZE];
+
+	uint			als_scale;
+	uint			als_uscale;
 };
 
 /*
@@ -154,25 +158,60 @@ static int acpi_als_read_raw(struct iio_dev *indio_dev,
 	s32 temp_val;
 	int ret;
 
-	if ((mask != IIO_CHAN_INFO_PROCESSED) && (mask != IIO_CHAN_INFO_RAW))
-		return -EINVAL;
-
 	/* we support only illumination (_ALI) so far. */
 	if (chan->type != IIO_LIGHT)
 		return -EINVAL;
 
-	ret = acpi_als_read_value(als, ACPI_ALS_ILLUMINANCE, &temp_val);
-	if (ret < 0)
-		return ret;
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = acpi_als_read_value(als, ACPI_ALS_ILLUMINANCE, &temp_val);
+		if (ret < 0)
+			return ret;
+		if (mask == IIO_CHAN_INFO_PROCESSED) {
+			/* use u64 to avoid overflow */
+			u64 ulux = (u64) temp_val * 1000000;
+
+			mutex_lock(&als->lock);
+			ulux = ulux * als->als_scale +
+			       div_u64(ulux * als->als_uscale, 1000000U);
+			mutex_unlock(&als->lock);
+			*val = div_u64(ulux, 1000000U);
+		} else {
+			*val = temp_val;
+		}
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		mutex_lock(&als->lock);
+		*val = als->als_scale;
+		*val2 = als->als_uscale;
+		mutex_unlock(&als->lock);
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
 
-	*val = temp_val;
+static int acpi_als_write_raw(struct iio_dev *iio,
+			      struct iio_chan_spec const *chan, int val,
+			      int val2, long mask)
+{
+	struct acpi_als *als = iio_priv(iio);
+
+	if (mask != IIO_CHAN_INFO_CALIBSCALE || chan->type != IIO_LIGHT)
+		return -EINVAL;
 
-	return IIO_VAL_INT;
+	mutex_lock(&als->lock);
+	als->als_scale = val;
+	als->als_uscale = val2;
+	mutex_unlock(&als->lock);
+	return 0;
 }
 
 static const struct iio_info acpi_als_info = {
 	.driver_module		= THIS_MODULE,
 	.read_raw		= acpi_als_read_raw,
+	.write_raw		= acpi_als_write_raw,
 };
 
 static int acpi_als_add(struct acpi_device *device)
@@ -189,6 +228,8 @@ static int acpi_als_add(struct acpi_device *device)
 
 	device->driver_data = indio_dev;
 	als->device = device;
+	als->als_scale = 1;
+	als->als_uscale = 0;
 	mutex_init(&als->lock);
 
 	indio_dev->name = ACPI_ALS_DEVICE_NAME;
-- 
2.1.0

