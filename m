Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:58538 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752790AbdGFW4i (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Jul 2017 18:56:38 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v2 6/9] staging: iio: tsl2x7x: refactor {read,write}_event_value to allow handling multiple iio_event_infos
Date: Thu,  6 Jul 2017 18:56:23 -0400
Message-Id: <20170706225626.6716-7-masneyb@onstation.org>
In-Reply-To: <20170706225626.6716-1-masneyb@onstation.org>
References: <20170706225626.6716-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

tsl2x7x_read_thresh() and tsl2x7x_write_thresh() currently assumes
that IIO_EV_INFO_VALUE is the only iio_event_info that will be
passed in.  This patch refactors these two functions so that
additional iio_event_infos can be passed in. The functions are
renamed from tsl2x7x_{read,write}_thresh() to
tsl2x7x_{read,write}_event_value(). This patch also adds the
missing return value check to tsl2x7x_invoke_change() since this
was previously missing. This patch is in preparation for moving
the in_intensity0_thresh_period and in_proximity0_thresh_period sysfs
attributes to be created by iio_event_spec.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 157 +++++++++++++++++++++---------------
 1 file changed, 90 insertions(+), 67 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 5734628..d80f5dc 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -1218,78 +1218,101 @@ static int tsl2x7x_write_interrupt_config(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static int tsl2x7x_write_thresh(struct iio_dev *indio_dev,
-				const struct iio_chan_spec *chan,
-				enum iio_event_type type,
-				enum iio_event_direction dir,
-				enum iio_event_info info,
-				int val, int val2)
+static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info,
+				     int val, int val2)
 {
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
+	int ret = -EINVAL;
 
-	if (chan->type == IIO_INTENSITY) {
-		switch (dir) {
-		case IIO_EV_DIR_RISING:
-			chip->tsl2x7x_settings.als_thresh_high = val;
-			break;
-		case IIO_EV_DIR_FALLING:
-			chip->tsl2x7x_settings.als_thresh_low = val;
-			break;
-		default:
-			return -EINVAL;
-		}
-	} else {
-		switch (dir) {
-		case IIO_EV_DIR_RISING:
-			chip->tsl2x7x_settings.prox_thres_high = val;
-			break;
-		case IIO_EV_DIR_FALLING:
-			chip->tsl2x7x_settings.prox_thres_low = val;
-			break;
-		default:
-			return -EINVAL;
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		if (chan->type == IIO_INTENSITY) {
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				chip->tsl2x7x_settings.als_thresh_high = val;
+				ret = 0;
+				break;
+			case IIO_EV_DIR_FALLING:
+				chip->tsl2x7x_settings.als_thresh_low = val;
+				ret = 0;
+				break;
+			default:
+				break;
+			}
+		} else {
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				chip->tsl2x7x_settings.prox_thres_high = val;
+				ret = 0;
+				break;
+			case IIO_EV_DIR_FALLING:
+				chip->tsl2x7x_settings.prox_thres_low = val;
+				ret = 0;
+				break;
+			default:
+				break;
+			}
 		}
+		break;
+	default:
+		break;
 	}
 
-	tsl2x7x_invoke_change(indio_dev);
+	if (ret < 0)
+		return ret;
 
-	return 0;
+	return tsl2x7x_invoke_change(indio_dev);
 }
 
