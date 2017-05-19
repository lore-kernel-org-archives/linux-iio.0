Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36790 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdESINI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 May 2017 04:13:08 -0400
From: surenderpolsani@gmail.com
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        gregor.boirie@parrot.com
Cc: singhalsimran0@gmail.com, maitysanchayan@gmail.com,
        eraretuya@gmail.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Surender Polsani <surenderpolsani@gmail.com>
Subject: [PATCH v2] staging: iio: light: Replace symbolic permissions as per coding style
Date: Fri, 19 May 2017 13:42:55 +0530
Message-Id: <1495181575-30604-1-git-send-email-surenderpolsani@gmail.com>
In-Reply-To: <20170518090603.GA27644@kroah.com>
References: <20170518090603.GA27644@kroah.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Surender Polsani <surenderpolsani@gmail.com>

Fixed the following checkpatch.pl warnings:
octal permissions are more preferable than symbolic permissions

Replaced DEVICE_ATTR family macros with DEVICE_ATTR_RW family
as suggested by Greg K-H. Changed attributes and function
names where ever required to satisfy internal macro definitions
like __ATTR__RW().

Signed-off-by: Surender Polsani <surenderpolsani@gmail.com>
---
Changes for v2:

- Made few changes as suggested by Greg K-H and modified
  description accordingly.
---
 drivers/staging/iio/light/tsl2x7x_core.c | 94 ++++++++++++++------------------
 1 file changed, 42 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index af3910b..48768bd 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -1140,7 +1140,7 @@ static ssize_t tsl2x7x_prox_persistence_store(struct device *dev,
 	return IIO_VAL_INT_PLUS_MICRO;
 }
 
-static ssize_t tsl2x7x_do_calibrate(struct device *dev,
+static ssize_t tsl2x7x_do_calibrate_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t len)
 {
@@ -1226,7 +1226,7 @@ static ssize_t tsl2x7x_luxtable_store(struct device *dev,
 	return len;
 }
 
-static ssize_t tsl2x7x_do_prox_calibrate(struct device *dev,
+static ssize_t tsl2x7x_do_prox_calibrate_store(struct device *dev,
 					 struct device_attribute *attr,
 					 const char *buf, size_t len)
 {
@@ -1498,35 +1498,25 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR,
-		tsl2x7x_power_state_show, tsl2x7x_power_state_store);
+static DEVICE_ATTR_RW(tsl2x7x_power_state);
 
-static DEVICE_ATTR(in_proximity0_calibscale_available, S_IRUGO,
-		tsl2x7x_prox_gain_available_show, NULL);
+static DEVICE_ATTR_RO(tsl2x7x_prox_gain_available);
 
-static DEVICE_ATTR(in_illuminance0_calibscale_available, S_IRUGO,
-		tsl2x7x_gain_available_show, NULL);
+static DEVICE_ATTR_RO(tsl2x7x_gain_available);
 
-static DEVICE_ATTR(in_illuminance0_integration_time, S_IRUGO | S_IWUSR,
-		tsl2x7x_als_time_show, tsl2x7x_als_time_store);
+static DEVICE_ATTR_RW(tsl2x7x_als_time);
 
-static DEVICE_ATTR(in_illuminance0_target_input, S_IRUGO | S_IWUSR,
-		tsl2x7x_als_cal_target_show, tsl2x7x_als_cal_target_store);
+static DEVICE_ATTR_RW(tsl2x7x_als_cal_target);
 
-static DEVICE_ATTR(in_illuminance0_calibrate, S_IWUSR, NULL,
-		tsl2x7x_do_calibrate);
+static DEVICE_ATTR_WO(tsl2x7x_do_calibrate);
 
-static DEVICE_ATTR(in_proximity0_calibrate, S_IWUSR, NULL,
-		tsl2x7x_do_prox_calibrate);
+static DEVICE_ATTR_WO(tsl2x7x_do_prox_calibrate);
 
-static DEVICE_ATTR(in_illuminance0_lux_table, S_IRUGO | S_IWUSR,
-		tsl2x7x_luxtable_show, tsl2x7x_luxtable_store);
+static DEVICE_ATTR_RW(tsl2x7x_luxtable);
 
-static DEVICE_ATTR(in_intensity0_thresh_period, S_IRUGO | S_IWUSR,
-		tsl2x7x_als_persistence_show, tsl2x7x_als_persistence_store);
+static DEVICE_ATTR_RW(tsl2x7x_als_persistence);
 
-static DEVICE_ATTR(in_proximity0_thresh_period, S_IRUGO | S_IWUSR,
-		tsl2x7x_prox_persistence_show, tsl2x7x_prox_persistence_store);
+static DEVICE_ATTR_RW(tsl2x7x_prox_persistence);
 
 /* Use the default register values to identify the Taos device */
 static int tsl2x7x_device_id(unsigned char *id, int target)
@@ -1594,67 +1584,67 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
 }
 
 static struct attribute *tsl2x7x_ALS_device_attrs[] = {
-	&dev_attr_power_state.attr,
-	&dev_attr_in_illuminance0_calibscale_available.attr,
-	&dev_attr_in_illuminance0_integration_time.attr,
+	&dev_attr_tsl2x7x_power_state.attr,
+	&dev_attr_tsl2x7x_gain_available.attr,
+	&dev_attr_tsl2x7x_als_time.attr,
 	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
-	&dev_attr_in_illuminance0_target_input.attr,
-	&dev_attr_in_illuminance0_calibrate.attr,
-	&dev_attr_in_illuminance0_lux_table.attr,
+	&dev_attr_tsl2x7x_als_cal_target.attr,
+	&dev_attr_tsl2x7x_do_calibrate.attr,
+	&dev_attr_tsl2x7x_luxtable.attr,
 	NULL
 };
 
 static struct attribute *tsl2x7x_PRX_device_attrs[] = {
-	&dev_attr_power_state.attr,
-	&dev_attr_in_proximity0_calibrate.attr,
+	&dev_attr_tsl2x7x_power_state.attr,
+	&dev_attr_tsl2x7x_do_prox_calibrate.attr,
 	NULL
 };
 
 static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
-	&dev_attr_power_state.attr,
-	&dev_attr_in_illuminance0_calibscale_available.attr,
-	&dev_attr_in_illuminance0_integration_time.attr,
+	&dev_attr_tsl2x7x_power_state.attr,
+	&dev_attr_tsl2x7x_gain_available.attr,
+	&dev_attr_tsl2x7x_als_time.attr,
 	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
-	&dev_attr_in_illuminance0_target_input.attr,
-	&dev_attr_in_illuminance0_calibrate.attr,
-	&dev_attr_in_illuminance0_lux_table.attr,
-	&dev_attr_in_proximity0_calibrate.attr,
+	&dev_attr_tsl2x7x_als_cal_target.attr,
+	&dev_attr_tsl2x7x_do_calibrate.attr,
+	&dev_attr_tsl2x7x_luxtable.attr,
+	&dev_attr_tsl2x7x_do_prox_calibrate.attr,
 	NULL
 };
 
 static struct attribute *tsl2x7x_PRX2_device_attrs[] = {
-	&dev_attr_power_state.attr,
-	&dev_attr_in_proximity0_calibrate.attr,
-	&dev_attr_in_proximity0_calibscale_available.attr,
+	&dev_attr_tsl2x7x_power_state.attr,
+	&dev_attr_tsl2x7x_do_prox_calibrate.attr,
+	&dev_attr_tsl2x7x_prox_gain_available.attr,
 	NULL
 };
 
 static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
