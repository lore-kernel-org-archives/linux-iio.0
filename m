Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36869 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728AbbG0XHT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2015 19:07:19 -0400
Received: by wibud3 with SMTP id ud3so135705664wib.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2015 16:07:17 -0700 (PDT)
From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, cory.tusar@pid1solutions.com
Subject: [PATCH v2 4/5] iio: trigger: Add periodic polling to SYSFS trigger
Date: Tue, 28 Jul 2015 02:07:14 +0300
Message-Id: <1438038434-13043-1-git-send-email-vladimir.barinov@cogentembedded.com>
In-Reply-To: <1438038300-12855-1-git-send-email-vladimir.barinov@cogentembedded.com>
References: <1438038300-12855-1-git-send-email-vladimir.barinov@cogentembedded.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add periodic polling functionality to SYSFS trigger

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
---
Changes in version 2:
- initially added

 .../ABI/testing/sysfs-bus-iio-trigger-sysfs        | 11 ++++
 drivers/iio/trigger/iio-trig-sysfs.c               | 58 ++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs b/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
index 5235e6c..49caff2 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
+++ b/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
@@ -9,3 +9,14 @@ Description:
 		automated testing or in situations, where other trigger methods
 		are not applicable. For example no RTC or spare GPIOs.
 		X is the IIO index of the trigger.
+
+What:		/sys/bus/iio/devices/triggerX/trigger_poll
+KernelVersion:	4.2.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This file is provided by the iio-trig-sysfs stand-alone trigger
+		driver. Writing this file with positive value (in milliseconds)
+		will start peroidic event triggereing of the driver, associated
+		with this trigger. Writing this file with 0 will stop perioding
+		triggering.
+		X is the IIO index of the trigger.
diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
index 3dfab2b..ea79311 100644
--- a/drivers/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/iio/trigger/iio-trig-sysfs.c
@@ -18,6 +18,8 @@
 struct iio_sysfs_trig {
 	struct iio_trigger *trig;
 	struct irq_work work;
+	struct delayed_work poll_work;
+	unsigned int poll_interval; /* msec */
 	int id;
 	struct list_head l;
 };
@@ -110,10 +112,63 @@ static ssize_t iio_sysfs_trigger_poll(struct device *dev,
 	return count;
 }
 
+static void iio_sysfs_trigger_queue_poll_work(struct iio_sysfs_trig *trig)
+{
+	unsigned long delay;
+
+	delay = msecs_to_jiffies(trig->poll_interval);
+	if (delay >= HZ)
+		delay = round_jiffies_relative(delay);
+
+	queue_delayed_work(system_freezable_wq, &trig->poll_work, delay);
+}
+
+static void iio_sysfs_trigger_poll_work(struct work_struct *work)
+{
+	struct iio_sysfs_trig *trig = container_of(work, struct iio_sysfs_trig,
+						   poll_work.work);
+
+	irq_work_queue(&trig->work);
+	iio_sysfs_trigger_queue_poll_work(trig);
+}
+
+static ssize_t iio_sysfs_trigger_get_poll(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct iio_trigger *trig = to_iio_trigger(dev);
+	struct iio_sysfs_trig *sysfs_trig = iio_trigger_get_drvdata(trig);
+
+	return sprintf(buf, "%d\n", sysfs_trig->poll_interval);
+}
+
+static ssize_t iio_sysfs_trigger_set_poll(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct iio_trigger *trig = to_iio_trigger(dev);
+	struct iio_sysfs_trig *sysfs_trig = iio_trigger_get_drvdata(trig);
+	unsigned int interval;
+	int err;
+
+	err = kstrtouint(buf, 0, &interval);
+	if (err)
+		return err;
+
+	sysfs_trig->poll_interval = interval;
+
+	cancel_delayed_work_sync(&sysfs_trig->poll_work);
+	if (sysfs_trig->poll_interval > 0)
+		iio_sysfs_trigger_queue_poll_work(sysfs_trig);
+
+	return count;
+}
+
 static DEVICE_ATTR(trigger_now, S_IWUSR, NULL, iio_sysfs_trigger_poll);
+static DEVICE_ATTR(trigger_poll, S_IRUGO | S_IWUSR, iio_sysfs_trigger_get_poll,
+						    iio_sysfs_trigger_set_poll);
 
 static struct attribute *iio_sysfs_trigger_attrs[] = {
 	&dev_attr_trigger_now.attr,
+	&dev_attr_trigger_poll.attr,
 	NULL,
 };
 
@@ -164,6 +219,7 @@ static int iio_sysfs_trigger_probe(int id)
 	iio_trigger_set_drvdata(t->trig, t);
 
 	init_irq_work(&t->work, iio_sysfs_trigger_work);
+	INIT_DELAYED_WORK(&t->poll_work, iio_sysfs_trigger_poll_work);
 
 	ret = iio_trigger_register(t->trig);
 	if (ret)
@@ -198,6 +254,8 @@ static int iio_sysfs_trigger_remove(int id)
 		return -EINVAL;
 	}
 
+	cancel_delayed_work_sync(&t->poll_work);
+
 	iio_trigger_unregister(t->trig);
 	iio_trigger_free(t->trig);
 
-- 
1.9.1

