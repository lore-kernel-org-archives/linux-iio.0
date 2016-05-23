Return-Path: <leonard.crestez@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [RFC 4/7] iio: Add current_trigger_id alternative
Date: Mon, 23 May 2016 21:39:59 +0300
Message-Id: <0f8ba32f5714db12b798621cb805636d29a1aa02.1464027859.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1464027859.git.leonard.crestez@intel.com>
References: <cover.1464027859.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1464027859.git.leonard.crestez@intel.com>
References: <cover.1464027859.git.leonard.crestez@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This allows controlling the current trigger by numeric ID rather than
name.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio |   9 +++
 Documentation/DocBook/iio.tmpl          |   4 +-
 drivers/iio/industrialio-trigger.c      | 115 ++++++++++++++++++++++++--------
 3 files changed, 98 insertions(+), 30 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index df44998..e276032 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1038,6 +1038,15 @@ Description:
 		The name of the trigger source being used, as per string given
 		in /sys/class/iio/triggerY/name.
 
+What:		/sys/bus/iio/devices/iio:deviceX/trigger/current_trigger_id
+KernelVersion:	4.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The id of the trigger source being used. This is the Y from
+		/sys/class/iio/triggerY. This is an alternative to
+		/sys/bus/iio/devices/iio:deviceX/trigger/current_trigger.
+		Write a negative number to clear.
+
 What:		/sys/bus/iio/devices/iio:deviceX/buffer/length
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
diff --git a/Documentation/DocBook/iio.tmpl b/Documentation/DocBook/iio.tmpl
index f525bf5..599eff0 100644
--- a/Documentation/DocBook/iio.tmpl
+++ b/Documentation/DocBook/iio.tmpl
@@ -523,7 +523,9 @@
           <filename>/sys/bus/iio/devices/iio:deviceX/trigger/</filename>, this
           directory is created once the device supports a triggered
           buffer. We can associate a trigger with our device by writing
-          the trigger's name in the <filename>current_trigger</filename> file.
+          the trigger's name in the <filename>current_trigger</filename>
+          file. Alternatively we can write the numeric id Y from
+          triggerY into <filename>current_trigger_id</filename>
         </listitem>
       </itemizedlist>
     </sect2>
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index ae2806a..e79c64c 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -121,6 +121,21 @@ static struct iio_trigger *iio_trigger_find_by_name(const char *name,
 	return trig;
 }
 
+static struct iio_trigger *iio_trigger_find_by_id(int id)
+{
+	struct iio_trigger *trig = NULL, *iter;
+
+	mutex_lock(&iio_trigger_list_lock);
+	list_for_each_entry(iter, &iio_trigger_list, list)
+		if (iter->id == id) {
+			trig = iter;
+			break;
+		}
+	mutex_unlock(&iio_trigger_list_lock);
+
+	return trig;
+}
+
 void iio_trigger_poll(struct iio_trigger *trig)
 {
 	int i;
@@ -294,7 +309,7 @@ void iio_dealloc_pollfunc(struct iio_poll_func *pf)
 EXPORT_SYMBOL_GPL(iio_dealloc_pollfunc);
 
 /**
- * iio_trigger_read_current() - trigger consumer sysfs query current trigger
+ * iio_trigger_read_current_name() - trigger consumer sysfs query current trigger
  * @dev:	device associated with an industrial I/O device
  * @attr:	pointer to the device_attribute structure that
  *		is being processed
@@ -306,9 +321,9 @@ EXPORT_SYMBOL_GPL(iio_dealloc_pollfunc);
  * Return: a negative number on failure, the number of characters written
  *	   on success or 0 if no trigger is available
  */
-static ssize_t iio_trigger_read_current(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
+static ssize_t iio_trigger_read_current_name(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 
@@ -317,28 +332,22 @@ static ssize_t iio_trigger_read_current(struct device *dev,
 	return 0;
 }
 
-/**
- * iio_trigger_write_current() - trigger consumer sysfs set current trigger
- * @dev:	device associated with an industrial I/O device
- * @attr:	device attribute that is being processed
- * @buf:	string buffer that holds the name of the trigger
- * @len:	length of the trigger name held by buf
- *
- * For trigger consumers the current_trigger interface allows the trigger
- * used for this device to be specified at run time based on the trigger's
- * name.
- *
- * Return: negative error code on failure or length of the buffer
- *	   on success
- */
-static ssize_t iio_trigger_write_current(struct device *dev,
-					 struct device_attribute *attr,
-					 const char *buf,
-					 size_t len)
+static ssize_t iio_trigger_read_current_id(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+
+	if (indio_dev->trig)
+		return sprintf(buf, "%d\n", indio_dev->trig->id);
+	return 0;
+}
+
+/* Set current trigger. Returns -errno or 0 on success */
+static int iio_trigger_set_current(struct iio_dev *indio_dev,
+				   struct iio_trigger *trig)
+{
 	struct iio_trigger *oldtrig = indio_dev->trig;
-	struct iio_trigger *trig;
 	int ret;
 
 	mutex_lock(&indio_dev->mlock);
@@ -348,18 +357,24 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 	}
 	mutex_unlock(&indio_dev->mlock);
 
-	trig = iio_trigger_find_by_name(buf, len);
-	if (oldtrig == trig)
-		return len;
-
 	if (trig && indio_dev->info->validate_trigger) {
 		ret = indio_dev->info->validate_trigger(indio_dev, trig);
+		if (ret > 0) {
+			dev_err(&indio_dev->dev, "validate_trigger %ps incorrectly returned positive %d\n",
+				indio_dev->info->validate_trigger, ret);
+			return -EINVAL;
+		}
 		if (ret)
 			return ret;
 	}
 
 	if (trig && trig->ops && trig->ops->validate_device) {
 		ret = trig->ops->validate_device(trig, indio_dev);
+		if (ret > 0) {
+			dev_err(&indio_dev->dev, "validate_device %ps incorrectly returned positive %d\n",
+				trig->ops->validate_device, ret);
+			return -EINVAL;
+		}
 		if (ret)
 			return ret;
 	}
@@ -379,15 +394,57 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 						     indio_dev->pollfunc_event);
 	}
 
+	return 0;
+}
+
+static ssize_t iio_trigger_write_current_name(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf,
+					      size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_trigger *trig;
+	int ret;
+
+	trig = iio_trigger_find_by_name(buf, len);
+	ret = iio_trigger_set_current(indio_dev, trig);
+
+	return ret ? ret : len;
+}
+
+static ssize_t iio_trigger_write_current_id(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf,
+					    size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_trigger *trig;
+	int ret, id;
+
+	ret = kstrtoint(buf, 10, &id);
+	if (ret)
+		return ret;
+	if (id >= 0) {
+		trig = iio_trigger_find_by_id(id);
+		if (!trig)
+			return -ENOENT;
+	} else
+		trig = NULL;
+	ret = iio_trigger_set_current(indio_dev, trig);
+
 	return len;
 }
 
 static DEVICE_ATTR(current_trigger, S_IRUGO | S_IWUSR,
-		   iio_trigger_read_current,
-		   iio_trigger_write_current);
+		   iio_trigger_read_current_name,
+		   iio_trigger_write_current_name);
+static DEVICE_ATTR(current_trigger_id, S_IRUGO | S_IWUSR,
+		   iio_trigger_read_current_id,
+		   iio_trigger_write_current_id);
 
 static struct attribute *iio_trigger_consumer_attrs[] = {
 	&dev_attr_current_trigger.attr,
+	&dev_attr_current_trigger_id.attr,
 	NULL,
 };
 
-- 
2.5.5
