Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-134.synserver.de ([212.40.185.134]:1055 "EHLO
	smtp-out-133.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751646Ab2FRQmk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jun 2012 12:42:40 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] staging:iio:trigger: Use to_iio_trigger() instead of dev_get_drvdata()
Date: Mon, 18 Jun 2012 18:46:17 +0200
Message-Id: <1340037978-16915-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use to_iio_trigger(dev) instead of dev_get_drvdata(dev). Both will return the
trigger which belongs to the device, but the the first on is a bit more
lightweight. Also this will eventually free up the drvdata pointer of the device
for driver specific data.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c   |    4 ++--
 drivers/staging/iio/trigger/iio-trig-periodic-rtc.c |    4 ++--
 drivers/staging/iio/trigger/iio-trig-sysfs.c        |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index f85734d..ce6a7b1 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -60,7 +60,7 @@ struct bfin_tmr_state {
 static ssize_t iio_bfin_tmr_frequency_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct iio_trigger *trig = dev_get_drvdata(dev);
+	struct iio_trigger *trig = to_iio_trigger(dev);
 	struct bfin_tmr_state *st = trig->private_data;
 	long val;
 	int ret;
@@ -97,7 +97,7 @@ static ssize_t iio_bfin_tmr_frequency_show(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
 {
-	struct iio_trigger *trig = dev_get_drvdata(dev);
+	struct iio_trigger *trig = to_iio_trigger(dev);
 	struct bfin_tmr_state *st = trig->private_data;
 
 	return sprintf(buf, "%lu\n",
diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
index 9f2d055..4ceaa18 100644
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -41,7 +41,7 @@ static ssize_t iio_trig_periodic_read_freq(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
 {
-	struct iio_trigger *trig = dev_get_drvdata(dev);
+	struct iio_trigger *trig = to_iio_trigger(dev);
 	struct iio_prtc_trigger_info *trig_info = trig->private_data;
 	return sprintf(buf, "%u\n", trig_info->frequency);
 }
@@ -51,7 +51,7 @@ static ssize_t iio_trig_periodic_write_freq(struct device *dev,
 					    const char *buf,
 					    size_t len)
 {
-	struct iio_trigger *trig = dev_get_drvdata(dev);
+	struct iio_trigger *trig = to_iio_trigger(dev);
 	struct iio_prtc_trigger_info *trig_info = trig->private_data;
 	unsigned long val;
 	int ret;
diff --git a/drivers/staging/iio/trigger/iio-trig-sysfs.c b/drivers/staging/iio/trigger/iio-trig-sysfs.c
index 552763b..fee4746 100644
--- a/drivers/staging/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/staging/iio/trigger/iio-trig-sysfs.c
@@ -92,7 +92,7 @@ static struct device iio_sysfs_trig_dev = {
 static ssize_t iio_sysfs_trigger_poll(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct iio_trigger *trig = dev_get_drvdata(dev);
+	struct iio_trigger *trig = to_iio_trigger(dev);
 	iio_trigger_poll_chained(trig, 0);
 
 	return count;
-- 
1.7.10

