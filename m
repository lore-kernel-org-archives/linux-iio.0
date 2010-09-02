Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay04-haj2.antispameurope.com ([83.246.65.54]:42285 "EHLO
	relay04-haj2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752057Ab0IBPhx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2010 11:37:53 -0400
Received: from iis.fhg.de (iis.iis.fhg.de [153.96.172.2])
	by relay04-haj2.antispameurope.com (ASE-Secure-MTA) with SMTP id F326D5EC41E
	for <linux-iio@vger.kernel.org>; Thu,  2 Sep 2010 17:37:50 +0200 (CEST)
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
To: linux-iio@vger.kernel.org
Cc: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: [PATCH 2/2] staging:iio:sca3000 change mode ABI to list style
Date: Thu,  2 Sep 2010 17:37:34 +0200
Message-Id: <1283441854-31560-2-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <1283441854-31560-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
References: <1283441854-31560-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
---
 drivers/staging/iio/accel/sca3000_core.c |  125 ++++++++++++++----------------
 1 files changed, 58 insertions(+), 67 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 0eb2c4c..e86c1ca 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -364,39 +364,14 @@ error_ret:
 	return ret ? ret : len;
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
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct sca3000_state *st = dev_info->dev_data;
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
 
-	return len;
+static inline
+ssize_t sca3000_add_item(char *buf, char *name, int enabled)
+{
+	if (enabled)
+		return sprintf(buf, "[%s] ", name);
+	else
+		return sprintf(buf, "%s ", name);
 }
 
 /**
@@ -418,31 +393,24 @@ sca3000_show_measurement_mode(struct device *dev,
 		goto error_ret;
 	/* mask bottom 2 bits - only ones that are relevant */
 	rx[1] &= 0x03;
-	switch (rx[1]) {
-	case SCA3000_MEAS_MODE_NORMAL:
-		len += sprintf(buf + len, "0 - normal mode\n");
-		break;
-	case SCA3000_MEAS_MODE_MOT_DET:
-		len += sprintf(buf + len, "3 - motion detection\n");
+
+	len += sca3000_add_item(buf+len, "normal", rx[1] == SCA3000_MEAS_MODE_NORMAL);
+	switch (st->info->option_mode_1) {
+	case SCA3000_OP_MODE_NARROW:
+		len += sca3000_add_item(buf+len, "narrow", rx[1] == SCA3000_MEAS_MODE_OP_1);
 		break;
-	case SCA3000_MEAS_MODE_OP_1:
-		switch (st->info->option_mode_1) {
-		case SCA3000_OP_MODE_NARROW:
-			len += sprintf(buf + len, "1 - narrow mode\n");
-			break;
-		case SCA3000_OP_MODE_BYPASS:
-			len += sprintf(buf + len, "1 - bypass mode\n");
-			break;
-		}
+	case SCA3000_OP_MODE_BYPASS:
+		len += sca3000_add_item(buf+len, "bypass", rx[1] == SCA3000_MEAS_MODE_OP_1);
 		break;
-	case SCA3000_MEAS_MODE_OP_2:
-		switch (st->info->option_mode_2) {
-		case SCA3000_OP_MODE_WIDE:
-			len += sprintf(buf + len, "2 - wide mode\n");
-			break;
-		}
+	}
+	switch (st->info->option_mode_2) {
+	case SCA3000_OP_MODE_WIDE:
+		len += sca3000_add_item(buf+len, "wide", rx[1] == SCA3000_MEAS_MODE_OP_2);
 		break;
 	}
+	/* always supported */
+	len += sca3000_add_item(buf+len, "motion", rx[1] == SCA3000_MEAS_MODE_MOT_DET);
+	len += sprintf(buf+len, "\n");
 
 error_ret:
 	mutex_unlock(&st->lock);
@@ -461,15 +429,47 @@ sca3000_store_measurement_mode(struct device *dev,
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct sca3000_state *st = dev_info->dev_data;
+	const char *mode;
 	int ret;
 	u8 *rx;
-	int mask = 0x03;
-	long val;
+	int mask = 0x03, val = 0;
 
 	mutex_lock(&st->lock);
-	ret = strict_strtol(buf, 10, &val);
-	if (ret)
-		goto error_ret;
+
+	if (!strncmp(buf, "normal", len)) {
+		val = SCA3000_MEAS_MODE_NORMAL;
+		goto proceed;
+	}
+	switch (st->info->option_mode_1) {
+	case SCA3000_OP_MODE_NARROW:
+		mode = "narrow";
+		break;
+	case SCA3000_OP_MODE_BYPASS:
+		mode = "bypass";
+		break;
+	}
+	if (!strncmp(buf, mode, len)) {
+		val = SCA3000_MEAS_MODE_OP_1;
+		goto proceed;
+	}
+
+	switch (st->info->option_mode_2) {
+	case SCA3000_OP_MODE_WIDE:
+		if (!strncmp(buf, "wide", len)) {
+			val = SCA3000_MEAS_MODE_OP_1;
+			goto proceed;
+		}
+	}
+	/* always supported */
+	if (!strncmp(buf, "motion", len)) {
+		val = SCA3000_MEAS_MODE_MOT_DET;
+		goto proceed;
+	}
+
+	ret = -EINVAL;
+	goto error_ret;
+
+proceed:
 	ret = sca3000_read_data(st, SCA3000_REG_ADDR_MODE, &rx, 1);
 	if (ret)
 		goto error_ret;
@@ -491,13 +491,6 @@ error_ret:
 }
 
 
-/* Not even vaguely standard attributes so defined here rather than
- * in the relevant IIO core headers
- */
-static IIO_DEVICE_ATTR(measurement_mode_available, S_IRUGO,
-		       sca3000_show_available_measurement_modes,
-		       NULL, 0);
-
 static IIO_DEVICE_ATTR(measurement_mode, S_IRUGO | S_IWUSR,
 		       sca3000_show_measurement_mode,
 		       sca3000_store_measurement_mode,
@@ -799,7 +792,6 @@ static struct attribute *sca3000_attributes[] = {
 	&iio_dev_attr_accel_x_raw.dev_attr.attr,
 	&iio_dev_attr_accel_y_raw.dev_attr.attr,
 	&iio_dev_attr_accel_z_raw.dev_attr.attr,
-	&iio_dev_attr_measurement_mode_available.dev_attr.attr,
 	&iio_dev_attr_measurement_mode.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
@@ -813,7 +805,6 @@ static struct attribute *sca3000_attributes_with_temp[] = {
 	&iio_dev_attr_accel_x_raw.dev_attr.attr,
 	&iio_dev_attr_accel_y_raw.dev_attr.attr,
 	&iio_dev_attr_accel_z_raw.dev_attr.attr,
-	&iio_dev_attr_measurement_mode_available.dev_attr.attr,
 	&iio_dev_attr_measurement_mode.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
-- 
1.7.0.6

