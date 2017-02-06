Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38700 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752321AbdBFOWI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Feb 2017 09:22:08 -0500
Received: by mail-wm0-f50.google.com with SMTP id r141so116024350wmg.1
        for <linux-iio@vger.kernel.org>; Mon, 06 Feb 2017 06:22:07 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: linux-kernel@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: fabrice.gasnier@st.com, linaro-kernel@lists.linaro.org,
        benjamin.gaignard@linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v1 1/2] iio: Allow triggers to be used as parent of others triggers
Date: Mon,  6 Feb 2017 15:21:51 +0100
Message-Id: <1486390912-24362-2-git-send-email-benjamin.gaignard@st.com>
In-Reply-To: <1486390912-24362-1-git-send-email-benjamin.gaignard@st.com>
References: <1486390912-24362-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add "parent_trigger" sysfs attribute to iio trigger to be able
to set a parent to the current trigger.
Introduce validate_trigger function in iio_trigger_ops which does
the same than validate_device but with a trigger as second parameter.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../ABI/testing/sysfs-bus-iio-trigger-sysfs        |  8 +++
 drivers/iio/industrialio-trigger.c                 | 68 ++++++++++++++++++++++
 include/linux/iio/trigger.h                        |  6 +-
 3 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs b/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
index 04ac623..179fc0c 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
+++ b/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
@@ -40,3 +40,11 @@ Description:
 		associated file, representing the id of the trigger that needs
 		to be removed. If the trigger can't be found, an invalid
 		argument message will be returned to the user.
+
+What:		/sys/bus/iio/devices/triggerX/parent_trigger
+KernelVersion:	4.12
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute is used to set a trigger as parent for the
+		current trigger. If the trigger can't use the parent an
+		invalid argument message will be returned.
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 978729f..5eda996 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -58,8 +58,76 @@ static ssize_t iio_trigger_read_name(struct device *dev,
 
 static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
 
+/**
+ * iio_trigger_read_parent() - trigger consumer sysfs query parent trigger
+ * @dev:	device associated with an industrial I/O trigger
+ * @attr:	pointer to the device_attribute structure that
+ *		is being processed
+ * @buf:	buffer where the current trigger name will be printed into
+ *
+ * Return: a negative number on failure, the number of characters written
+ *	   on success or 0 if no trigger is available
+ */
+static ssize_t iio_trigger_read_parent(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct iio_trigger *trig = to_iio_trigger(dev);
+
+	if (trig->parent_trigger)
+		return sprintf(buf, "%s\n", trig->parent_trigger->name);
+
+	return 0;
+}
+
+static struct iio_trigger *iio_trigger_find_by_name(const char *name,
+						    size_t len);
+
+/**
+ * iio_trigger_write_parent() - trigger consumer sysfs set parent trigger
+ * @dev:	device associated with an industrial I/O trigger
+ * @attr:	device attribute that is being processed
+ * @buf:	string buffer that holds the name of the trigger
+ * @len:	length of the trigger name held by buf
+ *
+ * Return: negative error code on failure or length of the buffer
+ *	   on success
+ */
+static ssize_t iio_trigger_write_parent(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t len)
+{
+	struct iio_trigger *parent;
+	struct iio_trigger *child = to_iio_trigger(dev);
+	int ret;
+
+	if (!child->ops->validate_trigger)
+		return -EINVAL;
+
+	if (atomic_read(&child->use_count))
+		return -EBUSY;
+
+	parent = iio_trigger_find_by_name(buf, len);
+
+	if (parent == child->parent_trigger)
+		return len;
+
+	ret = child->ops->validate_trigger(child, parent);
+	if (ret)
+		return ret;
+
+	child->parent_trigger = parent;
+
+	return len;
+}
+static DEVICE_ATTR(parent_trigger, S_IRUGO | S_IWUSR,
+		   iio_trigger_read_parent,
+		   iio_trigger_write_parent);
+
 static struct attribute *iio_trig_dev_attrs[] = {
 	&dev_attr_name.attr,
+	&dev_attr_parent_trigger.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(iio_trig_dev);
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index ea08302..16e39ee 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -29,6 +29,7 @@ struct iio_subirq {
  *			use count is zero (may be NULL)
  * @validate_device:	function to validate the device when the
  *			current trigger gets changed.
+ * @validate_trigger:	function to validate the parent trigger (may be NULL)
  *
  * This is typically static const within a driver and shared by
  * instances of a given device.
@@ -39,9 +40,10 @@ struct iio_trigger_ops {
 	int (*try_reenable)(struct iio_trigger *trig);
 	int (*validate_device)(struct iio_trigger *trig,
 			       struct iio_dev *indio_dev);
+	int (*validate_trigger)(struct iio_trigger *trig,
+				struct iio_trigger *parent);
 };
 
-
 /**
  * struct iio_trigger - industrial I/O trigger device
  * @ops:		[DRIVER] operations structure
@@ -59,6 +61,7 @@ struct iio_trigger_ops {
  * @attached_own_device:[INTERN] if we are using our own device as trigger,
  *			i.e. if we registered a poll function to the same
  *			device as the one providing the trigger.
+ * @parent_trigger:	[INTERN] parent trigger
  **/
 struct iio_trigger {
 	const struct iio_trigger_ops	*ops;
@@ -77,6 +80,7 @@ struct iio_trigger {
 	unsigned long pool[BITS_TO_LONGS(CONFIG_IIO_CONSUMERS_PER_TRIGGER)];
 	struct mutex			pool_lock;
 	bool				attached_own_device;
+	struct iio_trigger		*parent_trigger;
 };
 
 
-- 
1.9.1

