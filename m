Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:56701 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755364Ab0IAOxW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2010 10:53:22 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 6/9] staging:iio: Make use of the convenient IIO_TRIGGER_NAME_ATTR macro
Date: Wed,  1 Sep 2010 15:58:00 +0100
Message-Id: <1283353083-31313-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1283353083-31313-1-git-send-email-jic23@cam.ac.uk>
References: <1283353083-31313-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16209_trigger.c      |    2 +-
 drivers/staging/iio/accel/adis16240_trigger.c      |    2 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c         |    3 ++-
 drivers/staging/iio/gyro/adis16260_trigger.c       |    2 +-
 drivers/staging/iio/imu/adis16300_trigger.c        |    2 +-
 drivers/staging/iio/imu/adis16350_trigger.c        |    2 +-
 drivers/staging/iio/imu/adis16400_trigger.c        |    2 +-
 drivers/staging/iio/trigger/iio-trig-gpio.c        |    2 +-
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    |   12 +-----------
 9 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209_trigger.c b/drivers/staging/iio/accel/adis16209_trigger.c
index 1487eff..d2980dc 100644
--- a/drivers/staging/iio/accel/adis16209_trigger.c
+++ b/drivers/staging/iio/accel/adis16209_trigger.c
@@ -30,7 +30,7 @@ static int adis16209_data_rdy_trig_poll(struct iio_dev *dev_info,
 
 IIO_EVENT_SH(data_rdy_trig, &adis16209_data_rdy_trig_poll);
 
-static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
+static IIO_TRIGGER_NAME_ATTR;
 
 static struct attribute *adis16209_trigger_attrs[] = {
 	&dev_attr_name.attr,
diff --git a/drivers/staging/iio/accel/adis16240_trigger.c b/drivers/staging/iio/accel/adis16240_trigger.c
index 2ba71fd..6cb8681 100644
--- a/drivers/staging/iio/accel/adis16240_trigger.c
+++ b/drivers/staging/iio/accel/adis16240_trigger.c
@@ -30,7 +30,7 @@ static int adis16240_data_rdy_trig_poll(struct iio_dev *dev_info,
 
 IIO_EVENT_SH(data_rdy_trig, &adis16240_data_rdy_trig_poll);
 
-static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
+static IIO_TRIGGER_NAME_ATTR;
 
 static struct attribute *adis16240_trigger_attrs[] = {
 	&dev_attr_name.attr,
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index a68a381..f26c0fe 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -382,7 +382,8 @@ static int lis3l02dq_data_rdy_trigger_set_state(struct iio_trigger *trig,
 				 &t);
 	return ret;
 }
-static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
+
+static IIO_TRIGGER_NAME_ATTR;
 
 static struct attribute *lis3l02dq_trigger_attrs[] = {
 	&dev_attr_name.attr,
diff --git a/drivers/staging/iio/gyro/adis16260_trigger.c b/drivers/staging/iio/gyro/adis16260_trigger.c
index de01537..4a744c1 100644
--- a/drivers/staging/iio/gyro/adis16260_trigger.c
+++ b/drivers/staging/iio/gyro/adis16260_trigger.c
@@ -30,7 +30,7 @@ static int adis16260_data_rdy_trig_poll(struct iio_dev *dev_info,
 
 IIO_EVENT_SH(data_rdy_trig, &adis16260_data_rdy_trig_poll);
 
-static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
+static IIO_TRIGGER_NAME_ATTR;
 
 static struct attribute *adis16260_trigger_attrs[] = {
 	&dev_attr_name.attr,
diff --git a/drivers/staging/iio/imu/adis16300_trigger.c b/drivers/staging/iio/imu/adis16300_trigger.c
index 64036cd..d6677b6 100644
--- a/drivers/staging/iio/imu/adis16300_trigger.c
+++ b/drivers/staging/iio/imu/adis16300_trigger.c
@@ -30,7 +30,7 @@ static int adis16300_data_rdy_trig_poll(struct iio_dev *dev_info,
 
 IIO_EVENT_SH(data_rdy_trig, &adis16300_data_rdy_trig_poll);
 
-static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
+static IIO_TRIGGER_NAME_ATTR;
 
 static struct attribute *adis16300_trigger_attrs[] = {
 	&dev_attr_name.attr,
diff --git a/drivers/staging/iio/imu/adis16350_trigger.c b/drivers/staging/iio/imu/adis16350_trigger.c
index 76edccc..739b7ec 100644
--- a/drivers/staging/iio/imu/adis16350_trigger.c
+++ b/drivers/staging/iio/imu/adis16350_trigger.c
@@ -30,7 +30,7 @@ static int adis16350_data_rdy_trig_poll(struct iio_dev *dev_info,
 
 IIO_EVENT_SH(data_rdy_trig, &adis16350_data_rdy_trig_poll);
 
-static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
+static IIO_TRIGGER_NAME_ATTR;
 
 static struct attribute *adis16350_trigger_attrs[] = {
 	&dev_attr_name.attr,
diff --git a/drivers/staging/iio/imu/adis16400_trigger.c b/drivers/staging/iio/imu/adis16400_trigger.c
index aafe601..36b5ff5 100644
--- a/drivers/staging/iio/imu/adis16400_trigger.c
+++ b/drivers/staging/iio/imu/adis16400_trigger.c
@@ -30,7 +30,7 @@ static int adis16400_data_rdy_trig_poll(struct iio_dev *dev_info,
 
 IIO_EVENT_SH(data_rdy_trig, &adis16400_data_rdy_trig_poll);
 
-static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
+static IIO_TRIGGER_NAME_ATTR;
 
 static struct attribute *adis16400_trigger_attrs[] = {
 	&dev_attr_name.attr,
diff --git a/drivers/staging/iio/trigger/iio-trig-gpio.c b/drivers/staging/iio/trigger/iio-trig-gpio.c
index f93cc91..2ce95e9 100644
--- a/drivers/staging/iio/trigger/iio-trig-gpio.c
+++ b/drivers/staging/iio/trigger/iio-trig-gpio.c
@@ -47,7 +47,7 @@ static irqreturn_t iio_gpio_trigger_poll(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
+static IIO_TRIGGER_NAME_ATTR;
 
 static struct attribute *iio_gpio_trigger_attrs[] = {
 	&dev_attr_name.attr,
diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
index b0b52f8..24f174e 100644
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -72,17 +72,7 @@ error_ret:
 	return ret;
 }
 
-static ssize_t iio_trig_periodic_read_name(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
-{
-	struct iio_trigger *trig = dev_get_drvdata(dev);
-	return sprintf(buf, "%s\n", trig->name);
-}
-
-static DEVICE_ATTR(name, S_IRUGO,
-	    iio_trig_periodic_read_name,
-	    NULL);
+static IIO_TRIGGER_NAME_ATTR;
 static DEVICE_ATTR(frequency, S_IRUGO | S_IWUSR,
 	    iio_trig_periodic_read_freq,
 	    iio_trig_periodic_write_freq);
-- 
1.7.1

