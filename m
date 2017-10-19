Return-Path: <SRS0=14rJ=BS=onstation.org=masneyb@kernel.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 01/13] staging: iio: tsl2x7x: migrate *_thresh_period sysfs attributes to iio_event_spec
Date: Thu, 19 Oct 2017 16:06:20 -0400
Message-Id: <20171019200632.25820-2-masneyb@onstation.org>
In-Reply-To: <20171019200632.25820-1-masneyb@onstation.org>
References: <20171019200632.25820-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

The sysfs attributes in_intensity0_thresh_period and
in_proximity0_thresh_period are currently directly created by the driver.
This patch migrates the creation of these sysfs attributes from the driver
to using the IIO core via iio_event_spec.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
Changes since v1:
- Use IIO_EV_DIR_EITHER instead of IIO_EV_DIR_NONE

 drivers/staging/iio/light/tsl2x7x.c | 196 ++++++++++--------------------------
 1 file changed, 52 insertions(+), 144 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index e6a71f5fc9cb..2dd8c502fd7a 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -932,108 +932,6 @@ static ssize_t in_illuminance0_target_input_store(struct device *dev,
 	return len;
 }
 
-/* persistence settings */
-static ssize_t in_intensity0_thresh_period_show(struct device *dev,
-					    struct device_attribute *attr,
-					    char *buf)
-{
-	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
-	int y, z, filter_delay;
-
-	/* Determine integration time */
-	y = (TSL2X7X_MAX_TIMER_CNT - (u8)chip->settings.als_time) + 1;
-	z = y * TSL2X7X_MIN_ITIME;
-	filter_delay = z * (chip->settings.persistence & 0x0F);
-	y = filter_delay / 1000;
-	z = filter_delay % 1000;
-
-	return snprintf(buf, PAGE_SIZE, "%d.%03d\n", y, z);
-}
-
-static ssize_t in_intensity0_thresh_period_store(struct device *dev,
-					     struct device_attribute *attr,
-					     const char *buf, size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	struct tsl2x7x_parse_result result;
-	int y, z, filter_delay;
-	int ret;
-
-	ret = iio_str_to_fixpoint(buf, 100, &result.integer, &result.fract);
-	if (ret)
-		return ret;
-
-	y = (TSL2X7X_MAX_TIMER_CNT - (u8)chip->settings.als_time) + 1;
-	z = y * TSL2X7X_MIN_ITIME;
-
-	filter_delay =
-		DIV_ROUND_UP((result.integer * 1000) + result.fract, z);
-
-	chip->settings.persistence &= 0xF0;
-	chip->settings.persistence |= (filter_delay & 0x0F);
-
-	dev_info(&chip->client->dev, "%s: als persistence = %d",
-		 __func__, filter_delay);
-
-	ret = tsl2x7x_invoke_change(indio_dev);
-	if (ret < 0)
-		return ret;
-
-	return IIO_VAL_INT_PLUS_MICRO;
-}
-
-static ssize_t in_proximity0_thresh_period_show(struct device *dev,
-					     struct device_attribute *attr,
-					     char *buf)
-{
-	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
-	int y, z, filter_delay;
-
-	/* Determine integration time */
-	y = (TSL2X7X_MAX_TIMER_CNT - (u8)chip->settings.prx_time) + 1;
-	z = y * TSL2X7X_MIN_ITIME;
-	filter_delay = z * ((chip->settings.persistence & 0xF0) >> 4);
-	y = filter_delay / 1000;
-	z = filter_delay % 1000;
-
-	return snprintf(buf, PAGE_SIZE, "%d.%03d\n", y, z);
-}
-
-static ssize_t in_proximity0_thresh_period_store(struct device *dev,
-					      struct device_attribute *attr,
-					      const char *buf, size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	struct tsl2x7x_parse_result result;
-	int y, z, filter_delay;
-	int ret;
-
-	ret = iio_str_to_fixpoint(buf, 100, &result.integer, &result.fract);
-	if (ret)
-		return ret;
-
-	y = (TSL2X7X_MAX_TIMER_CNT - (u8)chip->settings.prx_time) + 1;
-	z = y * TSL2X7X_MIN_ITIME;
-
-	filter_delay =
-		DIV_ROUND_UP((result.integer * 1000) + result.fract, z);
-
-	chip->settings.persistence &= 0x0F;
-	chip->settings.persistence |= ((filter_delay << 4) & 0xF0);
-
-	dev_info(&chip->client->dev, "%s: prox persistence = %d",
-		 __func__, filter_delay);
-
-	ret = tsl2x7x_invoke_change(indio_dev);
-	if (ret < 0)
-		return ret;
-
-
-	return IIO_VAL_INT_PLUS_MICRO;
-}
-
 static ssize_t in_illuminance0_calibrate_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t len)
@@ -1198,7 +1096,8 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
 				     int val, int val2)
 {
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	int ret = -EINVAL;
+	int ret = -EINVAL, y, z, filter_delay;
+	u8 time;
 
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
@@ -1230,6 +1129,33 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
 			}
 		}
 		break;
+	case IIO_EV_INFO_PERIOD:
+		if (chan->type == IIO_INTENSITY)
+			time = chip->settings.als_time;
+		else
+			time = chip->settings.prx_time;
+
+		y = (TSL2X7X_MAX_TIMER_CNT - time) + 1;
+		z = y * TSL2X7X_MIN_ITIME;
+
+		filter_delay = DIV_ROUND_UP((val * 1000) + val2, z);
+
+		if (chan->type == IIO_INTENSITY) {
+			chip->settings.persistence &= 0xF0;
+			chip->settings.persistence |=
+				(filter_delay & 0x0F);
+			dev_info(&chip->client->dev, "%s: ALS persistence = %d",
+				 __func__, filter_delay);
+		} else {
+			chip->settings.persistence &= 0x0F;
+			chip->settings.persistence |=
+				((filter_delay << 4) & 0xF0);
+			dev_info(&chip->client->dev,
+				 "%s: Proximity persistence = %d",
+				 __func__, filter_delay);
+		}
+		ret = 0;
+		break;
 	default:
 		break;
 	}
