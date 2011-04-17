Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 53/70] staging:iio: Add core attribute handling for name of device.
Date: Sun, 17 Apr 2011 20:06:26 +0100
Message-Id: <1303067203-4894-54-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
References: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Saves on a fair bit of code replication.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |    2 +-
 drivers/staging/iio/industrialio-core.c |   36 ++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index b818f5f..febf20e 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -231,7 +231,7 @@ struct iio_dev {
 	int num_channels;
 	struct list_head channel_attr_list;
 
-	char *name; /*device name - IMPLEMENT */
+	const char *name;
 	int (*read_raw)(struct iio_dev *indio_dev,
 			struct iio_chan_spec const *chan,
 			int *val,
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 2e2e51d..67e7ade 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -610,6 +610,13 @@ static void iio_device_remove_and_free_read_attr(struct iio_dev *dev_info,
 	kfree(p->dev_attr.attr.name);
 	kfree(p);
 }
+static ssize_t iio_show_dev_name(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	return sprintf(buf, "%s\n", indio_dev->name);
+}
 
 static int iio_device_register_sysfs(struct iio_dev *dev_info)
 {
@@ -638,8 +645,35 @@ static int iio_device_register_sysfs(struct iio_dev *dev_info)
 			if (ret < 0)
 				goto error_clear_attrs;
 		}
-
+	if (dev_info->name) {
+		p = kzalloc(sizeof *p, GFP_KERNEL);
+		if (p == NULL) {
+			ret = -ENOMEM;
+			goto error_clear_attrs;
+		}
+		sysfs_attr_init(&p->dev_attr.attr);
+	
+		p->dev_attr.attr.name = kstrdup("name", GFP_KERNEL);
+		if (p->dev_attr.attr.name == NULL) {
+			ret = -ENOMEM;
+			kfree(p);
+			goto error_free_attr;
+		}
+		p->dev_attr.attr.mode = S_IRUGO;
+		p->dev_attr.show = &iio_show_dev_name;
+		ret = sysfs_add_file_to_group(&dev_info->dev.kobj,
+					      &p->dev_attr.attr, NULL);
+		if (ret < 0)
+			goto error_free_name_name;	
+		
+		list_add(&p->l, &dev_info->channel_attr_list);
+	}
 	return 0;
+
+error_free_name_name:
+	kfree(p->dev_attr.attr.name);
+error_free_attr:
+	kfree(p);
 error_clear_attrs:
 	list_for_each_entry_safe(p, n,
 				 &dev_info->channel_attr_list, l) {
-- 
1.7.3.4
