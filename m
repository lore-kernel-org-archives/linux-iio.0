Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 5/5] staging:iio::hwmon interface client driver.
Date: Sun, 27 Nov 2011 13:14:02 +0000
Message-Id: <1322399642-22924-6-git-send-email-jic23@kernel.org>
In-Reply-To: <1322399642-22924-1-git-send-email-jic23@kernel.org>
References: <1322399642-22924-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@cam.ac.uk>

Direct copy of version proposed for the non staging branch.
Needed here to allow testing of more advanced inkernel
interface code.

Minimal support of simple in, curr and temp attributes
so far.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Kconfig     |    8 ++
 drivers/staging/iio/Makefile    |    2 +
 drivers/staging/iio/iio_hwmon.c |  225 +++++++++++++++++++++++++++++++++++++++
 drivers/staging/iio/types.h     |    4 +
 4 files changed, 239 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index 90162aa..f2c5db6 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -12,6 +12,14 @@ menuconfig IIO
 	  drivers/staging/iio/Documentation for more information.
 if IIO
 
+config IIO_ST_HWMON
+	tristate "Hwmon driver that uses channels specified via iio maps"
+	depends on HWMON
+	help
+	  This is a platform driver that in combination with a suitable
+	  map allows IIO devices to provide  basic hwmon functionality
+	  for those channels specified in the map.
+
 config IIO_BUFFER
 	bool "Enable buffer support within IIO"
 	help
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 04d6ad2..d5ca5cf 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -17,6 +17,8 @@ iio_dummy-$(CONFIG_IIO_SIMPLE_DUMMY_BUFFER) += iio_simple_dummy_buffer.o
 
 obj-$(CONFIG_IIO_DUMMY_EVGEN) += iio_dummy_evgen.o
 
+obj-$(CONFIG_IIO_ST_HWMON) += iio_hwmon.o
+
 obj-y += accel/
 obj-y += adc/
 obj-y += addac/