-static int tsl2x7x_read_thresh(struct iio_dev *indio_dev,
-			       const struct iio_chan_spec *chan,
-			       enum iio_event_type type,
-			       enum iio_event_direction dir,
-				   enum iio_event_info info,
-			       int *val, int *val2)
+static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int *val, int *val2)
 {
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
+	int ret = -EINVAL;
 
-	if (chan->type == IIO_INTENSITY) {
-		switch (dir) {
-		case IIO_EV_DIR_RISING:
-			*val = chip->tsl2x7x_settings.als_thresh_high;
-			break;
-		case IIO_EV_DIR_FALLING:
-			*val = chip->tsl2x7x_settings.als_thresh_low;
-			break;
-		default:
-			return -EINVAL;
-		}
-	} else {
-		switch (dir) {
-		case IIO_EV_DIR_RISING:
-			*val = chip->tsl2x7x_settings.prox_thres_high;
-			break;
-		case IIO_EV_DIR_FALLING:
-			*val = chip->tsl2x7x_settings.prox_thres_low;
-			break;
-		default:
-			return -EINVAL;
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		if (chan->type == IIO_INTENSITY) {
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				*val = chip->tsl2x7x_settings.als_thresh_high;
+				ret = IIO_VAL_INT;
+				break;
+			case IIO_EV_DIR_FALLING:
+				*val = chip->tsl2x7x_settings.als_thresh_low;
+				ret = IIO_VAL_INT;
+				break;
+			default:
+				break;
+			}
+		} else {
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				*val = chip->tsl2x7x_settings.prox_thres_high;
+				ret = IIO_VAL_INT;
+				break;
+			case IIO_EV_DIR_FALLING:
+				*val = chip->tsl2x7x_settings.prox_thres_low;
+				ret = IIO_VAL_INT;
+				break;
+			default:
+				break;
+			}
 		}
+		break;
+	default:
+		break;
 	}
 
-	return IIO_VAL_INT;
+	return ret;
 }
 
 static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
@@ -1614,8 +1637,8 @@ static const struct iio_info tsl2X7X_device_info[] = {
 		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
-		.read_event_value = &tsl2x7x_read_thresh,
-		.write_event_value = &tsl2x7x_write_thresh,
+		.read_event_value = &tsl2x7x_read_event_value,
+		.write_event_value = &tsl2x7x_write_event_value,
 		.read_event_config = &tsl2x7x_read_interrupt_config,
 		.write_event_config = &tsl2x7x_write_interrupt_config,
 	},
@@ -1625,8 +1648,8 @@ static const struct iio_info tsl2X7X_device_info[] = {
 		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
-		.read_event_value = &tsl2x7x_read_thresh,
-		.write_event_value = &tsl2x7x_write_thresh,
+		.read_event_value = &tsl2x7x_read_event_value,
+		.write_event_value = &tsl2x7x_write_event_value,
 		.read_event_config = &tsl2x7x_read_interrupt_config,
 		.write_event_config = &tsl2x7x_write_interrupt_config,
 	},
@@ -1636,8 +1659,8 @@ static const struct iio_info tsl2X7X_device_info[] = {
 		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
-		.read_event_value = &tsl2x7x_read_thresh,
-		.write_event_value = &tsl2x7x_write_thresh,
+		.read_event_value = &tsl2x7x_read_event_value,
+		.write_event_value = &tsl2x7x_write_event_value,
 		.read_event_config = &tsl2x7x_read_interrupt_config,
 		.write_event_config = &tsl2x7x_write_interrupt_config,
 	},
@@ -1647,8 +1670,8 @@ static const struct iio_info tsl2X7X_device_info[] = {
 		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
-		.read_event_value = &tsl2x7x_read_thresh,
-		.write_event_value = &tsl2x7x_write_thresh,
+		.read_event_value = &tsl2x7x_read_event_value,
+		.write_event_value = &tsl2x7x_write_event_value,
 		.read_event_config = &tsl2x7x_read_interrupt_config,
 		.write_event_config = &tsl2x7x_write_interrupt_config,
 	},
@@ -1658,8 +1681,8 @@ static const struct iio_info tsl2X7X_device_info[] = {
 		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
-		.read_event_value = &tsl2x7x_read_thresh,
-		.write_event_value = &tsl2x7x_write_thresh,
+		.read_event_value = &tsl2x7x_read_event_value,
+		.write_event_value = &tsl2x7x_write_event_value,
 		.read_event_config = &tsl2x7x_read_interrupt_config,
 		.write_event_config = &tsl2x7x_write_interrupt_config,
 	},
-- 
2.9.4