-	&dev_attr_power_state.attr,
-	&dev_attr_in_illuminance0_calibscale_available.attr,
-	&dev_attr_in_illuminance0_integration_time.attr,
+	&dev_attr_tsl2x7x_power_state.attr,
+	&dev_attr_tsl2x7x_gain_available.attr,
+	&dev_attr_tsl2x7x_als_time.attr,
 	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
-	&dev_attr_in_illuminance0_target_input.attr,
-	&dev_attr_in_illuminance0_calibrate.attr,
-	&dev_attr_in_illuminance0_lux_table.attr,
-	&dev_attr_in_proximity0_calibrate.attr,
-	&dev_attr_in_proximity0_calibscale_available.attr,
+	&dev_attr_tsl2x7x_als_cal_target.attr,
+	&dev_attr_tsl2x7x_do_calibrate.attr,
+	&dev_attr_tsl2x7x_luxtable.attr,
+	&dev_attr_tsl2x7x_do_prox_calibrate.attr,
+	&dev_attr_tsl2x7x_prox_gain_available.attr,
 	NULL
 };
 
 static struct attribute *tsl2X7X_ALS_event_attrs[] = {
-	&dev_attr_in_intensity0_thresh_period.attr,
+	&dev_attr_tsl2x7x_als_persistence.attr,
 	NULL,
 };
 
 static struct attribute *tsl2X7X_PRX_event_attrs[] = {
-	&dev_attr_in_proximity0_thresh_period.attr,
+	&dev_attr_tsl2x7x_prox_persistence.attr,
 	NULL,
 };
 
 static struct attribute *tsl2X7X_ALSPRX_event_attrs[] = {
-	&dev_attr_in_intensity0_thresh_period.attr,
-	&dev_attr_in_proximity0_thresh_period.attr,
+	&dev_attr_tsl2x7x_als_persistence.attr,
+	&dev_attr_tsl2x7x_prox_persistence.attr,
 	NULL,
 };
 
-- 
1.9.1

