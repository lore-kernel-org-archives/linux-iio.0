Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30857 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993295AbcBSTUT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 19 Feb 2016 14:20:19 -0500
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	=?UTF-8?q?Gr=C3=A9gor=20Boirie?= <gregor.boirie@parrot.com>
Subject: [PATCH v1 2/2] iio:iio-interrupt-trigger: sysfs poll support
Date: Fri, 19 Feb 2016 20:18:44 +0100
Message-ID: <87bbff0671c93b998547114d7f595a0bee57e817.1455908065.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1455908065.git.gregor.boirie@parrot.com>
References: <cover.1455908065.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Grégor Boirie <gregor.boirie@parrot.com>

Add a sysfs file entry for each interrupt trigger instance allowing
userspace to :
* poll for interrupt events ;
* retrieve number of interrupts that occurred since trigger was
* initialized

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 .../ABI/testing/sysfs-bus-iio-trig-interrupt       | 22 ++++++
 drivers/iio/trigger/iio-trig-interrupt.c           | 88 ++++++++++++++++------
 2 files changed, 88 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-trig-interrupt

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-trig-interrupt b/Documentation/ABI/testing/sysfs-bus-iio-trig-interrupt
new file mode 100644
index 0000000..cb246d2
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-trig-interrupt
@@ -0,0 +1,22 @@
+What:		/sys/bus/iio/devices/triggerX/name
+KernelVersion:	3.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The name attribute holds a description string for the current
+		trigger. In order to associate the trigger with an IIO device
+		one should write this name string to
+		/sys/bus/iio/devices/iio:deviceY/trigger/current_trigger.
+
+What:		/sys/bus/iio/devices/triggerX/count
+KernelVersion:	4.5
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The count attribute is a unsigned int counter holding the number
+		of times the attached interrupt occurred since trigger was
+		initialized.
+		You can poll(2) on that file and poll(2) will return whenever
+		the interrupt was triggered. If you use poll(2), set the events
+		POLLPRI and POLLERR. If you use select(2), set the file
+		descriptor in exceptfds. After poll(2) returns, either lseek(2)
+		to the beginning of the sysfs file and read the new value or
+		close the file and re-open it to read the value.
diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
index 3c4e18f..1bf3986 100644
--- a/drivers/iio/trigger/iio-trig-interrupt.c
+++ b/drivers/iio/trigger/iio-trig-interrupt.c
@@ -17,14 +17,53 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
 
-
 struct iio_interrupt_trigger_info {
+	struct kernfs_node *poll;
+	atomic_t count;
 	unsigned int irq;
 };
 
+/*
+ * If interested by counter value, userspace should read often enough since
+ * counter may wrap. Userspace will miss interrupt events when counter wraps
+ * twice or more between 2 consecutive reads.
+ */
+ssize_t iio_interrupt_trigger_show_count(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct iio_trigger *trig = to_iio_trigger(dev);
+	struct iio_interrupt_trigger_info *info = iio_trigger_get_drvdata(trig);
+	unsigned int count = atomic_read(&info->count);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", count);
+}
+
+static DEVICE_ATTR(count, S_IRUGO, iio_interrupt_trigger_show_count, NULL);
+
+static struct attribute *iio_interrupt_trigger_attrs[] = {
+	&dev_attr_count.attr,
+	NULL,
+};
+
+static const struct attribute_group iio_interrupt_trigger_attr_group = {
+	.attrs = iio_interrupt_trigger_attrs,
+};
+
+static const struct attribute_group *iio_interrupt_trigger_attr_groups[] = {
+	&iio_interrupt_trigger_attr_group,
+	NULL
+};
+
 static irqreturn_t iio_interrupt_trigger_poll(int irq, void *private)
 {
-	iio_trigger_poll(private);
+	struct iio_trigger *trig = private;
+	struct iio_interrupt_trigger_info *info = iio_trigger_get_drvdata(trig);
+
+	atomic_inc(&info->count);
+	sysfs_notify_dirent(info->poll);
+	iio_trigger_poll(trig);
+
 	return IRQ_HANDLED;
 }
 
@@ -36,17 +75,12 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
 {
 	struct iio_interrupt_trigger_info *trig_info;
 	struct iio_trigger *trig;
-	unsigned long irqflags;
 	struct resource *irq_res;
 	int irq, ret = 0;
 
 	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-
-	if (irq_res == NULL)
+	if (!irq_res)
 		return -ENODEV;
-
-	irqflags = (irq_res->flags & IRQF_TRIGGER_MASK) | IRQF_SHARED;
-
 	irq = irq_res->start;
 
 	trig = iio_trigger_alloc("irqtrig%d", irq);
@@ -60,27 +94,36 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto error_put_trigger;
 	}
-	iio_trigger_set_drvdata(trig, trig_info);
+
+	atomic_set(&trig_info->count, 0);
 	trig_info->irq = irq;
+	iio_trigger_set_drvdata(trig, trig_info);
 	trig->ops = &iio_interrupt_trigger_ops;
-	ret = request_irq(irq, iio_interrupt_trigger_poll,
-			  irqflags, trig->name, trig);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"request IRQ-%d failed", irq);
+	trig->dev.groups = iio_interrupt_trigger_attr_groups;
+	ret = iio_trigger_register(trig);
+	if (ret)
 		goto error_free_trig_info;
+
+	/* Create a sysfs entry which the userspace may poll for irq events. */
+	trig_info->poll = sysfs_get_dirent(trig->dev.kobj.sd, "count");
+	if (!trig_info->poll) {
+		ret = -ENOENT;
+		goto error_unregister_trig;
 	}
 
-	ret = iio_trigger_register(trig);
-	if (ret)
-		goto error_release_irq;
-	platform_set_drvdata(pdev, trig);
+	ret = request_irq(irq, iio_interrupt_trigger_poll,
+			  (irq_res->flags & IRQF_TRIGGER_MASK) | IRQF_SHARED,
+			  trig->name, trig);
+	if (!ret) {
+		platform_set_drvdata(pdev, trig);
+		return 0;
+	}
 
-	return 0;
+	sysfs_put(trig_info->poll);
 
 /* First clean up the partly allocated trigger */
-error_release_irq:
-	free_irq(irq, trig);
+error_unregister_trig:
+	iio_trigger_unregister(trig);
 error_free_trig_info:
 	kfree(trig_info);
 error_put_trigger:
@@ -96,8 +139,9 @@ static int iio_interrupt_trigger_remove(struct platform_device *pdev)
 
 	trig = platform_get_drvdata(pdev);
 	trig_info = iio_trigger_get_drvdata(trig);
-	iio_trigger_unregister(trig);
 	free_irq(trig_info->irq, trig);
+	sysfs_put(trig_info->poll);
+	iio_trigger_unregister(trig);
 	kfree(trig_info);
 	iio_trigger_put(trig);
 
-- 
2.1.4

