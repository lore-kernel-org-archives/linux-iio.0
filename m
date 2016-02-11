Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30848 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbcBKKFP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 11 Feb 2016 05:05:15 -0500
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>,
	Gregor Boirie <gregor.boirie@parrot.com>
Subject: [RFC PATCH v1 1/3] iio:core: timestamping clock selection support
Date: Thu, 11 Feb 2016 11:04:50 +0100
Message-ID: <3e2d224ccd59ecba141e1320e804c674eb61c686.1455184829.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1455184829.git.gregor.boirie@parrot.com>
References: <cover.1455184829.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Adds a new per-device sysfs attribute "clockid" to allow userspace to select a
particular POSIX clock for buffered samples and events timestamping.

When read, the attribute file returns a stringifi'ed clockid_t matching the
currently selected clock.
Writing a stringifi'ed clockid_t to the attribute file will select the
corresponding clock for the device.

Following clocks, as listed in clock_gettime(2), are supported: CLOCK_REALTIME,
CLOCK_MONOTONIC, CLOCK_MONOTONIC_RAW, CLOCK_REALTIME_COARSE,
CLOCK_MONOTONIC_COARSE, CLOCK_BOOTTIME and CLOCK_TAI.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 Documentation/ABI/testing/sysfs-bus-iio |   7 +++
 Documentation/DocBook/iio.tmpl          |   2 +-
 drivers/iio/iio_core.h                  |   3 +
 drivers/iio/industrialio-core.c         | 107 ++++++++++++++++++++++++++++++--
 drivers/iio/industrialio-event.c        |  19 +++++-
 drivers/iio/industrialio-trigger.c      |   2 +-
 include/linux/iio/iio.h                 |  10 +--
 7 files changed, 134 insertions(+), 16 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 3c66248..4602006 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -32,6 +32,13 @@ Description:
 		Description of the physical chip / device for device X.
 		Typically a part number.
 
+What:		/sys/bus/iio/devices/iio:deviceX/clockid
+KernelVersion:	4.5
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Identifier (clockid_t) of current posix clock used to timestamp
+		buffered samples and events for device X.
+
 What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency
 What:		/sys/bus/iio/devices/iio:deviceX/buffer/sampling_frequency
 What:		/sys/bus/iio/devices/triggerX/sampling_frequency
diff --git a/Documentation/DocBook/iio.tmpl b/Documentation/DocBook/iio.tmpl
index f525bf5..df47dd4 100644
--- a/Documentation/DocBook/iio.tmpl
+++ b/Documentation/DocBook/iio.tmpl
@@ -594,7 +594,7 @@
 
     irqreturn_t sensor_iio_pollfunc(int irq, void *p)
     {
-        pf->timestamp = iio_get_time_ns();
+        pf->timestamp = iio_get_time_ns((struct indio_dev*) p);
         return IRQ_WAKE_THREAD;
     }
 
diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 3598835..a07d2ec 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -79,4 +79,7 @@ void iio_device_unregister_eventset(struct iio_dev *indio_dev);
 void iio_device_wakeup_eventset(struct iio_dev *indio_dev);
 int iio_event_getfd(struct iio_dev *indio_dev);
 
+struct iio_event_interface;
+bool iio_event_enabled(const struct iio_event_interface* ev_int);
+
 #endif
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 70cb7eb..97bdb95 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -174,6 +174,44 @@ ssize_t iio_read_const_attr(struct device *dev,
 }
 EXPORT_SYMBOL(iio_read_const_attr);
 