@@ -1248,7 +1174,8 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
 				    int *val, int *val2)
 {
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	int ret = -EINVAL;
+	int ret = -EINVAL, filter_delay, mult;
+	u8 time;
 
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
@@ -1280,6 +1207,23 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
 			}
 		}
 		break;
+	case IIO_EV_INFO_PERIOD:
+		if (chan->type == IIO_INTENSITY) {
+			time = chip->settings.als_time;
+			mult = chip->settings.persistence & 0x0F;
+		} else {
+			time = chip->settings.prx_time;
+			mult = (chip->settings.persistence & 0xF0) >> 4;
+		}
+
+		/* Determine integration time */
+		*val = (TSL2X7X_MAX_TIMER_CNT - time) + 1;
+		*val2 = *val * TSL2X7X_MIN_ITIME;
+		filter_delay = *val2 * mult;
+		*val = filter_delay / 1000;
+		*val2 = filter_delay % 1000;
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
 	default:
 		break;
 	}
@@ -1444,10 +1388,6 @@ static DEVICE_ATTR_WO(in_proximity0_calibrate);
 
 static DEVICE_ATTR_RW(in_illuminance0_lux_table);
 
-static DEVICE_ATTR_RW(in_intensity0_thresh_period);
-
-static DEVICE_ATTR_RW(in_proximity0_thresh_period);
-
 /* Use the default register values to identify the Taos device */
 static int tsl2x7x_device_id(int *id, int target)
 {
@@ -1554,22 +1494,6 @@ static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
 	NULL
 };
 
-static struct attribute *tsl2X7X_ALS_event_attrs[] = {
-	&dev_attr_in_intensity0_thresh_period.attr,
-	NULL,
-};
-
-static struct attribute *tsl2X7X_PRX_event_attrs[] = {
-	&dev_attr_in_proximity0_thresh_period.attr,
-	NULL,
-};
-
-static struct attribute *tsl2X7X_ALSPRX_event_attrs[] = {
-	&dev_attr_in_intensity0_thresh_period.attr,
-	&dev_attr_in_proximity0_thresh_period.attr,
-	NULL,
-};
-
 static const struct attribute_group tsl2X7X_device_attr_group_tbl[] = {
 	[ALS] = {
 		.attrs = tsl2x7x_ALS_device_attrs,
@@ -1588,25 +1512,9 @@ static const struct attribute_group tsl2X7X_device_attr_group_tbl[] = {
 	},
 };
 
-static const struct attribute_group tsl2X7X_event_attr_group_tbl[] = {
-	[ALS] = {
-		.attrs = tsl2X7X_ALS_event_attrs,
-		.name = "events",
-	},
-	[PRX] = {
-		.attrs = tsl2X7X_PRX_event_attrs,
-		.name = "events",
-	},
-	[ALSPRX] = {
-		.attrs = tsl2X7X_ALSPRX_event_attrs,
-		.name = "events",
-	},
-};
-
 static const struct iio_info tsl2X7X_device_info[] = {
 	[ALS] = {
 		.attrs = &tsl2X7X_device_attr_group_tbl[ALS],
-		.event_attrs = &tsl2X7X_event_attr_group_tbl[ALS],
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
 		.read_event_value = &tsl2x7x_read_event_value,
@@ -1616,7 +1524,6 @@ static const struct iio_info tsl2X7X_device_info[] = {
 	},
 	[PRX] = {
 		.attrs = &tsl2X7X_device_attr_group_tbl[PRX],
-		.event_attrs = &tsl2X7X_event_attr_group_tbl[PRX],
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
 		.read_event_value = &tsl2x7x_read_event_value,
@@ -1626,7 +1533,6 @@ static const struct iio_info tsl2X7X_device_info[] = {
 	},
 	[ALSPRX] = {
 		.attrs = &tsl2X7X_device_attr_group_tbl[ALSPRX],
-		.event_attrs = &tsl2X7X_event_attr_group_tbl[ALSPRX],
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
 		.read_event_value = &tsl2x7x_read_event_value,
@@ -1636,7 +1542,6 @@ static const struct iio_info tsl2X7X_device_info[] = {
 	},
 	[PRX2] = {
 		.attrs = &tsl2X7X_device_attr_group_tbl[PRX2],
-		.event_attrs = &tsl2X7X_event_attr_group_tbl[PRX],
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
 		.read_event_value = &tsl2x7x_read_event_value,
@@ -1646,7 +1551,6 @@ static const struct iio_info tsl2X7X_device_info[] = {
 	},
 	[ALSPRX2] = {
 		.attrs = &tsl2X7X_device_attr_group_tbl[ALSPRX2],
-		.event_attrs = &tsl2X7X_event_attr_group_tbl[ALSPRX],
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
 		.read_event_value = &tsl2x7x_read_event_value,
@@ -1667,6 +1571,10 @@ static const struct iio_event_spec tsl2x7x_events[] = {
 		.dir = IIO_EV_DIR_FALLING,
 		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
 			BIT(IIO_EV_INFO_ENABLE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_PERIOD),
 	},
 };
 
-- 
2.13.6
