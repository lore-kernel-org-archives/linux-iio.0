Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58403 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752966AbcJCT1O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2016 15:27:14 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 13/18] staging:iio:accel:sca3000 Drop custom measurement mode attributes
Date: Mon,  3 Oct 2016 20:26:57 +0100
Message-Id: <20161003192702.24361-14-jic23@kernel.org>
In-Reply-To: <20161003192702.24361-1-jic23@kernel.org>
References: <20161003192702.24361-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is now represented by the standard 3db filter frequency controls.
Things get complex wrt to the sampling frequency as these modes change
but that is fine under the IIO ABI where any value is allowed to effect
any other.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/sca3000.c | 139 ------------------------------------
 1 file changed, 139 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000.c b/drivers/staging/iio/accel/sca3000.c
index 7f03f916c9ec..e5cacd263f6d 100644
--- a/drivers/staging/iio/accel/sca3000.c
+++ b/drivers/staging/iio/accel/sca3000.c
@@ -452,143 +452,6 @@ sca3000_show_available_3db_freqs(struct device *dev,
 
 	return len;
 }
-/**
- * sca3000_show_available_measurement_modes() display available modes
- *
- * This is all read from chip specific data in the driver. Not all
- * of the sca3000 series support modes other than normal.
- **/
-static ssize_t
-sca3000_show_available_measurement_modes(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct sca3000_state *st = iio_priv(indio_dev);
-	int len = 0;
-
-	len += sprintf(buf + len, "0 - normal mode");
-	switch (st->info->option_mode_1) {
-	case SCA3000_OP_MODE_NARROW:
-		len += sprintf(buf + len, ", 1 - narrow mode");
-		break;
-	case SCA3000_OP_MODE_BYPASS:
-		len += sprintf(buf + len, ", 1 - bypass mode");
-		break;
-	}
-	switch (st->info->option_mode_2) {
-	case SCA3000_OP_MODE_WIDE:
-		len += sprintf(buf + len, ", 2 - wide mode");
-		break;
-	}
-	/* always supported */
-	len += sprintf(buf + len, " 3 - motion detection\n");
-
-	return len;
-}
-
-/**
- * sca3000_show_measurement_mode() sysfs read of current mode
- **/
-static ssize_t
-sca3000_show_measurement_mode(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct sca3000_state *st = iio_priv(indio_dev);
-	int len = 0, ret;
-
-	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
-	if (ret)
-		goto error_ret;
-	/* mask bottom 2 bits - only ones that are relevant */
-	st->rx[0] &= SCA3000_REG_MODE_MODE_MASK;
-	switch (st->rx[0]) {
-	case SCA3000_REG_MODE_MEAS_MODE_NORMAL:
-		len += sprintf(buf + len, "0 - normal mode\n");
-		break;
-	case SCA3000_REG_MODE_MEAS_MODE_MOT_DET:
-		len += sprintf(buf + len, "3 - motion detection\n");
-		break;
-	case SCA3000_REG_MODE_MEAS_MODE_OP_1:
-		switch (st->info->option_mode_1) {
-		case SCA3000_OP_MODE_NARROW:
-			len += sprintf(buf + len, "1 - narrow mode\n");
-			break;
-		case SCA3000_OP_MODE_BYPASS:
-			len += sprintf(buf + len, "1 - bypass mode\n");
-			break;
-		}
-		break;
-	case SCA3000_REG_MODE_MEAS_MODE_OP_2:
-		switch (st->info->option_mode_2) {
-		case SCA3000_OP_MODE_WIDE:
-			len += sprintf(buf + len, "2 - wide mode\n");
-			break;
-		}
-		break;
-	}
-
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret ? ret : len;
-}
-
-/**
- * sca3000_store_measurement_mode() set the current mode
- **/
-static ssize_t
-sca3000_store_measurement_mode(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf,
-			       size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct sca3000_state *st = iio_priv(indio_dev);
-	int ret;
-	u8 val;
-
-	mutex_lock(&st->lock);
-	ret = kstrtou8(buf, 10, &val);
-	if (ret)
-		goto error_ret;
-	if (val > 3) {
-		ret = -EINVAL;
-		goto error_ret;
-	}
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
-	if (ret)
-		goto error_ret;
-	st->rx[0] &= ~SCA3000_REG_MODE_MODE_MASK;
-	st->rx[0] |= (val & SCA3000_REG_MODE_MODE_MASK);
-	ret = sca3000_write_reg(st, SCA3000_REG_MODE_ADDR, st->rx[0]);
-	if (ret)
-		goto error_ret;
-	mutex_unlock(&st->lock);
-
-	return len;
-
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret;
-}
-
-/*
- * Not even vaguely standard attributes so defined here rather than
- * in the relevant IIO core headers
- */
-static IIO_DEVICE_ATTR(measurement_mode_available, S_IRUGO,
-		       sca3000_show_available_measurement_modes,
-		       NULL, 0);
-
-static IIO_DEVICE_ATTR(measurement_mode, S_IRUGO | S_IWUSR,
-		       sca3000_show_measurement_mode,
-		       sca3000_store_measurement_mode,
-		       0);
 
 static IIO_DEVICE_ATTR(in_accel_filter_low_pass_3db_frequency_available,
 		       S_IRUGO, sca3000_show_available_3db_freqs,
@@ -1058,8 +921,6 @@ static int sca3000_write_event_value(struct iio_dev *indio_dev,
 
 static struct attribute *sca3000_attributes[] = {
 	&iio_dev_attr_revision.dev_attr.attr,
-	&iio_dev_attr_measurement_mode_available.dev_attr.attr,
-	&iio_dev_attr_measurement_mode.dev_attr.attr,
 	&iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	NULL,
-- 
2.10.0