+/**
+ * iio_get_time_ns() - utility function to get a time stamp for events etc
+ * @indio_dev: device
+ */
+s64 iio_get_time_ns(const struct iio_dev* indio_dev)
+{
+	struct timespec tp;
+
+	switch (indio_dev->clock_id) {
+	case CLOCK_REALTIME:
+		ktime_get_real_ts(&tp);
+		break;
+	case CLOCK_MONOTONIC:
+		ktime_get_ts(&tp);
+		break;
+	case CLOCK_MONOTONIC_RAW:
+		getrawmonotonic(&tp);
+		break;
+	case CLOCK_REALTIME_COARSE:
+		tp = current_kernel_time();
+		break;
+	case CLOCK_MONOTONIC_COARSE:
+		tp = get_monotonic_coarse();
+		break;
+	case CLOCK_BOOTTIME:
+		get_monotonic_boottime(&tp);
+		break;
+	case CLOCK_TAI:
+		timekeeping_clocktai(&tp);
+		break;
+	default:
+		BUG();
+	}
+
+	return timespec_to_ns(&tp);
+}
+EXPORT_SYMBOL(iio_get_time_ns);
+
 static int __init iio_init(void)
 {
 	int ret;
@@ -904,11 +942,61 @@ static ssize_t iio_show_dev_name(struct device *dev,
 
 static DEVICE_ATTR(name, S_IRUGO, iio_show_dev_name, NULL);
 
+static ssize_t iio_show_clockid(struct device *dev,
+                                struct device_attribute *attr, char *buf)
+{
+	const struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	return sprintf(buf, "%d\n", indio_dev->clock_id);
+}
+
+static ssize_t iio_store_clockid(struct device *dev,
+                                 struct device_attribute *attr,
+                                 const char *buf, size_t len)
+{
+	int ret;
+	int clk;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	const struct iio_event_interface *ev_int = indio_dev->event_interface;
+
+	ret = kstrtoint(buf, 0, &clk);
+	if (ret < 0)
+		return ret;
+
+	switch (clk) {
+	case CLOCK_REALTIME:
+	case CLOCK_MONOTONIC:
+	case CLOCK_MONOTONIC_RAW:
+	case CLOCK_REALTIME_COARSE:
+	case CLOCK_MONOTONIC_COARSE:
+	case CLOCK_BOOTTIME:
+	case CLOCK_TAI:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = mutex_lock_interruptible(&indio_dev->mlock);
+	if (ret)
+		return ret;
+	if ((ev_int && iio_event_enabled(ev_int)) ||
+	    iio_buffer_enabled(indio_dev)) {
+		mutex_unlock(&indio_dev->mlock);
+		return -EBUSY;
+	}
+	indio_dev->clock_id = clk;
+	mutex_unlock(&indio_dev->mlock);
+
+	return len;
+}
+
+static DEVICE_ATTR(clockid, S_IRUGO | S_IWUSR,
+                   iio_show_clockid, iio_store_clockid);
+
 static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 {
 	int i, ret = 0, attrcount, attrn, attrcount_orig = 0;
 	struct iio_dev_attr *p;
-	struct attribute **attr;
+	struct attribute **attr, *clk = NULL;
 
 	/* First count elements in any existing group */
 	if (indio_dev->info->attrs) {
@@ -923,16 +1011,25 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 	 */
 	if (indio_dev->channels)
 		for (i = 0; i < indio_dev->num_channels; i++) {
-			ret = iio_device_add_channel_sysfs(indio_dev,
-							   &indio_dev
-							   ->channels[i]);
+			const struct iio_chan_spec *chan =
+				&indio_dev->channels[i];
+
+			if (chan->type == IIO_TIMESTAMP)
+				clk = &dev_attr_clockid.attr;
+
+			ret = iio_device_add_channel_sysfs(indio_dev, chan);
 			if (ret < 0)
 				goto error_clear_attrs;
 			attrcount += ret;
 		}
 
+	if (indio_dev->event_interface)
+		clk = &dev_attr_clockid.attr;
+
 	if (indio_dev->name)
 		attrcount++;
+	if (clk)
+		attrcount++;
 
 	indio_dev->chan_attr_group.attrs = kcalloc(attrcount + 1,
 						   sizeof(indio_dev->chan_attr_group.attrs[0]),
@@ -953,6 +1050,8 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 		indio_dev->chan_attr_group.attrs[attrn++] = &p->dev_attr.attr;
 	if (indio_dev->name)
 		indio_dev->chan_attr_group.attrs[attrn++] = &dev_attr_name.attr;
+	if (clk)
+		indio_dev->chan_attr_group.attrs[attrn++] = clk;
 
 	indio_dev->groups[indio_dev->groupcounter++] =
 		&indio_dev->chan_attr_group;
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index cae332b..9480404 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -44,6 +44,11 @@ struct iio_event_interface {
 	struct mutex		read_lock;
 };
 
+bool iio_event_enabled(const struct iio_event_interface* ev_int)
+{
+	return !! test_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
+}
+
 /**
  * iio_push_event() - try to add event to the list for userspace reading
  * @indio_dev:		IIO device structure
@@ -60,7 +65,7 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
 	int copied;
 
 	/* Does anyone care? */
-	if (test_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
+	if (iio_event_enabled(ev_int)) {
 
 		ev.id = ev_code;
 		ev.timestamp = timestamp;
@@ -180,8 +185,14 @@ int iio_event_getfd(struct iio_dev *indio_dev)
 	if (ev_int == NULL)
 		return -ENODEV;
 
-	if (test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags))
-		return -EBUSY;
+	fd = mutex_lock_interruptible(&indio_dev->mlock);
+	if (fd)
+		return fd;
+
+	if (test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
+		fd = -EBUSY;
+		goto unlock;
+	}
 
 	iio_device_get(indio_dev);
 
@@ -194,6 +205,8 @@ int iio_event_getfd(struct iio_dev *indio_dev)
 		kfifo_reset_out(&ev_int->det_events);
 	}
 
+unlock:
+	mutex_unlock(&indio_dev->mlock);
 	return fd;
 }
 
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index ae2806a..cf93717 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -251,7 +251,7 @@ static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
 irqreturn_t iio_pollfunc_store_time(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
-	pf->timestamp = iio_get_time_ns();
+	pf->timestamp = iio_get_time_ns(pf->indio_dev);
 	return IRQ_WAKE_THREAD;
 }
 EXPORT_SYMBOL(iio_pollfunc_store_time);
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index ce9e9c1..904a5b0 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -281,13 +281,7 @@ static inline bool iio_channel_has_info(const struct iio_chan_spec *chan,
 		},							\
 }
 
-/**
- * iio_get_time_ns() - utility function to get a time stamp for events etc
- **/
-static inline s64 iio_get_time_ns(void)
-{
-	return ktime_get_real_ns();
-}
+extern s64 iio_get_time_ns(const struct iio_dev*);
 
 /* Device operating modes */
 #define INDIO_DIRECT_MODE		0x01
@@ -466,6 +460,7 @@ struct iio_buffer_setup_ops {
  * @chan_attr_group:	[INTERN] group for all attrs in base directory
  * @name:		[DRIVER] name of the device.
  * @info:		[DRIVER] callbacks and constant info from driver
+ * @clock_id:		[INTERN] timestamping clock posix identifier
  * @info_exist_lock:	[INTERN] lock to prevent use during removal
  * @setup_ops:		[DRIVER] callbacks to call before and after buffer
  *			enable/disable
@@ -506,6 +501,7 @@ struct iio_dev {
 	struct attribute_group		chan_attr_group;
 	const char			*name;
 	const struct iio_info		*info;
+	clockid_t			clock_id;
 	struct mutex			info_exist_lock;
 	const struct iio_buffer_setup_ops	*setup_ops;
 	struct cdev			chrdev;
-- 
2.1.4