diff --git a/drivers/staging/iio/iio_hwmon.c b/drivers/staging/iio/iio_hwmon.c
new file mode 100644
index 0000000..de610c0
--- /dev/null
+++ b/drivers/staging/iio/iio_hwmon.c
@@ -0,0 +1,225 @@
+/* Hwmon client for industrial I/O devices
+ *
+ * Copyright (c) 2011 Jonathan Cameron
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include "inkern.h"
+
+/**
+ * struct iio_hwmon_state - device instance state
+ * @channels:		filled with null terminated array of channels from iio
+ * @num_channels:	number of channels in channels (saves counting twice)
+ * @hwmon_dev:		associated hwmon device
+ * @attr_group:	the group of attributes
+ * @attrs:		null terminated array of attribute pointers.
+ */
+struct iio_hwmon_state {
+	struct iio_channel **channels;
+	int num_channels;
+	struct device *hwmon_dev;
+	struct attribute_group attr_group;
+	struct attribute **attrs;
+};
+
+/*
+ * Assumes that IIO and hwmon operate in the same base units.
+ * This is supposed to be true, but needs verification for
+ * new channel types.
+ */
+static ssize_t iio_hwmon_read_val(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	long result;
+	int val, ret, scaleint, scalepart;
+	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
+	struct iio_hwmon_state *state = dev_get_drvdata(dev);
+
+	/*
+	 * No locking between this pair, so theoretically possible
+	 * the scale has changed.
+	 */
+	ret = iio_st_read_channel_raw(state->channels[sattr->index],
+				      &val);
+	if (ret < 0)
+		return ret;
+
+	ret = iio_st_read_channel_scale(state->channels[sattr->index],
+					&scaleint, &scalepart);
+	if (ret < 0)
+		return ret;
+	switch (ret) {
+	case IIO_VAL_INT:
+		result = val * scaleint;
+		break;
+	case IIO_VAL_INT_PLUS_MICRO:
+		result = (s64)val * (s64)scaleint +
+			div_s64((s64)val * (s64)scalepart, 1000000LL);
+		break;
+	case IIO_VAL_INT_PLUS_NANO:
+		result = (s64)val * (s64)scaleint +
+			div_s64((s64)val * (s64)scalepart, 1000000000LL);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return sprintf(buf, "%ld\n", result);
+}
+
+static void iio_hwmon_free_attrs(struct iio_hwmon_state *st)
+{
+	int i;
+	struct sensor_device_attribute *a;
+	for (i = 0; i < st->num_channels; i++)
+		if (st->attrs[i]) {
+			a = to_sensor_dev_attr(
+				container_of(st->attrs[i],
+					     struct device_attribute,
+					     attr));
+			kfree(a);
+		}
+}
+
+static int __devinit iio_hwmon_probe(struct platform_device *pdev)
+{
+	struct iio_hwmon_state *st;
+	struct sensor_device_attribute *a;
+	int ret, i;
+	int in_i = 1, temp_i = 1, curr_i = 1;
+
+	st = kzalloc(sizeof(*st), GFP_KERNEL);
+	if (st == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	st->channels = iio_st_channel_get_all(&pdev->dev, NULL);
+	if (IS_ERR(st->channels)) {
+		ret = PTR_ERR(st->channels);
+		goto error_free_state;
+	}
+
+	/* count how many attributes we have */
+	while (st->channels[st->num_channels])
+		st->num_channels++;
+
+	st->attrs = kzalloc(sizeof(st->attrs) * (st->num_channels + 1),
+			    GFP_KERNEL);
+	if (st->attrs == NULL) {
+		ret = -ENOMEM;
+		goto error_release_channels;
+	}
+	for (i = 0; i < st->num_channels; i++) {
+		a = kzalloc(sizeof(*a), GFP_KERNEL);
+		if (a == NULL) {
+			ret = -ENOMEM;
+			goto error_free_attrs;
+		}
+
+		sysfs_attr_init(&a->dev_attr.attr);
+		switch (iio_st_get_channel_type(st->channels[i])) {
+		case IIO_VOLTAGE:
+			a->dev_attr.attr.name = kasprintf(GFP_KERNEL,
+							  "in%d_input",
+							  in_i++);
+			break;
+		case IIO_TEMP:
+			a->dev_attr.attr.name = kasprintf(GFP_KERNEL,
+							  "temp%d_input",
+							  temp_i++);
+			break;
+		case IIO_CURRENT:
+			a->dev_attr.attr.name = kasprintf(GFP_KERNEL,
+							  "curr%d_input",
+							  curr_i++);
+			break;
+		default:
+			ret = -EINVAL;
+			kfree(a);
+			goto error_free_attrs;
+		}
+		if (a->dev_attr.attr.name == NULL) {
+			kfree(a);
+			ret = -ENOMEM;
+			goto error_free_attrs;
+		}
+		a->dev_attr.show = iio_hwmon_read_val;
+		a->dev_attr.attr.mode = S_IRUGO;
+		a->index = i;
+		st->attrs[i] = &a->dev_attr.attr;
+	}
+
+	st->attr_group.attrs = st->attrs;
+	platform_set_drvdata(pdev, st);
+	ret = sysfs_create_group(&pdev->dev.kobj, &st->attr_group);
+	if (ret < 0)
+		goto error_free_attrs;
+
+	st->hwmon_dev = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(st->hwmon_dev)) {
+		ret = PTR_ERR(st->hwmon_dev);
+		goto error_remove_group;
+	}
+	return 0;
+
+error_remove_group:
+	sysfs_remove_group(&pdev->dev.kobj, &st->attr_group);
+error_free_attrs:
+	iio_hwmon_free_attrs(st);
+	kfree(st->attrs);
+error_release_channels:
+	iio_st_channel_release_all(st->channels);
+error_free_state:
+	kfree(st);
+error_ret:
+	return ret;
+}
+
+static int __devexit iio_hwmon_remove(struct platform_device *pdev)
+{
+	struct iio_hwmon_state *st = platform_get_drvdata(pdev);
+
+	hwmon_device_unregister(st->hwmon_dev);
+	sysfs_remove_group(&pdev->dev.kobj, &st->attr_group);
+	iio_hwmon_free_attrs(st);
+	kfree(st->attrs);
+	iio_st_channel_release_all(st->channels);
+
+	return 0;
+}
+
+static struct platform_driver __refdata iio_hwmon_driver = {
+	.driver = {
+		.name = "iio_hwmon",
+		.owner = THIS_MODULE,
+	},
+	.probe = iio_hwmon_probe,
+	.remove = __devexit_p(iio_hwmon_remove),
+};
+
+static int iio_inkern_init(void)
+{
+	return platform_driver_register(&iio_hwmon_driver);
+}
+module_init(iio_inkern_init);
+
+static void iio_inkern_exit(void)
+{
+	platform_driver_unregister(&iio_hwmon_driver);
+}
+module_exit(iio_inkern_exit);
+
+MODULE_AUTHOR("Jonathan Cameron <jic23@cam.ac.uk>");
+MODULE_DESCRIPTION("IIO to hwmon driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/types.h b/drivers/staging/iio/types.h
index f1f5ca2..b2ab217 100644
--- a/drivers/staging/iio/types.h
+++ b/drivers/staging/iio/types.h
@@ -46,4 +46,8 @@ enum iio_modifier {
 	IIO_MOD_LIGHT_IR,
 };
 
+#define IIO_VAL_INT 1
+#define IIO_VAL_INT_PLUS_MICRO 2
+#define IIO_VAL_INT_PLUS_NANO 3
+
 #endif /* _IIO_TYPES_H_ */
-- 
1.7.7.3
