Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 53/99] staging:iio: Add core attribute handling for name of device.
Date: Wed,  4 May 2011 12:58:25 +0100
Message-Id: <1304510351-10922-54-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Saves on a fair bit of code replication.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |    2 +-
 drivers/staging/iio/industrialio-core.c |   23 ++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 88e19f8..914ced7 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -249,7 +249,7 @@ struct iio_dev {
 	int num_channels;
 	struct list_head channel_attr_list;
 
-	char *name; /*device name - IMPLEMENT */
+	const char *name;
 	int (*read_raw)(struct iio_dev *indio_dev,
 			struct iio_chan_spec const *chan,
 			int *val,
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 52188f9..e943dac 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -688,6 +688,16 @@ static void iio_device_remove_and_free_read_attr(struct iio_dev *dev_info,
 	kfree(p);
 }
 
+static ssize_t iio_show_dev_name(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	return sprintf(buf, "%s\n", indio_dev->name);
+}
+
+static DEVICE_ATTR(name, S_IRUGO, iio_show_dev_name, NULL);
+
 static int iio_device_register_sysfs(struct iio_dev *dev_info)
 {
 	int i, ret = 0;
@@ -715,8 +725,15 @@ static int iio_device_register_sysfs(struct iio_dev *dev_info)
 			if (ret < 0)
 				goto error_clear_attrs;
 		}
-
+	if (dev_info->name) {
+		ret = sysfs_add_file_to_group(&dev_info->dev.kobj,
+					      &dev_attr_name.attr,
+					      NULL);
+		if (ret)
+			goto error_clear_attrs;
+	}
 	return 0;
+
 error_clear_attrs:
 	list_for_each_entry_safe(p, n,
 				 &dev_info->channel_attr_list, l) {
@@ -734,6 +751,10 @@ static void iio_device_unregister_sysfs(struct iio_dev *dev_info)
 {
 
 	struct iio_dev_attr *p, *n;
+	if (dev_info->name)
+		sysfs_remove_file_from_group(&dev_info->dev.kobj,
+					     &dev_attr_name.attr,
+					     NULL);
 	list_for_each_entry_safe(p, n, &dev_info->channel_attr_list, l) {
 		list_del(&p->l);
 		iio_device_remove_and_free_read_attr(dev_info, p);
-- 
1.7.3.4
